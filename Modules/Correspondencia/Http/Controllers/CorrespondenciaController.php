<?php

namespace Modules\Correspondencia\Http\Controllers;

use Modules\Correspondencia\Entities\CorrespDest;
use Modules\Correspondencia\Entities\Correspondencia;
use Modules\Correspondencia\Entities\Endereco;
use Modules\Correspondencia\Entities\Destinatario;
use Modules\Correspondencia\Entities\Setor;
use Modules\Correspondencia\Entities\Tecnicos;
use Modules\Correspondencia\Entities\TipoCorrespondencia;
use Modules\Correspondencia\Entities\TipoLogradouro;
use Modules\Correspondencia\Entities\Municipios;
use Modules\Correspondencia\Entities\ListaPostagem;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
//use Illuminate\Routing\Controller;
use Nwidart\Modules\Routing\Controller;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\View;
use Illuminate\Support\Facades\Auth;

use PDF;
use DNS1D;
use DNS2D;

class CorrespondenciaController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index(Request $request)
    {
        $ascending =  $request->ascending == "true" ? "asc" : "desc";
        $setor =  $request->setor == "-1" ? '' : " and setor = ".$request->setor;
        $tipo = $request->tipo == "-1" ? '' : " and tipo = ".$request->tipo;
        $search = '';
        if(strlen ($request->search)>0){
            $request->search = utf8_decode($request->search);
            $searchSeq = is_numeric($request->search)? intval($request->search) : 'xxx';
            $search = " and (" .
                "assunto LIKE '%".strtolower($request->search)."%' or ".
                "referencia LIKE '%".strtolower($request->search)."%' or ".
                "sequencia LIKE '%".strtolower($searchSeq)."%')";
        }
            return Correspondencia::Ativo()
                ->whereRaw("situacao = 1 and ano = ".$request->ano. $setor .$tipo . $search)
                ->orderBy("codigo" , "desc")
                ->paginate($request->per_page);
    }

    /**
     * Show the form for creating a new resource.
     * @return Response
     */
    public function setores()
    {
        $cpf =  auth()->user()->cpf;
        $tecnico = Tecnicos::where('cpf', $cpf)->first();
        if (is_null($tecnico))
        {
            $this->inserirTecnico($cpf);
            $tecnico = Tecnicos::where('cpf', $cpf)->first();
        }
        $result = Setor::orderBy("descricao" , "asc")->get();
        $result[] = ['userSetor'=>$tecnico];
        return $result;
    }

    public function inserirTecnico($cpf)
    {
        $nome = auth()->user()->name;
        $email = auth()->user()->email;

        $tecnico = new Tecnicos;
        $tecnico->situacao = 1;
        $tecnico->responsavel = 13;
        $tecnico->perfil = 6;
        $tecnico->sitsenha = 2;
        $tecnico->horassem = 20;
        $tecnico->inipri = '08:00:00';
        $tecnico->fimpri = '12:00:00';
        $tecnico->iniseg = '00:00:00';
        $tecnico->fimseg = '00:00:00';
        $tecnico->setor = 18;
        $tecnico->DDDcoml = 48;
        $tecnico->numfonecoml = 32245399;
        $tecnico->email = $email;
        $tecnico->CPF = $cpf;
        $tecnico->apelido = "";
        $tecnico->nome = $nome;
        $tecnico->SIAPE = 0;
        $tecnico->senha = '';
        $tecnico->ramalcoml = 0;
        $tecnico->DDDcontato1 = 0;
        $tecnico->numcontato1 = 0;
        $tecnico->DDDcontato2 = 0;
        $tecnico->numcontato2 = 0;
        $tecnico->save();
    }

    public function tipos()
    {
        return TipoCorrespondencia::orderBy("descricao" , "asc")->get();        
    }

    public function tipoLogradouro()
    {
        return TipoLogradouro::orderBy("descricao" , "asc")->get();        
    }

    public function postagem($userLegado)    
    {
        $lista = ListaPostagem::Aberta()->first();
        
        if (is_null($lista))
        {
            $lista = new ListaPostagem;
            $lista->situacao = 3;
            $lista->ano = date('Y');
            $lista->tecnico = $userLegado;
            $lista->save();
            $lista = ListaPostagem::Aberta()->first();
            return $lista;
        }
        return $lista;
    }
        
    public function gerarEtiqueta($codigo)
    {
        $corr = Correspondencia::without('postagens')->where('codigo', $codigo)->first();
        $dest = CorrespDest::Preparado()->where("codcor","=",$codigo)->get();
        $corr->destinatarios =  $dest;
        $pdf = PDF::loadView('correspondencia.etiqueta_pdf', ['correspondencia'=> $corr])
                ->setOptions(['defaultFont' => 'Helvetica'])->setPaper('a4', 'portrait');                                   
        return $pdf->download('SPUSC_etiqueta.pdf');
    }

    public function gerarLista()
    {
        $lista = ListaPostagem::Aberta()->get();        
        $pdf = PDF::loadView('correspondencia.postagens_pdf', ['postagens'   => $lista])
                    ->setOptions(['defaultFont' => 'Helvetica'])->setPaper('a4', 'portrait');                                  
        return $pdf->download('SPUSC_postagens.pdf');
    }

    public function autocomplete()
    {
        return view('autocomplete');
    }

    public function pesquisaMunicipio(Request $request)
    {
        return Municipios::where('cidade','LIKE',$request->search.'%')->limit(10)->orderBy('cidade', 'asc')->get();
    }
    public function descartaCorresp($id)
    {
        $correspondencia = Correspondencia::findOrFail($id);
        $correspondencia->situacao = 2;
        return response()->json($correspondencia->update());
    }
    public function  concluirLista(){
        $lista = ListaPostagem::Aberta()->without(['tec_resp','destPost'])->first();
        $this->authorize('create', $lista);
        if (!$lista){
            return response()->json(['message' => "Lista não existe"], 404);
        }
        $numero = $lista->codigo;
        $updateValores = [
            'tipo_dev' => 5,
            'dtpost' =>date('Y-m-d H:i:s'),
            'dtcoleta' =>date('Y-m-d H:i:s')
        ];
//        return response()->json(['message' => " numero ".$data], 404);
        CorrespDest::Ativo()->where('lista',$numero)->update($updateValores);
        return response()->json(ListaPostagem::Aberta()->update(['situacao' => 4]));        
    }
    public function receberAR($id)
    {
        $dest = CorrespDest::findOrFail($id);
        $this->authorize('create', $dest);
        $dest->situacao_ar = 2;
        $dest->dtdev_ar = date('Y-m-d H:i:s');
        return response()->json($dest->update());
    }

    public function descartaDest($id)
    {
        $dest = CorrespDest::findOrFail($id);
        $dest->situacao = 2;
        return response()->json($dest->update());
    }
    public function descartarDestLista($id)
    {
        $dest = CorrespDest::findOrFail($id);
        $this->authorize('create', $dest);        
        $dest->tipo_dev = 2;
        $dest->lista = NULL;
        $dest->codcorreio = NULL;
        return response()->json($dest->update());        
    }
    public function criarCorrespondencia(Request $request)
    {
        $seq = $this->verificaSeq($request->tipo, $request->ano, $request->sequencia);
        if (!$seq){
            return response()->json(['message' => 'Documento SEI já existe'], 500);
        }
        $corr = new Correspondencia;
        $corr->tipo = $request->tipo;
        $corr->ano = $request->ano;
        $corr->sequencia = $seq;
        $corr->assunto = $request->assunto;
        $corr->referencia = $request->referencia;
        $corr->setor = $request->setor;
        $corr->tecnico = $request->userLegado;

        return response()->json($corr->save());
    }

    public function verificaSeq($tipo, $ano, $seq){
        $whereRaw = "tipo = ".$tipo ." and ano = ".$ano .($tipo > 15 ? " and sequencia = ".$seq : "");
        $seqResult = $tipo < 16 ?  1 : $seq;
        $corr = Correspondencia::Ativo()->whereRaw($whereRaw)->orderBy('sequencia', 'desc')->first();   
        return $corr == null ? $seqResult : ($tipo > 15 ?  null : $corr->sequencia + 1);                    
    }

    public function inserirLista(Request $request)
    {
        $codigo = substr($request->codigo, -6);
        $dest = CorrespDest::find($codigo);

        if ($dest == null) {
            return response()->json(['message' => "Etiqueta '".$request->lista."' não existe"], 404);
        }
        $this->authorize('create',$dest);
        $dest->tipo_dev = 3;
        $dest->lista = $request->lista;
        $dest->codcorreio = $request->codcorreio;
        return  response()->json($dest->update());        
    }

    public function criarDestinatario(Request $request)
    {
        $endereco = new Endereco;
        $endereco->tipo = 1;
        $endereco->tiplog = $request->tipo_log;
        $endereco->logradouro = $request->logradouro;
        $endereco->numero = $request->numero ? $request->numero : '';
        $endereco->complemento = $request->complemento ? $request->complemento : '';
        $endereco->bairro = $request->bairro ? $request->bairro : '';
        $endereco->CEP = $request->CEP;
        $endereco->cidade = $request->municipio;
        $endereco->save();

        $destinatario = new Destinatario;
        $destinatario->endereco = $endereco->codigo;
        $destinatario->tecnico = $request->userLegado;
        $destinatario->nome = $request->nome;
        $destinatario->situacao = 1;
        $destinatario->orgao = $request->linha01 != 'null' ? $request->linha01 : '';
        $destinatario->setor = $request->linha02 != 'null' ? $request->linha02 : '';
        $destinatario->save();

        $correspDest = new CorrespDest;
        $correspDest->codcor = $request->codcor;
        $correspDest->coddest =  $destinatario->codigo;
        $correspDest->tec_post = $request->userLegado;
        $correspDest->tipo_dev = 2;
        $correspDest->situacao = 1;
        $correspDest->obs_ar = '';
        return response()->json($correspDest->save());
    }
    
    public function create()
    {
        //return view('correspondencia::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Response
     */
    public function show($id)
    {
        //return view('correspondencia::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Response
     */
    public function edit($id)
    {
        //return view('correspondencia::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Response
     */
    public function destroy($id)
    {
        //
    }
}