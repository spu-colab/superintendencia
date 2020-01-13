<?php

namespace App\Http\Controllers;

use App\ProcedimentoExterno;
use App\User;
use App\Http\Requests\ProcedimentoExternoRequest;
// use \Illuminate\Http\Request;

class ProcedimentoExternoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return ProcedimentoExterno::with(
            [
                'tipoProcedimentoExterno'
            ]
        )->get();
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
    public function store(ProcedimentoExternoRequest $request)
    {
        $validatedData = $request->validated();
        
        $procedimentoExterno = new ProcedimentoExterno;
        $procedimentoExterno->id = null;
        $procedimentoExterno->idTipoProcedimentoExterno = $request->procedimentoExterno['idTipoProcedimentoExterno'];
        $procedimentoExterno->idPoloProcedimentoExterno = $request->procedimentoExterno['idPoloProcedimentoExterno'];
        $procedimentoExterno->procedimento = $request->procedimentoExterno['procedimento'];
        $procedimentoExterno->chave = $request->procedimentoExterno['chave'];
        $procedimentoExterno->resumo = $request->procedimentoExterno['resumo'];
        if(@$request->procedimentoExterno['descricao']){
            $procedimentoExterno->descricao = $request->procedimentoExterno['descricao'];
        }
        
        $this->authorize('create', $procedimentoExterno);

        $procedimentoExterno = $procedimentoExterno->save();
        return response()->json($procedimentoExterno);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\ProcedimentoExterno  $procedimentoExterno
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        return ProcedimentoExterno::with(
            [
                'tipoProcedimentoExterno'
            ]
        )->where('id', $id)->get();
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\ProcedimentoExterno  $procedimentoExterno
     * @return \Illuminate\Http\Response
     */
    public function edit(ProcedimentoExterno $procedimentoExterno)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\ProcedimentoExterno  $procedimentoExterno
     * @return \Illuminate\Http\Response
     */
    public function update(ProcedimentoExternoRequest $request, ProcedimentoExterno $procedimentoExterno)
    {
        $validatedData = $request->validated();
        
        $procedimentoExterno = ProcedimentoExterno::findOrFail($procedimentoExterno->id);
        $this->authorize('update', $procedimentoExterno);

        $procedimentoExterno->idTipoProcedimentoExterno = $request->procedimentoExterno['idTipoProcedimentoExterno'];
        $procedimentoExterno->idPoloProcedimentoExterno = $request->procedimentoExterno['idPoloProcedimentoExterno'];
        $procedimentoExterno->procedimento = $request->procedimentoExterno['procedimento'];
        $procedimentoExterno->chave = $request->procedimentoExterno['chave'];
        $procedimentoExterno->resumo = $request->procedimentoExterno['resumo'];
        $procedimentoExterno->descricao = $request->procedimentoExterno['descricao'];

        $procedimentoExterno->update();
        return response()->json($procedimentoExterno);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\ProcedimentoExterno  $procedimentoExterno
     * @return \Illuminate\Http\Response
     */
    public function destroy(ProcedimentoExterno $procedimentoExterno)
    {
        //
    }

    public function search(ProcedimentoExterno $request, $search) {
        return ProcedimentoExterno::where('procedimento', 'LIKE', '%'.$search.'%')
            ->with('tipoProcedimentoExterno')->get();
    }
}
