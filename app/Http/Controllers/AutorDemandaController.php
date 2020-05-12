<?php

namespace App\Http\Controllers;

use App\AutorDemanda;
use App\Http\Requests\AutorDemandaRequest;
use Illuminate\Http\Request;

class AutorDemandaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $consulta = AutorDemanda::with(['cargo', 'orgao'])
            ->selectRaw('autordemanda.id, autordemanda.nome, autordemanda.email, autordemanda.telefone, autordemanda.idcargo, autordemanda.idorgao, cargo.cargo as cargoTexto, orgao.orgao as orgaoTexto, orgao.sigla as siglaOrgaoTexto ')
            ->leftJoin('cargo','cargo.id' , '=', 'autordemanda.idcargo')
            ->leftJoin('orgao','orgao.id' , '=', 'autordemanda.idorgao');

        if($request->search) {
            $where = [
            "nome LIKE '%".strtolower($request->search)."%'",
            "cargo LIKE '%".strtolower($request->search)."%'",
            "orgao LIKE '%".strtolower($request->search)."%'",
            "sigla LIKE '%" . strtolower($request->search) . "%'"
            ];
            foreach ($where as $w => $vWhere) {
                $consulta = $w ? 
                    $consulta->orWhereRaw($vWhere) :
                    $consulta->whereRaw($vWhere); 
            }
        }
        
        $consulta = $consulta->orderBy(
            $request->order ?? 'autordemanda.nome', 
            $request->ascending === 'false' ? 'desc' : 'asc',
            SORT_NATURAL|SORT_FLAG_CASE
        );

        $resultado = $consulta->paginate($request->per_page);
        return response()->json($resultado);
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
    public function store(AutorDemandaRequest $request)
    {
        $validatedData = $request->validated();
        
        $autorDemanda = new AutorDemanda;
        $autorDemanda->id = null;
        $autorDemanda->idCargo = $request->autordemanda['idCargo'];
        $autorDemanda->idOrgao = $request->autordemanda['idOrgao'];
        $autorDemanda->nome = $request->autordemanda['nome'];
        $autorDemanda->email = $request->autordemanda['email'];
        $autorDemanda->telefone = @$request->autordemanda['telefone'];
        
        $this->authorize('create', $autorDemanda);
        $autorDemanda = $autorDemanda->save();
        return response()->json($autorDemanda);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\AutorDemanda  $autorDemanda
     * @return \Illuminate\Http\Response
     */
    public function show(AutorDemanda $autorDemanda)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\AutorDemanda  $autorDemanda
     * @return \Illuminate\Http\Response
     */
    public function edit(AutorDemanda $autorDemanda)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\AutorDemanda  $autorDemanda
     * @return \Illuminate\Http\Response
     */
    public function update(AutorDemandaRequest $request, AutorDemanda $autorDemanda)
    {
        $validatedData = $request->validated();
        
        $autorDemanda->idCargo = $request->autordemanda['idCargo'];
        $autorDemanda->idOrgao = $request->autordemanda['idOrgao'];
        $autorDemanda->nome = $request->autordemanda['nome'];
        $autorDemanda->email = $request->autordemanda['email'];
        $autorDemanda->telefone = @$request->autordemanda['telefone'];
        
        $this->authorize('update', $autorDemanda);
        $autorDemanda = $autorDemanda->update();
        return response()->json($autorDemanda);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\AutorDemanda  $autorDemanda
     * @return \Illuminate\Http\Response
     */
    public function destroy(AutorDemanda $autorDemanda)
    {
        //
    }
}
