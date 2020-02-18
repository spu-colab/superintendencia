<?php

namespace App\Http\Controllers;

use App\Demanda;
use Modules\Auth\Entities\DivisaoOrganograma;
use App\DistribuicaoDemanda;
use App\SituacaoDemanda;
use App\User;
use App\Http\Resources\DemandaResource;
use App\Http\Requests\DemandaRequest;
use App\Http\Requests\DistribuicaoDemandaRequest;
use App\Repositories\DemandaRepositoryI;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

use PDF;



class DemandaController extends Controller
{

    public function __construct(DemandaRepositoryI $demandaRepository) {
        $this->repository = $demandaRepository;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $per_page = $request->input('per_page');
        $result = Demanda::with(
            [
                'autor.cargo', 
                'autor.orgao',
                'procedimentoExterno.tipoProcedimentoExterno',
                'situacao',
                'distribuicoes.colaboradorDe',
                'distribuicoes.assignable'
            ]
        )->orderBy('dataPrazo')->get();
        // ->paginate($per_page);
        return $result;
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
            'tipoDocumento',
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

        // $this->authorize('update', $demanda);
        $user = Auth::user();
        $usuario = User::with(['permissoes'])->find($user->id);
        $usuarioPodeCadastrar = $usuario->permissoes()
            ->where('permissao', 'DEMANDA_DEMANDA_CADASTRAR')->first();

        $usuarioPodeAlterarResumoGerencial = $usuarioPodeCadastrar;
        if(!$usuarioPodeAlterarResumoGerencial) {
            $usuarioPodeAlterarResumoGerencial = $usuario->permissoes()
                ->where('permissao', 'DEMANDA_DEMANDA_ALTERAR_RESUMO_GERENCIAL')->first();
        }

        if(!$usuarioPodeCadastrar && !$usuarioPodeAlterarResumoGerencial) {
            return response()->json(['error' => 'Transação não autorizada.'], 403);
        }

        if($usuarioPodeCadastrar) {
            $demanda->idAutorDemanda = $request->demanda['idAutorDemanda'];
            $demanda->idProcedimentoExterno = $request->demanda['idProcedimentoExterno'];
            $demanda->idSituacaoDemanda = $request->demanda['idSituacaoDemanda'];
            $demanda->idTipoDocumento = $request->demanda['idTipoDocumento'];
            $demanda->documentoExterno = $request->demanda['documentoExterno'];
            $demanda->demanda = $request->demanda['demanda'];
            $demanda->dataDocumento = @$request->demanda['dataDocumento'];
            $demanda->nupSEI = $request->demanda['nupSEI'];
            $demanda->seiMP = $request->demanda['seiMP'];
            $demanda->dataPrazo = @$request->demanda['dataPrazo'];
            $demanda->sentencajudicial = $request->demanda['sentencajudicial'];
        }
        $demanda->resumoSituacao = $request->demanda['resumoSituacao'];

        $demanda->idUsuarioAlteracao = Auth::id();
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
        
        // $this->authorize('update', $demanda);
        $user = Auth::user();
        $usuario = User::with(['permissoes'])->find($user->id);

        $usuarioPodeCadastrar = $usuario->permissoes()
            ->where('permissao', 'DEMANDA_DEMANDA_CADASTRAR')->first();

        $usuarioPodeAtenderDistribuicao = $usuarioPodeCadastrar;
        if(!$usuarioPodeAtenderDistribuicao) {
            $usuarioPodeAtenderDistribuicao = $usuario->permissoes()
                ->where('permissao', 'DEMANDA_DEMANDA_ATENDER_DISTRIBUICAO')->first();
        }
        if(!$usuarioPodeCadastrar && !$usuarioPodeAtenderDistribuicao) {
            return response()->json(['error' => 'Transação não autorizada.'], 403);
        }
        $usuarioSoPodeAtender = !$usuarioPodeCadastrar && $usuarioPodeAtenderDistribuicao;
        
        if(!is_null($id)) {
            $distribuicao = DistribuicaoDemanda::findOrFail($id);            
        } else {
            $distribuicao = new DistribuicaoDemanda;
        }
        
        $distribuidaParaOProprioUsuario = $distribuicao->assignable_type == 'App\User' 
            && $distribuicao->assignable_id == $user->id;

        $distribuidaParaDivisaoUsuario = $distribuicao->assignable_type == 'Modules\Auth\Entities\DivisaoOrganograma';
        if($distribuidaParaDivisaoUsuario) {
            $distribuidaParaDivisaoUsuario = $usuario->divisoesOrganograma()
                ->where('divisaoorganograma.id', $distribuicao->assignable_id)->first();
        }       

        $distribuicao->comentarioAtendimento = $request->distribuicao['comentarioAtendimento'];
        if($usuarioPodeCadastrar) {
            $distribuicao->comentarioDistribuicao = $request->distribuicao['comentarioDistribuicao'];
        }

        if(is_null($distribuicao->id)) {
            // se trata de criação
            if(!$usuarioPodeCadastrar) {
                return response()->json(['error' => 'Transação não autorizada.'], 403);
            }
            $distribuicao->idDemanda = $request->distribuicao['idDemanda'];
            $distribuicao->idUsuarioDe = $request->distribuicao['idUsuarioDe'];
            $distribuicao->assignable_id = $request->distribuicao['assignable_id'];
            $distribuicao->assignable_type = $request->distribuicao['assignable_type'];
            $distribuicao->dataDistribuicao = new \DateTime();
            $distribuicao->save();
        } else {
            // se trata de edição
            if($usuarioSoPodeAtender && !$distribuidaParaOProprioUsuario && !$distribuidaParaDivisaoUsuario) {
                return response()->json(['error' => 'Transação não autorizada.'], 403);
            }
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
        $this->authorize('cancelar', $demanda);

        if ($demanda->idSituacaoDemanda == SituacaoDemanda::RESOLVIDA) {
            abort(403, 'Usuário não possui permissão para executar esta operação.');
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
        $this->authorize('aguardarAssinatura', $demanda);

        if ($demanda->idSituacaoDemanda != SituacaoDemanda::PRONTA) {
            abort(403, 'Operação não permitida para esta demanda.');
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
        $this->authorize('aguardarAR', $demanda);

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
        $this->authorize('resolver', $demanda);

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

    /*
    public function relatorioAbertasPorSituacao_()
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
    */

    private function stringDataDocumentoDeAte($campo, $dataDe = null, $dataAte = null) {
        $sql = " ";
        if($dataDe != null && $dataAte != null) {
            $sql .= " AND $campo BETWEEN '$dataDe' AND '$dataAte' ";
        } else {
            if($dataDe != null) {
                $sql .= " AND $campo >= '$dataDe' ";
            } elseif($dataAte != null) {
                $sql .= " AND $campo <= '$dataAte' ";
            }
        }
        return $sql;
    }

    public function relatorioAbertasPorNaturezaOrgao($dataDe = null, $dataAte = null) 
    {
        $sql = "
            SELECT 
            nao.id, 
            nao.natureza, 
            count(d.id) as quantidade
            FROM 
            demanda d 
            JOIN autordemanda ad ON d.idAutorDemanda = ad.id 
            JOIN orgao o ON ad.idOrgao = o.id 
            JOIN naturezaorgao nao ON o.idNaturezaOrgao = nao.id 
            WHERE
            true "; //d.idsituacaodemanda NOT IN (3,4) ";
        
            $sql .= $this->stringDataDocumentoDeAte('d.dataDocumento', $dataDe, $dataAte);

        $sql .= " 
            GROUP BY 1, 2 
            ORDER BY 3 desc
        ";
        // return $sql;
        return response()->json(DB::select( DB::raw($sql)));
    }

    public function relatorioEstatisticaPeriodo($dataDe = null, $dataAte = null)
    {
        $sqlDeAte = $this->stringDataDocumentoDeAte('dataDocumento', $dataDe, $dataAte);
        $sqlResolvidaDeAte = $this->stringDataDocumentoDeAte('d.updated_at', $dataDe, $dataAte);
        $sql = "
        SELECT
            (SELECT count(id) FROM demanda WHERE true $sqlDeAte ) as recebidas,
            (SELECT count(d.id) FROM demanda d JOIN situacaodemanda sd ON d.idsituacaodemanda = sd.id WHERE sd.situacao = 'Resolvida' $sqlResolvidaDeAte ) as resolvidas,
            (SELECT count(id) FROM demanda WHERE idsituacaodemanda NOT IN (3,4) $sqlDeAte ) as em_analise,
            (SELECT count(id) FROM demanda WHERE idsituacaodemanda NOT IN (3,4) 
                AND DATE_FORMAT(dataPrazo, '%Y-%m-%d') < DATE_FORMAT(NOW(), '%Y-%m-%d')
                AND dataResposta IS NULL $sqlDeAte ) as atrasadas,
            (SELECT count(id) FROM demanda WHERE idsituacaodemanda NOT IN (3,4) 
                AND sentencajudicial = true $sqlDeAte ) as sentencas_judiciais
        ";
        return response()->json(DB::select( DB::raw($sql)));
    }

    public function relatorioAbertasPorDistribuicao($dataDe = null, $dataAte = null)
    {
        $div = "\\\\";

        $sqlDeAte = $this->stringDataDocumentoDeAte('d.dataDocumento', $dataDe, $dataAte);

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
                    LEFT JOIN divisaoorganograma do ON do.id = dd.assignable_id AND dd.assignable_type = "Modules'.$div.'Auth'.$div.'Entities'.$div.'DivisaoOrganograma"
                WHERE 
                    sd.situacao = "Em análise" 
                    AND dd.dataAtendimento is null 
                    '.$sqlDeAte.'
                GROUP BY
                    1 
                ORDER BY 2 desc, 1'
            )
        ));
    }

    public function relatorioAbertasPorDemandante($dataDe = null, $dataAte = null)
    {
        $sqlDeAte = $this->stringDataDocumentoDeAte('d.dataDocumento', $dataDe, $dataAte);

        $sql = '
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
            ' . $sqlDeAte . '
        GROUP BY 1
        ORDER BY 2 desc, 1 asc;';

        return response()->json(DB::select( DB::raw($sql)));
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

    public function gerarPDF($ids) {
        //$demandasIds = explode(",", $request->input('demandaIds'));
        $demandasIds = explode(",", $ids);
        $demandas = [];
        foreach ($demandasIds as $idDemanda) {
            $demanda = @$this->show($idDemanda)[0];
            if($demanda) {
                $demandas[] = $demanda;
            }
        }
        // return $demandas;
        // return view('demanda.pdf')->with('demandas', $demandas);
        $pdf = PDF::loadView('demanda.pdf', [
            'demandas'   => $demandas
            ]);
        return $pdf->download('eSPU-SC_Demanda.pdf');
    }

    public function gerarPDFAcompanhamento(Request $request, DemandaRepositoryI $respository) {
        $demandas = array();

        $divisoesOrganogramas = DivisaoOrganograma::select(['id', 'nome', 'sigla'])->orderBy('nome')->get();
        foreach ($divisoesOrganogramas as $key => $divisaoOrganograma) {
            if($request['incluirReprimidas'] == "true" || $divisaoOrganograma->id != DivisaoOrganograma::DEMANDA_REPRIMIDA) {
                $demandas['divisoesOrganogramas'][$key] = $divisaoOrganograma;
                
                $demandasIds = $respository->listarIdsDemandasDistribuidasPara($divisaoOrganograma);
                $demandas['divisoesOrganogramas'][$key]['demandas'] = Demanda::with(
                    [
                        'autor.cargo', 
                        'autor.orgao',
                        'procedimentoExterno.tipoProcedimentoExterno'
                    ]
                )->whereIn('id', $demandasIds)->get();
            }
        }

        // return $demandas;
        // return view('demanda.acompanhamento_pdf')->with('demandas', $demandas);

        $pdf = PDF::loadView('demanda.acompanhamento_pdf', [
            'demandas'   => $demandas
            ]);
        return $pdf->download('eSPU-SC_Demanda.pdf');
    }

    public function listarDistribuidasParaUsuario(User $user) {
        return $this->repository->listarDistribuidasParaUsuario($user);
    }

    public function listarDistribuidasParaDivisaoOrganograma(DivisaoOrganograma $divisaoOrganograma) {
        return $this->repository->listarDistribuidasParaDivisaoOrganograma($divisaoOrganograma);
    }
}
