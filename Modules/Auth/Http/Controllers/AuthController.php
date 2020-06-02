<?php

namespace Modules\Auth\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;
use Nwidart\Modules\Routing\Controller;
use Redirect,DB,Config;
use Adldap\Laravel\Facades\Adldap;

use App\User;
use App\Permissao;
use App\UsuarioPermissao;
use App\Http\Controllers\PermissaoDivisaoOrganogramaTrait;
use Modules\Auth\Entities\DivisaoOrganograma;
use Modules\Auth\Entities\UsuarioDivisaoOrganograma;
use Modules\Auth\Http\Requests\UserRequest;

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
        if (!$request->per_page){
            $result = User::with(['permissoes:permissao.id,permissao,descricao',
            'divisoesOrganograma:divisaoorganograma.id,sigla,nome'])->orderBy('name','asc')->get();
            return response()->json($result);
        }

      //        return response()->json(['message' => "CPF: ".$request->ascending." Já Existe na Base "], 404);
      $ascending = "desc";
      if ($request->ascending == "true"){
          $ascending = "asc";
      }

//        return response()->json(['message' => "CPF: ".$ascending." Já Existe na Base "], 404);

      if(strlen ($request->search)>0){
          return User::with(['permissoes:permissao.id,permissao,descricao',
              'divisoesOrganograma:divisaoorganograma.id,sigla,nome'])     
              ->whereRaw("name LIKE '%".strtolower($request->search)."%'")
              ->orWhereRaw("email LIKE '%".strtolower($request->search)."%'")
              ->orWhereRaw("telefone LIKE '%".strtolower($request->search)."%'")
              ->orWhereRaw("CONVERT(cpf , CHAR) LIKE '%" . strtolower($request->search) . "%'")
              ->ativos()
              ->orderBy($request->ordem, $ascending)->paginate($request->per_page);
      }
      return User::with(['permissoes:permissao.id,permissao,descricao',
          'divisoesOrganograma:divisaoorganograma.id,sigla,nome'])
          ->ativos()     
          ->orderBy($request->ordem , $ascending)->paginate($request->per_page);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  Modules\Auth\Http\Requests\UserRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(UserRequest $request)
    {
        date_default_timezone_set('America/Sao_Paulo');
        $dataAtual  = date("Y-m-d H:i:s");

        $validatedData = $request->validated();
        $user = new User();
        $user->fill($request->all());
        $user->password = Hash::make($user->cpf);

        $this->authorize('create', $user);

        // $user = $this->obterDadosUsuarioLDAP($request);
        if($this->cpfJaCadastrado($user->cpf)) {
            \abort(\Symfony\Component\HttpFoundation\Response::HTTP_CONFLICT, "CPF já cadastrado.");
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
        $user->save();                
        return  $this->edit($user->id);
    }

    public function cpfJaCadastrado($cpf) {
        $user = User::where('cpf', $cpf)->first();
        return $user != null;
    }
    
    public function obterDadosUsuarioLDAP($request) {
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
            return $user;
        }
        catch(\Exception $e){
            return response()->json(['message' => "CPF: ".$user->cpf." Já Existe na Base "], 404);
        }
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
        $user = User::with(['permissoes:permissao.id,permissao,descricao',
            'divisoesOrganograma:divisaoorganograma.id,sigla,nome'])->findOrFail($id);
        return response()->json($user);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  Modules\Auth\Http\Requests\UserRequest  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(UserRequest $request, $id)
    {        
        $validatedData = $request->validated();

        $user = User::findOrFail($id);
        $user->fill($request->all());

        $this->authorize('update', $user);
        
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
        $atualizou = $user->update();
        return response()->json($user);
    }
    
}
