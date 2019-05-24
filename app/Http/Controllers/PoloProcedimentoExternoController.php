<?php

namespace App\Http\Controllers;

use App\PoloProcedimentoExterno;
use Illuminate\Http\Request;

class PoloProcedimentoExternoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return PoloProcedimentoExterno::orderBy('polo')->get();
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
     * @param  \App\PoloProcedimentoExterno  $poloProcedimentoExterno
     * @return \Illuminate\Http\Response
     */
    public function show(PoloProcedimentoExterno $poloProcedimentoExterno)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\PoloProcedimentoExterno  $poloProcedimentoExterno
     * @return \Illuminate\Http\Response
     */
    public function edit(PoloProcedimentoExterno $poloProcedimentoExterno)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\PoloProcedimentoExterno  $poloProcedimentoExterno
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, PoloProcedimentoExterno $poloProcedimentoExterno)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\PoloProcedimentoExterno  $poloProcedimentoExterno
     * @return \Illuminate\Http\Response
     */
    public function destroy(PoloProcedimentoExterno $poloProcedimentoExterno)
    {
        //
    }
}
