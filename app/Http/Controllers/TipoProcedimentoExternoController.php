<?php

namespace App\Http\Controllers;

use App\TipoProcedimentoExterno;
use Illuminate\Http\Request;

class TipoProcedimentoExternoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return TipoProcedimentoExterno::orderBy('tipoprocedimento')->get();
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
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\TipoProcedimentoExterno  $tipoProcedimentoExterno
     * @return \Illuminate\Http\Response
     */
    public function show(TipoProcedimentoExterno $tipoProcedimentoExterno)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\TipoProcedimentoExterno  $tipoProcedimentoExterno
     * @return \Illuminate\Http\Response
     */
    public function edit(TipoProcedimentoExterno $tipoProcedimentoExterno)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\TipoProcedimentoExterno  $tipoProcedimentoExterno
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, TipoProcedimentoExterno $tipoProcedimentoExterno)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\TipoProcedimentoExterno  $tipoProcedimentoExterno
     * @return \Illuminate\Http\Response
     */
    public function destroy(TipoProcedimentoExterno $tipoProcedimentoExterno)
    {
        //
    }
}
