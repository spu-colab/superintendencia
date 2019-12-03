<?php

namespace App\Http\Controllers;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Validator;
use JWTFactory;
use JWTAuth;
use App\User;
use Illuminate\Support\Facades\Auth;
use Adldap\Laravel\Facades\Adldap;
use Illuminate\Support\Facades\Hash;

class APILoginController extends Controller
{
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'cpf' => 'required', // 'required|string|email|max:255',
            'password'=> 'required'
        ]);
        if ($validator->fails()) {
            return response()->json($validator->errors());
        }
        $credentials = $request->only('cpf', 'password');

        $usuarioLDAP = $this->valida_ldap($credentials['cpf'], $credentials['password']);
        if(!$usuarioLDAP) {
            return response()->json(['error' => 'invalid_credentials_ldap'], 401);
        }

        $user = User::where('cpf', $credentials['cpf'])->first();
        if(@$user->id) {
            $user->cpf      = $usuarioLDAP['cpf'];
            $user->telefone = $usuarioLDAP['telefone'];
            $user->password = Hash::make($credentials['password']);
            $user->update();
        } else {
            $user = new User();
            $user->name     = $usuarioLDAP['name'];
            $user->email    = $usuarioLDAP['mail'];
            $user->cpf      = $usuarioLDAP['cpf'];
            $user->telefone = $usuarioLDAP['telefone'];
            $user->password = Hash::make($credentials['password']);
            $user->save();
        }

        try {
            if (! $token = JWTAuth::attempt($credentials, [
                'user' => $user
            ])) {
                return response()->json(['error' => 'invalid_credentials'], 401);
            }
        } catch (JWTException $e) {
            return response()->json(['error' => 'could_not_create_token'], 500);
        }
        return response()->json(compact('token'));
    }

    public function valida_ldap($cpf, $senha)  
    {
        if(Adldap::auth()->attempt("$cpf@mp.intra", $senha)) {
            $search = Adldap::search()
                ->where('description', '=', $cpf)
                ->get();

            if(!$search) {
                return false;
            }

            $usuario['name']        = $search[0]['displayname'][0];
            $usuario['mail']        = $search[0]['mail'][0];
            $usuario['cpf']         = $search[0]['description'][0];
            $usuario['telefone']    = $search[0]['telephonenumber'][0];
            
            return $usuario;
        } else {
            return null;
        }
    }   
    
}