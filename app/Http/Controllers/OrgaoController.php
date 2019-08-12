<?php

namespace App\Http\Controllers;

use App\User;
use App\Orgao;
use App\NaturezaOrgao;
use App\Http\Requests\OrgaoRequest;
// use Illuminate\Http\Request;

class OrgaoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Orgao::with(
            [
                'orgaoPai',
                'natureza'
            ])->orderBy('orgao', 'asc')->get();
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function listarNaturezas()
    {
        return NaturezaOrgao::orderBy('natureza')->get();
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
     * @param  App\Http\Requests\OrgaoRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(OrgaoRequest $request)
    {
        $validatedData = $request->validated();
        
        $orgao = new Orgao;
        $orgao->id = null;
        if(@$request->orgao['idNaturezaOrgao']) {
            $orgao->idNaturezaOrgao = $request->orgao['idNaturezaOrgao'];
        }
        if(@$request->orgao['idOrgaoPai']) {
            $orgao->idOrgaoPai = $request->orgao['idOrgaoPai'];
        }
        $orgao->orgao = $request->orgao['orgao'];
        $orgao->sigla = $request->orgao['sigla'];
        $orgao->email = $request->orgao['email'];
        $orgao->telefone = $request->orgao['telefone'];
        
        $this->authorize('create', $orgao);
        $orgao = $orgao->save();
        return response()->json($orgao);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Orgao  $orgao
     * @return \Illuminate\Http\Response
     */
    public function show(Orgao $orgao)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Orgao  $orgao
     * @return \Illuminate\Http\Response
     */
    public function edit(Orgao $orgao)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  App\Http\Requests\OrgaoRequest  $request
     * @param  \App\Orgao  $orgao
     * @return \Illuminate\Http\Response
     */
    public function update(OrgaoRequest $request, $id)
    {
        $validatedData = $request->validated();
        
        $orgao = Orgao::findOrFail($id);
        $this->authorize('update', $orgao);
        if(@$request->orgao['idNaturezaOrgao']) {
            $orgao->idNaturezaOrgao = $request->orgao['idNaturezaOrgao'];
        }
        if(@$request->orgao['idOrgaoPai'] != null) {
            $orgao->idOrgaoPai = $request->orgao['idOrgaoPai'];
        }
        $orgao->orgao = $request->orgao['orgao'];
        $orgao->sigla = $request->orgao['sigla'];
        $orgao->email = $request->orgao['email'];
        $orgao->telefone = $request->orgao['telefone'];

        $orgao->update();
        return response()->json($orgao);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Orgao  $orgao
     * @return \Illuminate\Http\Response
     */
    public function destroy(Orgao $orgao)
    {
        //
    }
}
