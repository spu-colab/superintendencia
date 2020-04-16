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
    public function index()
    {
        $result = Permissao::with(['usuarios:idUsuario'])->orderBy('permissao', 'asc')->get();        
        return response()->json($result);
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
        $this->removePermissaoUsuarioPermissao($id);     
        if(@$request->usuarios) {
            foreach ($request->usuarios as $idUsuario) {
                $this->incluiUsuarioPermissao($idUsuario, $id);
            }
        }
        return response()->json(true);
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