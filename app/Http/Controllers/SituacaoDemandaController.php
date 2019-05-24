<?php

namespace App\Http\Controllers;

use App\SituacaoDemanda;
use Illuminate\Http\Request;

class SituacaoDemandaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return SituacaoDemanda::all();
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
     * @param  \App\SituacaoDemanda  $situacaoDemanda
     * @return \Illuminate\Http\Response
     */
    public function show(SituacaoDemanda $situacaoDemanda)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\SituacaoDemanda  $situacaoDemanda
     * @return \Illuminate\Http\Response
     */
    public function edit(SituacaoDemanda $situacaoDemanda)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\SituacaoDemanda  $situacaoDemanda
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, SituacaoDemanda $situacaoDemanda)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\SituacaoDemanda  $situacaoDemanda
     * @return \Illuminate\Http\Response
     */
    public function destroy(SituacaoDemanda $situacaoDemanda)
    {
        //
    }
}
