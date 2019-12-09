<?php

namespace Modules\Auth\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use App\Permissao;
class PermissaoController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        $result = Permissao::orderBy('permissao', 'asc')->get();
        return response()->json($result);
    }

    /**
     * Show the form for creating a new resource.
     * @return Response
     */
    public function create()
    {
        
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        if($request->permissao && $request->descricao) {
            $permissao = new Permissao;
            $permissao->permissao = $request->permissao;
            $permissao->descricao = $request->descricao;
            $result = $permissao->save();
            return response()->json($result);
        }
        return response()->json("Erro de Preenchimento");
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

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Response
     */
    public function update(Request $request, $id)
    {
        if($request->permissao && $request->descricao) {
            $permissao = Permissao::findOrFail($id);
            $permissao->permissao = $request->permissao;
            $permissao->descricao = $request->descricao;
            $result = $permissao->update();
            return response()->json($result);
        }
        return response()->json("Erro de Preenchimento");
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Response
     */
    public function destroy($id)
    {
        $permissao = Permissao::findOrFail($id);
        return response()->json($permissao->delete());
    }
}
