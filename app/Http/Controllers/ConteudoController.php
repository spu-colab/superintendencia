<?php

namespace App\Http\Controllers;

use App\Conteudo;
use App\Http\Requests\ConteudoRequest;

class ConteudoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
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
     * @param  use App\Http\Requests\ConteudoRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(ConteudoRequest $request)
    {
        $request->validated();

        $conteudo = new Conteudo;
        $conteudo->id = null;
        $conteudo->titulo = $request->conteudo['titulo'];
        $conteudo->conteudo = $request->conteudo['conteudo'];

        $conteudo->save();        
        return response()->json($conteudo);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Conteudo  $Conteudo
     * @return \Illuminate\Http\Response
     */
    public function show(int $Conteudo)
    {
        return Conteudo::findOrFail($Conteudo);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Conteudo  $Conteudo
     * @return \Illuminate\Http\Response
     */
    public function edit(Conteudo $Conteudo)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  @param  use App\Http\Requests\ConteudoRequest  $request
     * @param  \App\Conteudo  $Conteudo
     * @return \Illuminate\Http\Response
     */
    public function update(ConteudoRequest $request, int $id)
    {
        $request->validated();

        $conteudo = Conteudo::findOrFail($id);
        $conteudo->titulo = $request->conteudo['titulo'];
        $conteudo->conteudo = $request->conteudo['conteudo'];

        $conteudo->update();        
        return response()->json($conteudo);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Conteudo  $Conteudo
     * @return \Illuminate\Http\Response
     */
    public function destroy(Conteudo $Conteudo)
    {
        //
    }
}
