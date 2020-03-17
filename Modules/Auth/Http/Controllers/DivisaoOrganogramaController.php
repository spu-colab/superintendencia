<?php

namespace Modules\Auth\Http\Controllers;
use App\DivisaoOrganograma;
use App\UsuarioDivisaoOrganograma;
use App\Http\Controllers\PermissaoDivisaoOrganogramaTrait;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Nwidart\Modules\Routing\Controller;
class DivisaoOrganogramaController extends Controller
{
    use PermissaoDivisaoOrganogramaTrait;


    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $ascending = "desc";
        if ($request->ascending == "true"){
            $ascending = "asc";
        }
        if (!$request->per_page){
            return DivisaoOrganograma::with('usuarios:idUsuario,name,cpf','divisaoOrganogramaPai:id,nome,sigla')
            ->get();
        }
        if(strlen ($request->search)>0){
//            return DivisaoOrganograma::with('usuarios:idUsuario,name,cpf','divisaoOrganogramaPai:id, nome as nomePai, sigla')  
//                ->whereRaw("divisaoorganograma.nome LIKE '%".strtolower($request->search)."%'")
//                ->orWhereRaw("divisaoorganograma.sigla LIKE '%".strtolower($request->search)."%'")
//                ->orderBy($request->ordem, $ascending)->paginate($request->per_page);
            return DivisaoOrganograma::
                    selectRaw("divisaoorganograma.id, divisaoorganograma.idDivisaoOrganogramaPai, divisaoorganograma.nome as nomeDiv, divisaoorganograma.sigla as siglaDiv, p.nome as nomePai,
                    p.id as idPai")
                    ->leftJoin('divisaoorganograma AS p','p.id' , '=', 'divisaoorganograma.idDivisaoOrganogramaPai')
                    ->whereRaw("divisaoorganograma.nome LIKE '%".strtolower($request->search)."%'")
                    ->orWhereRaw("divisaoorganograma.sigla LIKE '%".strtolower($request->search)."%'")
                    ->with('usuarios:idUsuario,name,cpf')
                    ->orderBy($request->ordem , $ascending)
                    ->paginate($request->per_page);
        }
//        return DivisaoOrganograma::with('usuarios:idUsuario,name,cpf') 
        return DivisaoOrganograma::selectRaw("divisaoorganograma.id, divisaoorganograma.idDivisaoOrganogramaPai, divisaoorganograma.nome as nomeDiv, divisaoorganograma.sigla as siglaDiv, p.nome as nomePai,
             p.id as idPai")
            ->leftJoin('divisaoorganograma AS p','p.id' , '=', 'divisaoorganograma.idDivisaoOrganogramaPai')
            ->with('usuarios:idUsuario,name,cpf')
            ->orderBy($request->ordem , $ascending)
            ->paginate($request->per_page);
    }
    public function listarPai()
    {        
        $result = DivisaoOrganograma::get();
        return response()->json($result);
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
        if($request->nome && $request->sigla && $request->idPai) {
            $divisao = new DivisaoOrganograma;
            $this->authorize('store', $divisao);    
            $divisao->nome = $request->nome;
            $divisao->sigla = $request->sigla;
            $divisao->idDivisaoOrganogramaPai = $request->idPai;
            $divisao->save();            
            return response()->json($divisao->usuarios()->sync($request->usuarios));
        }
        return response()->json(['message' => "Erro de Preenchimento"], 404);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\DivisaoOrganograma  $divisaoOrganograma
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $result = DivisaoOrganograma::findOrFail($id);
        return response()->json($result);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\DivisaoOrganograma  $divisaoOrganograma
     * @return \Illuminate\Http\Response
     */
    public function edit(DivisaoOrganograma $divisaoOrganograma)
    {
        //
    }
    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\DivisaoOrganograma  $divisaoOrganograma
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        if($request->nome && $request->sigla && $request->idPai) {
            $divisao = DivisaoOrganograma::findOrFail($id);
            $this->authorize('update', $divisao);    
            $divisao->nome = $request->nome;
            $divisao->sigla = $request->sigla;
            if ($request->idPai!= 'null'){
                $divisao->idDivisaoOrganogramaPai = $request->idPai;
            }            
            $divisao->usuarios()->sync($request->usuarios);
            return response()->json($divisao->update());
        }
        return response()->json(['message' => "Erro de Preenchimento"], 404);
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\DivisaoOrganograma  $divisaoOrganograma
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}