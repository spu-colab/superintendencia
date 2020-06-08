<?php

namespace Modules\Patrimonio\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Modules\Patrimonio\Entities\BensPatrimonio;
use Modules\Patrimonio\Entities\BensSala;
use Modules\Patrimonio\Entities\BensCategoria;
use Modules\Patrimonio\Entities\BensSituacao;
use Modules\Patrimonio\Entities\BensConservacao;
use Modules\Patrimonio\Entities\BensLevantamento;
use Modules\Patrimonio\Entities\BensResponsavel;
use Modules\Auth\Entities\DivisaoOrganograma;
use Modules\Auth\Entities\UsuarioDivisaoOrganograma;
use Illuminate\Support\Facades\Auth;
USE app\Permissao;
use App\User;
use PDF;
class PatrimonioController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index(Request $request)
    {
        $consulta = BensPatrimonio::
            selectRaw('bens_patrimonio.*, bens_categoria.descricao as categoria, 
                bens_situacao.descricao as situacao, bens_levantamento.descricao as levantamento,
                bens_conservacao.descricao as conservacao, bens_sala.descricao as localizacao, 
                users.name as responsavel, users.id as idResponsavel')
            ->whereRaw('bens_patrimonio.idSituacao not in  (2 , 9)')                        
            ->leftJoin('bens_sala','bens_sala.id' , '=', 'bens_patrimonio.idSala')
            ->leftJoin('bens_conservacao','bens_conservacao.id' , '=', 'bens_patrimonio.idConservacao')
            ->leftJoin('bens_levantamento','bens_levantamento.id' , '=', 'bens_patrimonio.idLevantamento')
            ->leftJoin('bens_categoria','bens_categoria.id' , '=', 'bens_patrimonio.idCategoria')
            ->leftJoin('bens_situacao','bens_situacao.id' , '=', 'bens_patrimonio.idSituacao')
            ->leftJoin('bens_responsavel', function ($join) {
                $join->on('bens_patrimonio.id', '=', 'bens_responsavel.idPatrimonio')
                    ->where('bens_responsavel.deleted_at', '=', NULL);
                })
            ->leftJoin('users','users.id' , '=', 'bens_responsavel.idUserResp');
        if($request->search) {                    
           $consulta->whereRaw ("(codigo LIKE '%".strtolower($request->search)."%'")
            ->orWhereRaw ("bens_patrimonio.descricao LIKE '%".strtolower($request->search)."%'")
            ->orWhereRaw ("bens_categoria.descricao LIKE '%".strtolower($request->search)."%'")
            ->orWhereRaw ("bens_situacao.descricao LIKE '%".strtolower($request->search)."%'")
            ->orWhereRaw ("bens_sala.descricao LIKE '%".strtolower($request->search)."%'")
            ->orWhereRaw ("users.name LIKE '%".strtolower($request->search)."%')");
        }
        return ($consulta->orderBy('codigo','asc')->paginate($request->per_page));
    }
    public function sala()
    {
        return (BensSala::orderBy('descricao','asc')->get());        
    }
    
    public function divisao(Request $request)
    {
        $consulta = BensSala::selectRaw('divisaoorganograma.id as idDivisao, sigla, bens_sala.id, descricao')
            ->leftJoin('divisaoorganograma','divisaoorganograma.id' , '=', 'bens_sala.idDivisaoOrganograma');
        if($request->search) { 
            $consulta->whereRaw("(nome LIKE '%".strtolower($request->search)."%'")
                ->orWhereRaw ("descricao LIKE '%".strtolower($request->search)."%'")
                ->orWhereRaw ("sigla LIKE '%".strtolower($request->search)."%')");
        }
        return ($consulta->orderByRaw('sigla asc, descricao asc')->paginate($request->per_page));
    }
    
    public function categoria()
    {
        return (BensCategoria::orderBy('descricao','asc')->get());        
    }
    public function tabelas()
    {
        $sala = BensSala::orderBy('descricao','asc')->get();
        $categoria = BensCategoria::orderBy('descricao','asc')->get();
        $situacao = BensSituacao::whereRaw('id not in (9)')->orderBy('descricao','asc')->get();
        $sitRel = BensSituacao::orderBy('descricao','asc')->get();
        $levantamento = BensLevantamento::orderBy('descricao','asc')->get();
        $conservacao = BensConservacao::orderBy('descricao','asc')->get();
        $responsavel = User::selectRaw('name, id')->orderBy('name','asc')->Ativos()->get();
        $podeCadastrar  = $this->podeCadastrar();
        $divisao = DivisaoOrganograma::selectRaw('sigla as descricao, id')->orderBy('descricao','asc')->Ativos()->get();
        $result['sala'] =  $sala;
        $result['categoria'] =  $categoria;
        $result['situacao'] =  $situacao;
        $result['levantamento'] =  $levantamento;
        $result['conservacao'] =  $conservacao;
        $result['responsavel'] =  $responsavel;
        $result['divisao'] =  $divisao;
        $result['sitRel'] =  $sitRel;
        $result['podeCadastrar'] =  $podeCadastrar;
        return response()->json($result);
    }

    /**
     * Show the form for creating a new resource.
     * @return Response
     */

    public function gerarTermo($id){
        $usuario = User::findOrFail($id);
        $usuarioDivisao = UsuarioDivisaoOrganograma::where('idUsuario', $id)->first();
        $idDivisao = $usuarioDivisao ? $usuarioDivisao->idDivisaoOrganograma : 1;
        $divisao = DivisaoOrganograma::where('id',  $idDivisao)->first();
        $patrimonio = BensPatrimonio::
            selectRaw('bens_patrimonio.preco, bens_patrimonio.codigo, bens_patrimonio.descricao as descricao,  
                bens_categoria.descricao as categoria')
            ->whereRaw('bens_patrimonio.idSituacao not in  (2 , 9) and bens_responsavel.idUserResp = '.$id)                        
            ->leftJoin('bens_categoria','bens_categoria.id' , '=', 'bens_patrimonio.idCategoria')
            ->leftJoin('bens_responsavel', function ($join) {
                $join->on('bens_patrimonio.id', '=', 'bens_responsavel.idPatrimonio')
                    ->where('bens_responsavel.deleted_at', '=', NULL);
                })
            ->orderBy('codigo','asc')
            ->get();    
        $result['divisao'] = $divisao->sigla;            
        $result['responsavel'] = $usuario->name;
        $result['item'] = $patrimonio;
        $pdf = PDF::loadView('patrimonio.termoResponsabilidade_pdf', ['bens'   =>$result])
                    ->setOptions(['defaultFont' => 'Helvetica'])->setPaper('a4', 'portrait');                                  
        return $pdf->download('SPU_relatorioBens.pdf');
    }
    public function gerarRelatorio(Request $request)
    {
        $siglaDivisao = $request->idDivisao == 'null' ? '' : 
                        DivisaoOrganograma::select('sigla')->find($request->idDivisao);
        $ordem = ($request->agrupamento == 1) ? 'bens_sala.idDivisaoOrganograma asc, bens_sala.descricao asc, ' :
                        (($request->agrupamento == 2)? 'users.name asc, ':'');
        $ordem .= 'codigo asc';
        $where = '1 = 1';
        $where .= $request->idDivisao != 'null' ? ' and bens_sala.idDivisaoOrganograma = '.$request->idDivisao : '';
        $where .= ($request->idSituacao == 9) ? 
            ' and bens_situacao.id = 2 and bens_termo_desfazimento.concluido_em IS NOT NULL ' : 
            (($request->idSituacao == 2) ? 
            ' and bens_situacao.id = 2 and bens_termo_desfazimento.concluido_em IS NULL' : 
            (($request->idSituacao != 'null') ? ' and bens_situacao.id = '.$request->idSituacao :
            ' and bens_termo_desfazimento.concluido_em IS NULL'));
        $where .= $request->idLevantamento != 'null' ? ' and bens_levantamento.id = '.$request->idLevantamento : '';
        $where .= $request->idConservacao != 'null' ? ' and bens_conservacao.id = '.$request->idConservacao : '';
        $where .= $request->idCategoria != 'null' ? ' and bens_categoria.id = '.$request->idCategoria : '';
        $consulta = BensPatrimonio::
            selectRaw('bens_patrimonio.*, bens_categoria.descricao as categoria, 
                bens_situacao.descricao as situacao, bens_levantamento.descricao as levantamento,
                bens_conservacao.descricao as conservacao, bens_sala.descricao as localizacao, 
                bens_sala.idDivisaoOrganograma as idDivisao, bens_termo_desfazimento.concluido_em,
                bens_termo_desfazimento.destino, bens_termo_desfazimento.processo, bens_termo_desfazimento.oficio,
                bens_termo_desfazimento.despacho, bens_termo_desfazimento.observacoes,
                users.name as responsavel, users.id as idResponsavel')
            ->whereRaw($where)
            ->leftJoin('bens_sala','bens_sala.id' , '=', 'bens_patrimonio.idSala')
            ->leftJoin('bens_termo_desfazimento','bens_termo_desfazimento.id' , '=', 'bens_patrimonio.idDesfazimento')
            ->leftJoin('bens_conservacao','bens_conservacao.id' , '=', 'bens_patrimonio.idConservacao')
            ->leftJoin('bens_levantamento','bens_levantamento.id' , '=', 'bens_patrimonio.idLevantamento')
            ->leftJoin('bens_categoria','bens_categoria.id' , '=', 'bens_patrimonio.idCategoria')
            ->leftJoin('bens_situacao','bens_situacao.id' , '=', 'bens_patrimonio.idSituacao')
            ->leftJoin('bens_responsavel', function ($join) {
                $join->on('bens_patrimonio.id', '=', 'bens_responsavel.idPatrimonio')
                    ->where('bens_responsavel.deleted_at', '=', NULL);
                })
            ->leftJoin('users','users.id' , '=', 'bens_responsavel.idUserResp')->orderByRaw($ordem)->get();
        $result['item'] = $consulta;
        $result['divisao'] = $siglaDivisao ? $siglaDivisao->sigla : '';
        $result['conservacao'] =  $request->idConservacao;
        $result['levantamento'] =  $request->idLevantamento;
        $result['situacao'] =  $request->idSituacao;
        $result['agrupamento'] =  $request->agrupamento;
        $pdf = PDF::loadView('patrimonio.relPatrimonio_pdf', ['bens'   => $result])
                    ->setOptions(['defaultFont' => 'Helvetica'])->setPaper('a4', 'portrait');                                  
        return $pdf->download('SPU_relatorioBens.pdf');
    }
    public function podeCadastrar()
    {
        $user = Auth::user();
        $usuario = User::with(['permissoes'])->find($user->id);
        
        return $usuario->permissoes()
            ->where('permissao', Permissao::PATRIMONIO_PATRIMONIO_CADASTRAR)->first();
        
    }
    
    public function create()
    {
        return view('patrimonio::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function criarLocal(Request $request){
        $sala = new BensSala;
        $sala->idDivisaoOrganograma = $request->idDivisaoOrganograma;
        $sala->descricao = $request->descricao;
        $sala->idUser = auth()->user()->id;
        return ($sala->save());
    }
    public function editarLocal(Request $request, $id){
        $sala = BensSala::findOrFail($id);
        $sala->descricao = $request->descricao;
        return ($sala->update());
    }
    public function criar(Request $request)
    {
        $bem = new BensPatrimonio;
        $bem->descricao = $request->patrimonio['descricao'];
        $bem->codigo = $request->patrimonio['codigo'];
        $preco = str_replace(".","",$request->patrimonio['preco']);
        $preco = str_replace(",",".",$preco);
        $bem->preco = $preco;
        $bem->garantia =  $request->patrimonio['garantia'] != 0 ? $request->patrimonio['garantia']: null;
        $bem->idCategoria = $request->patrimonio['idCategoria'];
        $bem->idUser = auth()->user()->id;
        $bem->idLevantamento = $request->patrimonio['idLevantamento'];
        $bem->idConservacao = $request->patrimonio['idConservacao'];
        $bem->idSala = $request->patrimonio['idSala'];
        $bem->idSituacao = $request->patrimonio['idSituacao'];
        $idSituacao = $request->patrimonio['idSituacao'];
        $idUserResp  = ($idSituacao == 2 or $idSituacao == 4) ? 0 : $request->patrimonio['idUserResp'];
        $bem->save();
        if ($idUserResp != 0){
            $this->atualizaResp($idUserResp, $bem->id);
        }
        return true;
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Response
     */
    public function show($id)
    {
        return 'show';
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Response
     */
    public function editar(Request $request, $id)
    {
        $bem = BensPatrimonio::findOrFail($id);
        $bem->descricao = $request->patrimonio['descricao'];
        $bem->codigo = $request->patrimonio['codigo'];
        $preco = str_replace(".","",$request->patrimonio['preco']);
        $preco = str_replace(",",".",$preco);
        $bem->preco = $preco;
        $bem->garantia =  $request->patrimonio['garantia'] != 0 ? $request->patrimonio['garantia']: null;
        $bem->idCategoria = $request->patrimonio['idCategoria'];
        $bem->idSituacao = $request->patrimonio['idSituacao'];
        $bem->idLevantamento = $request->patrimonio['idLevantamento'];
        $bem->idConservacao = $request->patrimonio['idConservacao'];
        $bem->idSala = $request->patrimonio['idSala'];
        $idSituacao = $request->patrimonio['idSituacao'];
        $idUserResp  = ($idSituacao == 2 or $idSituacao == 4) ? 0 : $request->patrimonio['idUserResp'];
        $this->atualizaResp($idUserResp, $id);
        return response()->json($bem->update());

    }
    public function atualizaResp($idUserResp, $idPatrimonio)
    {
        $resp = BensResponsavel::whereRaw('idPatrimonio = '.$idPatrimonio.' and deleted_at is null')->first();
        if($resp) {
            if ($resp->idUserResp == $idUserResp){
                return true;
            }
            $resp->deleted_at =  date("Y-m-d H:i:s");
            $resp->update();
        }
        if ($idUserResp != 0){
            $resp = new BensResponsavel;
            $resp->idUserResp = $idUserResp;
            $resp->idPatrimonio = $idPatrimonio;
            $resp->idUser = auth()->user()->id;
            $resp->created_at =  date("Y-m-d H:i:s");
            $resp->save();
        }
        return true;
    }
    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Response
     */
    public function update(Request $request, $id)
    {
        return response()->json(['message' => 'update'], 500);
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
