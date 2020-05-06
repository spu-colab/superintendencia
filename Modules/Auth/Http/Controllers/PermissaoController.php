<?php

namespace Modules\Auth\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Nwidart\Modules\Routing\Controller;
use App\Permissao;
use App\UsuarioPermissao;
use App\Http\Controllers\PermissaoDivisaoOrganogramaTrait;

class PermissaoController extends Controller
{
    use PermissaoDivisaoOrganogramaTrait;

    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index(Request $request)
    {
        $ascending = "desc";
        if ($request->ascending == "true"){
            $ascending = "asc";
        }
        if(!$request->per_page){
            $result = Permissao::with(['usuarios:idUsuario'])->orderBy('permissao', 'asc')->get();        
            return response()->json($result);
        }

        if(strlen ($request->search)>0){
            return Permissao::with(['usuarios:idUsuario'])     
                ->whereRaw("permissao LIKE '%".strtolower($request->search)."%'")
                ->orWhereRaw("descricao LIKE '%".strtolower($request->search)."%'")
                ->orderBy($request->ordem, $ascending)->paginate($request->per_page);
        }
        return Permissao::with(['usuarios:idUsuario'])->orderBy($request->ordem , $ascending)->paginate($request->per_page);
    }

    public function create()
    {
        return response()->json(['message' => "Opção desabilitada"], 404);
    }

    public function store(Request $request)
    {
        return response()->json(['message' => "Opção desabilitada"], 404);
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Response
     */
    public function show($id)
    {
        $result = Permissao::findOrFail($id);
        return response()->json($result);
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Response
     */
    public function edit($id)
    {
        $result = Permissao::findOrFail($id);
        return response()->json($result);
    }

    public function update(Request $request, $id)
    {        
        $permissao = Permissao::findOrFail($id);
        $this->authorize('update', $permissao);
        return response()->json($permissao->usuarios()->sync($request->usuarios));
    }
    public function destroy($id)
    {
        return response()->json(['message' => "Opção desabilitada"], 404);
    }

    public function usuarioPossuiPermissao($permissao) {
        $arrPermissoes = [ $permissao ];
        $usuario = $this->verificaUsuarioPermissao($arrPermissoes);
        return response()->json($usuario != null);
    }
}