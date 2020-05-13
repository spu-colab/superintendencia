<?php

namespace App\Http\Controllers;

use App\ProcedimentoExterno;
use App\TipoProcedimentoExterno;
use App\User;
use App\Http\Requests\ProcedimentoExternoRequest;
use Illuminate\Http\Request;
// use \Illuminate\Http\Request;

class ProcedimentoExternoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {

        $consulta =  ProcedimentoExterno::with(['tipoprocedimentoexterno'])
            ->selectRaw('procedimentoexterno.*, tipoprocedimentoexterno.tipoprocedimento as tipoprocedimentoexterno')
            ->leftJoin('tipoprocedimentoexterno','tipoprocedimentoexterno.id' , '=', 'procedimentoexterno.idtipoprocedimentoexterno');

        if($request->search) {
            $where = [
                "procedimentoexterno.procedimento LIKE '%".strtolower($request->search)."%'",
                "procedimentoexterno.resumo LIKE '%".strtolower($request->search)."%'",
                "tipoprocedimentoexterno.tipoprocedimento LIKE '%".strtolower($request->search)."%'",
            ];
            foreach ($where as $w => $vWhere) {
                $consulta = $w ? 
                    $consulta->orWhereRaw($vWhere) :
                    $consulta->whereRaw($vWhere); 
            }
        }
    
        $consulta = $consulta->orderBy(
            $request->order ?? 'procedimento', 
            $request->ascending === 'false' ? 'desc' : 'asc',
            SORT_NATURAL|SORT_FLAG_CASE
        );

        $resultado = $request->per_page > 0 
            ? $consulta->paginate($request->per_page)
            : $consulta->get();
        return response()->json($resultado);
        /*
        $ascending = "desc";
        if ($request->ascending == "true"){
            $ascending = "asc";
        }
        if (!$request->per_page){
            return ProcedimentoExterno::with(
                [
                    'tipoProcedimentoExterno'
                ]
            )->get();
        }
        
        if(strlen ($request->search)>0){
            return ProcedimentoExterno
                ::selectRaw('procedimentoexterno.id, procedimentoexterno.id as idProcedimento, procedimento, resumo, p.tipoprocedimento as tipoProcedimentoExterno ')
                ->leftJoin('tipoprocedimentoexterno AS p','p.id' , '=', 'procedimentoexterno.idtipoprocedimentoexterno')
                ->whereRaw("procedimento LIKE '%".strtolower($request->search)."%'")
                ->orWhereRaw("p.tipoprocedimento LIKE '%".strtolower($request->search)."%'")
                ->orWhereRaw("resumo LIKE '%".strtolower($request->search)."%'")
                ->orderBy($request->ordem, $ascending)                
                ->paginate($request->per_page);
        }
        return ProcedimentoExterno
            ::selectRaw('procedimentoexterno.id, procedimentoexterno.id as idProcedimento, procedimento, resumo, p.tipoprocedimento as tipoProcedimentoExterno ')
            ->leftJoin('tipoprocedimentoexterno AS p','p.id' , '=', 'procedimentoexterno.idtipoprocedimentoexterno')
            ->orderBy($request->ordem, $ascending)                
            ->paginate($request->per_page);
        */
    
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
