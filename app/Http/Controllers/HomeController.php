<?php

namespace App\Http\Controllers;

use App\AutorDemanda;
use App\Orgao;
use App\Cargo;

use \DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HomeController extends Controller
{

    private $cache;
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->cache['funcoes'] = [];
        $this->cache['cargos'] = [];
        $this->cache['origens'] = [];
        $this->cache['orgaos'] = [];
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        $demandas = DB::connection('mysql_nildo')->select('SELECT * FROM vw_demanda');
        $atrasados = 0;
        $para_hoje = 0;
        $para_semana = 0;
        $apartir_semana = 0;
        $datahoje = new DateTime(date('d-m-Y', strtotime('now')));
        $datasemana = new DateTime(date('d-m-Y', strtotime('next sunday'))); 
        foreach ($demandas as $d => $demanda) {
            $datatimeprazo = new DateTime($demanda->dataprazo);
            $diffDias = date_diff($datahoje, $datatimeprazo);
            $diffDias = $diffDias->format('%R%a');
            $demanda->diasPrazo = $diffDias;
            $dataprazo = $datatimeprazo->format('d/m/Y');
            if($diffDias < 0) {
                $atrasados++;    
            } else {
                if($diffDias == 0) {
                    $para_hoje++;
                } else {
                    $diffDias = date_diff($datatimeprazo, $datasemana);
                    $diffDias = $diffDias->format('%R%a');
                    if($diffDias <= 0) {
                        $para_semana++;
                    } else {
                        $apartir_semana++;
                    }
                }
            }
        }
        $retorno = [
            'estatisticas' => [
                'atrasados' => $atrasados,
                'para_hoje' => $para_hoje,
                'para_semana' => $para_semana,
                'apartir_semana' => $apartir_semana
                ],
            'demandas' => $demandas,
        ];
        return response()->json($retorno);
        // return view('demandas', $retorno);
    }

    public function importarDadosSisnildo()
    {
        $demandantes = DB::connection('mysql_nildo')->select('SELECT * FROM cda_demanda_demandante');
        $demandantes_arr = [];
        foreach($demandantes as $d => $demandante) {
            $autor = new AutorDemanda;
            $autor->nome = $demandante->nome;
            $autor->telefone = '(' . $demandante->dddcoml . ')' . $demandante->fonecoml;
            $autor->idCargo = $this->obterOuCriarCargo($demandante->funcao)->id;
            $autor->idOrgao = $this->obterOuCriarOrgao($demandante->origem)->id;
            $autor->email = '[email_nao_fornecido]';
            $autor->save();
            $demandantes_arr[] = $autor;
        }
        return response()->json($demandantes_arr);
    }

    private function obterOuCriarOrgao($idOrigem) {

        if(!is_int($idOrigem)) {
            return null;
        }

        // obtem a funcao do cache (inclui no cache se necessário)
        if (!key_exists($idOrigem, $this->cache['origens'])) {
            $origens = DB::connection('mysql_nildo')
                ->select('SELECT * FROM cda_demanda_origem WHERE codigo = ' . $idOrigem);
            if (!is_array($origens)) {
                throw new Exception('Origem nao encontrada no sisnildo: ' + $idOrigem);
            }
            $this->cache['origens'][$idOrigem] = $origens[0];
        }
        $origem = $this->cache['origens'][$idOrigem];

        // busca o cargo correspondente
        $sigla = substr($origem->descricao, 0, 50);
        if (!key_exists($sigla, $this->cache['origens'])) {
            $orgao = Orgao::where('sigla', $sigla)->first();
            $this->cache['origens'][$sigla] = $orgao;
        }
        return $this->cache['origens'][$sigla];
    }

    private function obterOuCriarCargo($idFuncao) {

        if(!is_int($idFuncao)) {
            return null;
        }

        // obtem a funcao do cache (inclui no cache se necessário)
        if (!key_exists($idFuncao, $this->cache['funcoes'])) {
            $funcoes = DB::connection('mysql_nildo')->select('SELECT * FROM funcoes WHERE codigo = ' . $idFuncao);
            if (!is_array($funcoes)) {
                throw new Exception('Funcao nao encontrada no sisnildo: ' + $idFuncao);
            }
            $this->cache['funcoes'][$idFuncao] = $funcoes[0];
        }
        $funcao = $this->cache['funcoes'][$idFuncao];

        // busca o cargo correspondente
        $siglaCargo = substr($funcao->descricao, 0, 150);
        if (!key_exists($siglaCargo, $this->cache['cargos'])) {
            $cargo = Cargo::where('cargo', $siglaCargo)->first();
            $this->cache['cargos'][$siglaCargo] = $cargo;
        }
        return $this->cache['cargos'][$siglaCargo];
    }

    public function importarOrgaos() 
    {
        $origens = DB::connection('mysql_nildo')->select('SELECT * FROM cda_demanda_origem');

        foreach ($origens as $o => $origem) {
            $orgao = new Orgao();
            $orgao->sigla = substr($origem->descricao, 0, 50);
            $orgao->orgao = $origem->extenso;
            $orgao->save();
        }

        return response()->json(Orgao::all());

    }

    public function importarCargos() 
    {
        $funcoes = DB::connection('mysql_nildo')->select('SELECT * FROM funcoes');

        foreach ($funcoes as $f => $funcao) {
            $cargo = new Cargo();
            $cargo->cargo = substr($funcao->descricao, 0, 150);
            $cargo->save();
        }

        return response()->json(Cargo::all());

    }
}
