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
     * Cria um atendimento recém iniciado
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(AtendimentoRequest $request)
    {        
        $atendimento = new Atendimento;
        $atendimento->idUsuario = Auth::id();        
        $atendimento->idtipo = $request->idtipo;
        $atendimento->atendido = $request->atendido;
        date_default_timezone_set('America/Sao_Paulo');
        $atendimento->dataHoraInicio = date("Y-m-d H:i:s");
        if($atendimento->save()) {
            return response()->json($atendimento);
        } else {
            \abort(500, "Erro ao criar atendimento");
        }
    }

    public function listarAssuntos()
    {
        $result = Assunto::orderBy('assunto')->get();
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

    /*
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
    */


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
     * Atualiza um atendimento.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(AtendimentoRequest $request, $id)
    {
        $atendimento = Atendimento::findOrFail($id);
        $atendimentoSalvo = $this->salvar($atendimento, $request);
        return response()->json($atendimentoSalvo);
    }

    public function concluir(AtendimentoRequest $request, $id) {
        $atendimento = Atendimento::findOrFail($id);
        $atendimentoSalvo = $this->salvar($atendimento, $request, true);
        return response()->json($atendimentoSalvo);
    }
    
    public function salvar(Atendimento $atendimento, AtendimentoRequest $request, $concluirAtendimento = false) {
        $atendimento->atendido = $request->atendido;
        $atendimento->cpf = $request->cpf;
        $atendimento->email = $request->email;
        
        Atendimento_Assunto::where('idatendimento', $atendimento->id)->delete();
        $idsAssunto = @$request->idsAssunto;
        if($idsAssunto) {
            $dataSet = [];
            foreach ($idsAssunto as $idAssunto) {
                $dataSet[] = [
                    'idAtendimento'  => $atendimento->id,
                    'idAssunto' => $idAssunto,
                ];
            }
            Atendimento_Assunto::insert($dataSet);
        }
        
        if($concluirAtendimento) {
            $dataAtual  = date("Y-m-d H:i:s");  
            $atendimento->dataHoraFim  = $dataAtual;  
        }
        if($atendimento->update()) {
            return $atendimento;
        } else {
            \abort(500, "Erro ao salvar atendimento");
        }
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
