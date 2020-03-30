<?php

namespace App\Http\Controllers;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Validator;
use JWTFactory;
use JWTAuth;
use App\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Http\Controllers\Auth\LoginController;
// use Adldap\Laravel\Facades\Adldap;

class APILoginController extends LoginController
{
    /*
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
        // return response()->json($usuarioLDAP);

        $user = User::where('cpf', $credentials['cpf'])->first();
        if(@$user->id) {
            $user->telefone = $usuarioLDAP['telefone'];
            $user->password = Hash::make($credentials['password']);
            $user->update();
        } else {
            $user = new User();
            $user->cpf      = $usuarioLDAP['cpf'];
            $user->name     = $usuarioLDAP['name'];
            $user->email    = $usuarioLDAP['mail'];
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
    */

    /**
     * Handle a login request to the application.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\Http\Response|\Illuminate\Http\JsonResponse
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    public function login(Request $request)
    {
        $this->validateLogin($request);

        // If the class is using the ThrottlesLogins trait, we can automatically throttle
        // the login attempts for this application. We'll key this by the username and
        // the IP address of the client making these requests into this application.
        if (method_exists($this, 'hasTooManyLoginAttempts') &&
            $this->hasTooManyLoginAttempts($request)) {
            $this->fireLockoutEvent($request);

            return $this->sendLockoutResponse($request);
        }

        if ($this->attemptLogin($request)) {
            // return $this->sendLoginResponse($request);
            $credentials = $this->credentials($request);
            try {
                if (! $token = JWTAuth::attempt($credentials, [
                    'user' => $this->guard()->user()
                ])) {
                    return response()->json(['error' => 'invalid_credentials'], 401);
                }
            } catch (JWTException $e) {
                return response()->json(['error' => 'could_not_create_token'], 500);
            }
            return response()->json(compact('token'));
        }

        // If the login attempt was unsuccessful we will increment the number of attempts
        // to login and redirect the user back to the login form. Of course, when this
        // user surpasses their maximum number of attempts they will get locked out.
        $this->incrementLoginAttempts($request);

        return $this->sendFailedLoginResponse($request);
    }

    /**
     * Get the login username to be used by the controller.
     *
     * @return string
     */
    public function username()
    {
        return 'cpf';
    }

    /*
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
            $usuario['uf']          = $search[0]['l'];
            $usuario['uf_sigla']          = $search[0]['st'];
            
            return $usuario;
        } else {
            return null;
        }
    }
    */
    
}