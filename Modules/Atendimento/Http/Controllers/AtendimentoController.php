<?php

namespace Modules\Atendimento\Http\Controllers;

use Modules\Atendimento\Entities\Atendimento;
use Modules\Atendimento\Entities\Assunto;
use Modules\Atendimento\Entities\Atendimento_Assunto;
use Modules\Atendimento\Entities\Comentario;
use Modules\Atendimento\Http\Requests\AtendimentoRequest;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;

class AtendimentoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $result = Atendimento::with(['tipo','usuario','assuntos','comentarios'])->get();
        return response()->json($result);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(AtendimentoRequest $request)
    {
        return 'Hello';
        /*
        $this->validated();

        $atendimento = new Atendimento;
        $atendimento->idUsuario = Auth::id();        
        $atendimento->idTipo = $request->idTipo ;
        date_default_timezone_set('America/Sao_Paulo');
        $atendimento->dataHoraInicio = date("Y-m-d H:i:s");
        return response()->json($atendimento->save());
        */
    }

    public function listarAssuntos()
    {
        $result = AtendimentoAssunto::orderBy('assunto')->get();
        return response()->json($result);     
    }

    public function listarAtendimentos($data)
    {
        $dtinic =  date('Y-m-d', strtotime($data));
        $dtfim  =  date('Y-m-d', strtotime("+1 days",strtotime($data))); 

        return response()
            ->json(Atendimento::with
                (['tipo','usuario:id,name','assuntos','comentarios'])
            ->whereBetween('dataHoraInicio',[$dtinic,$dtfim])->get());
    }


    public function listarAtendimentoNaoConcluido()
    {
        $dtinic =  date('Y-m-d');
        $dtfim  =  date('Y-m-d', strtotime("+1 days",strtotime($dtinic))); 
        $result = Atendimento::with(['tipo','usuario:id,name','assuntos','comentarios'])
        ->whereBetween('dataHoraInicio',[$dtinic,$dtfim])
        ->whereNull('dataHoraFim')
        ->where('idUsuario','=', Auth::id())->first();
        return response()->json($result);
    }


    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $result = Atendimento::with(['tipo','usuario:id,name','assuntos','comentarios'])->find($id);
        return response()->json($result);

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $atendimento = Atendimento::findOrFail($id);
        
        date_default_timezone_set('America/Sao_Paulo');
        $dataAtual  = date("Y-m-d H:i:s");  

        if(@$request->comentario) {
            $atendimentoComentario = new atendimentoComentario;
            $atendimentoComentario->comentario = $request->comentario;
            $atendimentoComentario->idAtendimento = $id;
            $atendimentoComentario->dataHora = $dataAtual;
            $atendimentoComentario->idUsuario = Auth::id();
            $atendimentoComentario->save();        
        }

        Atendimento_AtendimentoAssunto::where('idAtendimento', $id)->delete();

        if(@$request->idAssunto) {
            $dataSet = [];
            foreach ($request->idAssunto as $idAssunto) {
                 $dataSet[] = [
                    'idAtendimento'  => $id,
                    'idAtendimentoAssunto' => $idAssunto,
                    'created_at' => $dataAtual
                ];
            }
            Atendimento_AtendimentoAssunto::insert($dataSet);
        }                

        $atendimento->dataHoraFim  = $dataAtual;  

    /**
    * Não está em uso.   Calcula o tempo de atendimento.
    
    *   $datainic = getdate(strtotime($atendimento->dataHoraInicio));      
    *    $datafim  = getdate(strtotime($atendimento->dataHoraFim));
    *    $horarioVerao = date('I', strtotime($atendimento->dataHoraFim))*3600;
    *    $segundos = $datafim[0] - $datainic[0] ;
    *    $tempoAtend = date("H:i:s", $segundos + $horarioVerao);
    */       
        $result = $atendimento->update();
        return response()->json($result);
    }
    public function inserirComentario(Request $request, $id)
    {               
        $result = false;

        date_default_timezone_set('America/Sao_Paulo');
        $dataAtual  = date("Y-m-d H:i:s");  

        if(@$request->atendimento['comentario']) {
            $atendimentoComentario = new atendimentoComentario;
            $atendimentoComentario->comentario = $request->atendimento['comentario'];
            $atendimentoComentario->idAtendimento =$id;
            $atendimentoComentario->idUsuario =  Auth::id();
            $atendimentoComentario->dataHora = $dataAtual ;
            $result  = $atendimentoComentario->save();
        }

        return response()->json($result);        

    }

}
