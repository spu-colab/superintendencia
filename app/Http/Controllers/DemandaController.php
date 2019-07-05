<?php

namespace App\Http\Controllers;

use App\Demanda;
use App\DivisaoOrganograma;
use App\DistribuicaoDemanda;
use App\SituacaoDemanda;
use App\User;
use App\Http\Resources\DemandaResource;
use App\Http\Requests\DemandaRequest;
use App\Http\Requests\DistribuicaoDemandaRequest;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

use PDF;



class DemandaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Demanda::with(
            [
                'autor.cargo', 
                'autor.orgao',
                'procedimentoExterno.tipoProcedimentoExterno',
                'situacao',
                'distribuicoes.colaboradorDe',
                'distribuicoes.assignable'
            ]
        )->orderBy('dataPrazo')->get();
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
    public function store(DemandaRequest $request)
    {
        $validatedData = $request->validated();

        $demanda = new Demanda;
        $demanda->id = null;
        $demanda->idAutorDemanda = $request->demanda['idAutorDemanda'];
        $demanda->idProcedimentoExterno = @$request
            ->demanda['idProcedimentoExterno'];

        $demanda->idSituacaoDemanda = SituacaoDemanda::NOVA;

        $demanda->idTipoDocumento = $request->demanda['idTipoDocumento'];
        $demanda->documentoExterno = $request->demanda['documentoExterno'];
        $demanda->demanda = $request->demanda['demanda'];
        $demanda->resumoSituacao = $request->demanda['resumoSituacao'];
        if(@$request->demanda['dataDocumento'])
            $demanda->dataDocumento = $request->demanda['dataDocumento'];
        $demanda->nupSEI = $request->demanda['nupSEI'];
        $demanda->seiMP = $request->demanda['seiMP'];
        if(@$request->demanda['dataPrazo'])
            $demanda->dataPrazo = $request->demanda['dataPrazo'];
        $demanda->sentencajudicial = $request->demanda['sentencajudicial'];

        $demanda->idUsuarioCriacao = Auth::id();

        $this->authorize('create', $demanda);
    
        $demanda->save();        
        return response()->json($demanda);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Demanda  $Demanda
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        return Demanda::with([
            'autor.cargo', 
            'autor.orgao',
            'procedimentoExterno.tipoProcedimentoExterno',
            'situacao',
            'distribuicoes.colaboradorDe',
            'distribuicoes.assignable'
        ])->where('id', $id)->get();
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
     * @param  \App\Demanda  $demanda
     * @return \Illuminate\Http\Response
     */
    public function update(DemandaRequest $request, $id)
    {
        $validatedData = $request->validated();

        $demanda = Demanda::findOrFail($id);
        
        $demanda->idAutorDemanda = $request->demanda['idAutorDemanda'];
        $demanda->idProcedimentoExterno = $request->demanda['idProcedimentoExterno'];
        $demanda->idSituacaoDemanda = $request->demanda['idSituacaoDemanda'];
        $demanda->idTipoDocumento = $request->demanda['idTipoDocumento'];
        $demanda->documentoExterno = $request->demanda['documentoExterno'];
        $demanda->demanda = $request->demanda['demanda'];
        $demanda->resumoSituacao = $request->demanda['resumoSituacao'];
        $demanda->dataDocumento = @$request->demanda['dataDocumento'];
        $demanda->nupSEI = $request->demanda['nupSEI'];
        $demanda->seiMP = $request->demanda['seiMP'];
        $demanda->dataPrazo = @$request->demanda['dataPrazo'];
        $demanda->sentencajudicial = $request->demanda['sentencajudicial'];

        $demanda->idUsuarioAlteracao = Auth::id();

        $this->authorize('update', $demanda);
        $demanda->update();
        return response()->json($demanda);
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

    public function listarAtribuiveis() {
        $divisoes = DB::table('divisaoorganograma')
            ->select(DB::raw("concat(id, ':DivisaoOrganograma') as id, sigla as text"));
            //->get();
        $usuarios = DB::table('users')
            ->select(DB::raw("concat(id, ':User') as id, name as text"))
            ->union($divisoes)
            ->orderBy('text')
            ->get();

        return $usuarios;
    }

    public function salvarDistribuicao(DistribuicaoDemandaRequest $request, $id = null)
    {
        $validatedData = $request->validated();

        $demanda = Demanda::findOrFail($request->distribuicao['idDemanda']);
        $this->authorize('update', $demanda);

        if(!is_null($id)) {
            $distribuicao = DistribuicaoDemanda::findOrFail($id);
        } else {
            $distribuicao = new DistribuicaoDemanda;
        }
        
        $distribuicao->comentarioDistribuicao = $request->distribuicao['comentarioDistribuicao'];
        $distribuicao->comentarioAtendimento = $request->distribuicao['comentarioAtendimento'];

        if(is_null($distribuicao->id)) {
            $distribuicao->idDemanda = $request->distribuicao['idDemanda'];
            $distribuicao->idUsuarioDe = $request->distribuicao['idUsuarioDe'];
            $distribuicao->assignable_id = $request->distribuicao['assignable_id'];
            $distribuicao->assignable_type = $request->distribuicao['assignable_type'];
            $distribuicao->dataDistribuicao = new \DateTime();
            $distribuicao->save();
        } else {
            if($request->marcarComoAtendida) {
                $distribuicao->dataAtendimento = new \DateTime();
            }
            $distribuicao->update();
        }

        return response()->json($distribuicao);
    }

    public function cancelar(Request $request) {
        $validatedData = $request->validate(
            [
                'demanda.id' => 'required|int',
            ]
        );
        $demanda = Demanda::findOrFail($request->demanda['id']);
        $this->authorize('update', $demanda);

        if ($demanda->idSituacaoDemanda == SituacaoDemanda::RESOLVIDA) {
            abort(403, 'Unauthorized action.');
        }

        $demanda->idSituacaoDemanda = SituacaoDemanda::CANCELADA;
        $demanda->idUsuarioAlteracao = Auth::id();
        $demanda->update();

        return response()->json($demanda);
    }

    public function aguardarAssinatura(Request $request) {
        $validatedData = $request->validate(
            [
                'demanda.id' => 'required|int',
            ]
        );
        $demanda = Demanda::findOrFail($request->demanda['id']);
        $this->authorize('update', $demanda);
        

        if ($demanda->idSituacaoDemanda != SituacaoDemanda::PRONTA) {
            abort(403, 'Unauthorized action.');
        }

        $demanda->idSituacaoDemanda = SituacaoDemanda::AGUARDANDO_ASSINATURA;
        $demanda->idUsuarioAlteracao = Auth::id();
        $demanda->update();

        return response()->json($demanda);
    }

    public function aguardarAR(Request $request) {
        $validatedData = $request->validate(
            [
                'demanda.id' => 'required|int',
            ]
        );
        $demanda = Demanda::findOrFail($request->demanda['id']);
        $this->authorize('update', $demanda);

        if ($demanda->idSituacaoDemanda != SituacaoDemanda::AGUARDANDO_ASSINATURA) {
            abort(403, 'Unauthorized action.');
        }

        $demanda->idSituacaoDemanda = SituacaoDemanda::AGUARDANDO_AR;
        $demanda->idUsuarioAlteracao = Auth::id();
        $demanda->dataResposta = new \DateTime();
        $demanda->update();

        return response()->json($demanda);
    }

    public function resolver(Request $request) {
        $validatedData = $request->validate(
            [
                'demanda.id' => 'required|int',
            ]
        );
        $demanda = Demanda::findOrFail($request->demanda['id']);
        $this->authorize('update', $demanda);

        if ($demanda->idSituacaoDemanda != SituacaoDemanda::AGUARDANDO_AR) {
            abort(403, 'Unauthorized action.');
        }

        $demanda->idSituacaoDemanda = SituacaoDemanda::RESOLVIDA;
        $demanda->idUsuarioAlteracao = Auth::id();
        $demanda->update();

        return response()->json($demanda);
    }

    public function relatorioEntradaSaidaDiaria()
    {
        return response()->json(DB::select( DB::raw
            ("
            SELECT 
                dias.dia,
                IF(criadas.criada, criadas.criada, 0) as criadas,
                cast(IF(respondidas.respondidas, respondidas.respondidas, 0) as unsigned) as respondidas,
                cast(IF(canceladas.canceladas, canceladas.canceladas, 0) as unsigned) as canceladas
            FROM ( 
                -- TABELA COM A SEQUENCIA DE DIAS
                SELECT 
                    DATE_FORMAT(DATE(cal.date), '%Y-%m-%d') as dia
                FROM (
                    SELECT SUBDATE(NOW(), INTERVAL 30 DAY) + INTERVAL xc DAY AS date
                    FROM (
                            SELECT @xi:=@xi+1 as xc from
                            (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) xc1,
                            (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) xc2,
                            (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) xc3,
                            (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) xc4,
                            (SELECT @xi:=-1) xc0
                    ) xxc1
                ) cal
                WHERE cal.date <= NOW()
                ORDER BY cal.date DESC
                ) dias 

                -- CRIADAS POR DIA
                LEFT JOIN (
                    SELECT
                        DATE_FORMAT(d.datadocumento, '%Y-%m-%d') as dia_c,
                        count(d.id) as criada
                    FROM 
                        demanda d
                    WHERE
                        d.datadocumento >= DATE_SUB(NOW(), INTERVAL 30 day)
                    GROUP BY dia_c
                ) criadas ON dias.dia = criadas.dia_c 

                -- RESPONDIDAS POR DIA 
                LEFT JOIN (
                    SELECT 
                        dia, 
                        sum(respondida) as respondidas 
                    FROM ( 
                        SELECT 
                            DATE_FORMAT(updated_at, '%Y-%m-%d') as dia, 
                            IF(idSituacaoDemanda = 3, 1, 0) as respondida 
                        FROM 
                            demanda 
                        WHERE 
                            updated_at >= DATE_SUB(NOW(), INTERVAL 30 day) 
                    ) as soma_respondidas 
                    GROUP BY dia 
                ) respondidas ON dias.dia = respondidas.dia 

                -- CANCELADAS POR DIA
                LEFT JOIN (
                    SELECT 
                        dia,
                        sum(cancelada) as canceladas
                    FROM (
                        SELECT
                            DATE_FORMAT(d.updated_at, '%Y-%m-%d') as dia,
                            IF(d.idSituacaoDemanda = 4, 1, 0) as cancelada
                        FROM 
                            demanda d
                        WHERE
                            d.updated_at >= DATE_SUB(NOW(), INTERVAL 30 day)
                    ) as soma_canceladas 
                    GROUP BY dia
                ) canceladas ON dias.dia = canceladas.dia 
                ORDER BY 1  
            ")));
    }

    public function relatorioAbertasPorSituacao()
    {
        return response()->json(DB::select( DB::raw
            ('
            SELECT 
                cast(sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Nova") then 1 else 0 end) as unsigned) as nova,
                cast(sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Em análise") then 1 else 0 end) as unsigned) as em_analise,
                cast(sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Pronta") then 1 else 0 end) as unsigned) as pronta,
                cast(sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Aguardando assinatura") then 1 else 0 end) as unsigned) as aguardando_assinatura,
                cast(sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Aguardando AR") then 1 else 0 end) as unsigned) as aguardando_ar
            FROM 
                demanda 
            -- WHERE 
            --    idSituacaoDemanda IN (SELECT id FROM situacaodemanda WHERE situacao IN ("Nova", "Em análise", "Pronta"))
            ')));
    }

    public function relatorioAbertasPorDistribuicao()
    {
        $div = "\\\\";
        return response()->json(DB::select( DB::raw
            ('
                SELECT 
                    case dd.assignable_type when 
                        "App'.$div.'User" then u.name 
                        else do.sigla 
                        end as colaborador,
                cast(count(dd.id) as unsigned) as demandas_distribuidas
                FROM
                    demanda d
                    JOIN distribuicaodemanda dd ON dd.idDemanda = d.id
                    JOIN situacaodemanda sd ON sd.id = d.idSituacaoDemanda
                    LEFT JOIN users u ON u.id = dd.assignable_id AND dd.assignable_type = "App'.$div.'User"
                    LEFT JOIN divisaoorganograma do ON do.id = dd.assignable_id AND dd.assignable_type = "App'.$div.'DivisaoOrganograma"
                WHERE
                    sd.situacao = "Em análise" AND 
                    dd.dataAtendimento is null
                GROUP BY
                    1 
                ORDER BY 2 desc, 1'
            )
        ));
    }

    public function relatorioAbertasPorDemandante()
    {
        return response()->json(DB::select( DB::raw
            ('
            SELECT 
                -- ad.nome as demandante,
                o.sigla as orgao,
                count(d.id) as total,
                cast(sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Nova") then 1 else 0 end) as unsigned) as nova,
                cast(sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Em análise") then 1 else 0 end) as unsigned) as em_analise,
                cast(sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Pronta") then 1 else 0 end) as unsigned) as pronta,
                cast(sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Aguardando assinatura") then 1 else 0 end) as unsigned) as aguardando_assinatura,
                cast(sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Aguardando AR") then 1 else 0 end) as unsigned) as aguardando_ar,
                cast(sum(case idSituacaoDemanda when (SELECT id FROM situacaodemanda WHERE situacao = "Resolvida") then 1 else 0 end) as unsigned) as resolvida
            FROM 
                demanda d
                JOIN autordemanda ad ON d.idAutorDemanda = ad.id
                JOIN orgao o ON ad.idOrgao = o.id
            WHERE 
                d.idSituacaoDemanda IN (SELECT id FROM situacaodemanda WHERE situacao IN ("Nova", "Em análise", "Pronta", "Aguardando assinatura", "Aguardando AR", "Resolvida"))
                -- AND d.created_at BETWEEN \'2019-05-01\' AND \'2019-06-01\' 
            GROUP BY 1
            ORDER BY 2 desc, 1 asc;'
            )
        ));
    }

    public function listarPorProcedimentoExterno($idProcedimentoExterno)
    {
        return Demanda::with([
            'autor.cargo', 
            'autor.orgao',
            // 'procedimentoExterno.tipoProcedimentoExterno',
            'situacao',
            // 'distribuicoes.colaboradorDe',
            // 'distribuicoes.assignable'
        ])->where('idProcedimentoExterno', $idProcedimentoExterno)->get();
    }

    public function gerarPDF($idDemanda) {
        $demanda = $this->show($idDemanda);
        return view('demanda.pdf')->with('demanda', compact($demanda));
        /*
        $pdf = PDF::loadView('demanda.pdf', [
            'demanda'   => $demanda
        ]);
        return $pdf->download('eSPU-SC_Demanda.pdf');
        */

    }
}
