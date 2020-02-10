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
    public function index()
    {
      return DivisaoOrganograma::with('usuarios:idUsuario,name,cpf','divisaoOrganogramaPai:id,nome,sigla')
        ->orderBy('idDivisaoOrganogramaPai', 'asc')->get();
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
            $result = $divisao->save();
            if(@$request->usuarios) {
                foreach ($request->usuarios as $idUsuario) {
                    $this->incluiUsuarioUsuarioDivisaoOrganograma($idUsuario, $divisao->id);
                }
            }   

            return response()->json($result);
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
            $divisao->idDivisaoOrganogramaPai = 'null';
            if ($request->idPai){
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