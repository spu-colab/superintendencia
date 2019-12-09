<?php

namespace Modules\Auth\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use App\User;
use App\UsuarioPermissao;
use Adldap\Laravel\Facades\Adldap;

class AuthController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $result = User::get();
        
        return response()->json($result);
    }



    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
        $user = new User;



        if(@$request->usuario['name']) {
            $user->name = $request->usuario['name'];
        }
        if(@$request->usuario['cpf']) {
            $user->cpf = $request->usuario['cpf'];
        }
        if(@$request->usuario['email']) {
            $user->email = $request->usuario['email'];
        }
        if(@$request->usuario['telefone']) {
            $user->telefone = $request->usuario['telefone'];
        }
        if(@$request->usuario['password']) {
            $user->password = $request->usuario['password'];
        }
        $user = $user->save();
        return response()->json($user);

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $search = Adldap::search()->where('description', '=', $id)->get();
        
        if($search[0]['displayname'][0]){
            $usuario['name']        = $search[0]['displayname'][0];
            $usuario['mail']        = $search[0]['mail'][0];
            $usuario['cpf']         = $search[0]['description'][0];
            $usuario['telefone']    = $search[0]['telephonenumber'][0];
            return response()->json($usuario);
        }
        //

        //$result = User::with(['permissoes','divisoesOrganograma'])->find($id);
        return response()->json("CPF não Encontrado");
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
        $user = User::findOrFail($id);
        return response()->json($user);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        // recuperar o usuario do banco
        // fazer as atualizações de valores
        // $user->update();
        date_default_timezone_set('America/Sao_Paulo');
        $dataAtual  = date("Y-m-d H:i:s");  
        $user = User::findOrFail($id);
//        $this->authorize('update', $user);
        if(@$request->name) {
            $user->name = $request->name;
        }
        if(@$request->cpf) {
            $user->cpf = $request->cpf;
        }
        if(@$request->email) {
            $user->email = $request->email;
        }
        if(@$request->telefone) {
            $user->telefone = $request->telefone;
        }
        UsuarioPermissao::where('idUsuario', $id)->delete();

        if(@$request->idPermissao) {
            $dataSet = [];
            foreach ($request->idPermissao as $idPermissao) {
                 $dataSet[] = [
                    'idUsuario'  => $id,
                    'idPermissao' => $idPermissao,
                    'created_at' => $dataAtual
                ];
            }
            UsuarioPermissao::insert($dataSet);
        }    
        
        return response()->json($user->update());
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
    
}
