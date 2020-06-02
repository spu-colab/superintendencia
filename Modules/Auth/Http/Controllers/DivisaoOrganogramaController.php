<?php

namespace Modules\Auth\Http\Controllers;

use Modules\Auth\Entities\DivisaoOrganograma;
use Modules\Auth\Entities\UsuarioDivisaoOrganograma;
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
            return DivisaoOrganograma::ativos()->with('usuarios:idUsuario,name,cpf','divisaoOrganogramaPai:id,nome,sigla')
            ->get();
        }
        if(strlen ($request->search)>0){
//            return DivisaoOrganograma::with('usuarios:idUsuario,name,cpf','divisaoOrganogramaPai:id, nome as nomePai, sigla')  
//                ->whereRaw("divisaoorganograma.nome LIKE '%".strtolower($request->search)."%'")
//                ->orWhereRaw("divisaoorganograma.sigla LIKE '%".strtolower($request->search)."%'")
//                ->orderBy($request->ordem, $ascending)->paginate($request->per_page);
            return DivisaoOrganograma::ativos()
                    ->selectRaw("divisaoorganograma.id, divisaoorganograma.idDivisaoOrganogramaPai, divisaoorganograma.nome as nomeDiv, divisaoorganograma.sigla as siglaDiv, p.nome as nomePai,
                    p.id as idPai")
                    ->leftJoin('divisaoorganograma AS p','p.id' , '=', 'divisaoorganograma.idDivisaoOrganogramaPai')
                    ->whereRaw("divisaoorganograma.nome LIKE '%".strtolower($request->search)."%'")
                    ->orWhereRaw("divisaoorganograma.sigla LIKE '%".strtolower($request->search)."%'")
                    ->with('usuarios:idUsuario,name,cpf')
                    ->orderBy($request->ordem , $ascending)
                    ->paginate($request->per_page);
        }
//        return DivisaoOrganograma::with('usuarios:idUsuario,name,cpf') 
        return DivisaoOrganograma::ativos()
            ->selectRaw("divisaoorganograma.id, divisaoorganograma.idDivisaoOrganogramaPai, divisaoorganograma.nome as nomeDiv, divisaoorganograma.sigla as siglaDiv, p.nome as nomePai,
             p.id as idPai")
            ->leftJoin('divisaoorganograma AS p','p.id' , '=', 'divisaoorganograma.idDivisaoOrganogramaPai')
            ->with('usuarios:idUsuario,name,cpf')
            ->orderBy($request->ordem , $ascending)
            ->paginate($request->per_page);
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
        if($request->nome == null || $request->sigla == null) {
            return response()->json(['message' => "Erro de Preenchimento"], 404);
        }

        $this->authorize('store');

        $divisao = new DivisaoOrganograma;
        $divisao->nome = $request->nome;
        $divisao->sigla = $request->sigla;
        if($request->idPai) {
            $divisao->idDivisaoOrganogramaPai = $request->idPai;
        }

        $result = $divisao->save();
        if(@$request->usuarios) {
            foreach ($request->usuarios as $idUsuario) {
                $this->incluiUsuarioUsuarioDivisaoOrganograma($idUsuario, $divisao->id);
            }
        }
        return response()->json($result);
    }

    /**
     * Display the specified resource.
     *
     * @param  Modules\Auth\Entities\DivisaoOrganograma  $divisaoOrganograma
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
     * @param  \Modules\Auth\Entities\DivisaoOrganograma  $divisaoOrganograma
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
     * @param  \Modules\Auth\Entities\DivisaoOrganograma  $divisaoOrganograma
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        if($request->nome == null || $request->sigla == null) {
            return response()->json(['message' => "Erro de Preenchimento"], 404);
        }
        
        $divisao = DivisaoOrganograma::findOrFail($id);
//        return $this->verificaUsuarioPermissao(['DIVISAO_ORGANOGRAMA_CADASTRAR']);
        $this->authorize('update', $divisao);    

        $divisao->nome = $request->nome;
        $divisao->sigla = $request->sigla;
        if ($request->idPai!= 'null'){
            $divisao->idDivisaoOrganogramaPai = $request->idPai;
        }
        $result = $divisao->update();
        
        $this->removeDivisaoUsuarioDivisaoOrganograma($id);
        if(@$request->usuarios) {
            foreach ($request->usuarios as $idUsuario) {
                $this->incluiUsuarioUsuarioDivisaoOrganograma($idUsuario, $id);
            }
        }   
        return response()->json($result);
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  \Modules\Auth\Entities\DivisaoOrganograma  $divisaoOrganograma
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public function listarSuperintendencias() {
        return response()->json(DivisaoOrganograma::where('snSuperintendencia', 1)->get());
    }
}