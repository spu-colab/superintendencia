<?php

namespace Modules\Auth\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Nwidart\Modules\Routing\Controller;
use Redirect,DB,Config;
use App\User;
use App\Permissao;
use App\UsuarioPermissao;
use App\DivisaoOrganograma;
use App\UsuarioDivisaoOrganograma;
use App\Http\Controllers\PermissaoDivisaoOrganogramaTrait;
use Adldap\Laravel\Facades\Adldap;

class AuthController extends Controller
{    
    use PermissaoDivisaoOrganogramaTrait;

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function listarReduzido(Request $request)
    {
        return response()->json(User::orderBy('name', 'asc')->get());
    }

    public function index(Request $request)
    {
        $result = User::with(['permissoes:Permissao.id,permissao,descricao',
            'divisoesOrganograma:DivisaoOrganograma.id,sigla,nome'])->get();
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
        date_default_timezone_set('America/Sao_Paulo');
        $dataAtual  = date("Y-m-d H:i:s");  

        if(@$request->user['cpf']) {
            $user = new User;
            $this->authorize('store', $user);

            $user->cpf = $request->user['cpf'];
    
            $search = Adldap::search()->where('description', '=', $user->cpf)->get();
            if (!@$search[0]['displayname'][0]){
                return response()->json(['message' => "CPF: ".@$request->user['cpf']." Não Localizado"], 404);
            }

            $user['password']       = Hash::make($user->cpf);
            $user['name']           = $search[0]['displayname'][0];
            $user['email']          = $search[0]['mail'][0];        
            $user['telefone']       = $search[0]['telephonenumber'][0];
            try{
                $user->save();
            }
            catch(\Exception $e){
                return response()->json(['message' => "CPF: ".$user->cpf." Já Existe na Base "], 404);
            }

        if(@$request->permissoes) {
            foreach ($request->permissoes as $idPermissao) {
                $this->incluiUsuarioPermissao($user->id, $idPermissao);
            }
        }    
        if(@$request->divisoes) {
            foreach ($request->divisoes as $idDivisaoOrganograma) {
                $this->incluiUsuarioUsuarioDivisaoOrganograma($user->id, $idDivisaoOrganograma);
            }
        }                
            return  $this->edit($user->id);
        }   
        return response()->json(['message' => "CPF deve ser informado"], 404);
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
        if (!@$search[0]['displayname'][0]){
            return response()->json("CPF: ".$id." Não Localizado");
        }
        $usuario['name']        = $search[0]['displayname'][0];
        $usuario['mail']        = $search[0]['mail'][0];
        $usuario['cpf']         = $search[0]['description'][0];
        $usuario['telefone']    = $search[0]['telephonenumber'][0];
        return response()->json($usuario);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $user = User::with(['permissoes:Permissao.id,permissao,descricao',
            'divisoesOrganograma:DivisaoOrganograma.id,sigla,nome'])->findOrFail($id);
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
        $user = User::findOrFail($id);       
        $this->authorize('update', $user);
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
        $this->removeUsuarioUsuarioPermissao($id);
        $this->removeUsuarioUsuarioDivisaoOrganograma($id);

        if(@$request->permissoes) {
            foreach ($request->permissoes as $idPermissao) {
                $this->incluiUsuarioPermissao($id, $idPermissao);
            }
        }    
        if(@$request->divisoes) {
            foreach ($request->divisoes as $idDivisaoOrganograma) {
                $this->incluiUsuarioUsuarioDivisaoOrganograma($id, $idDivisaoOrganograma);
            }
        }            
        return response()->json(true);
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
