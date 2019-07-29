<?php

namespace App\Repositories;

use App\User;
use App\Demanda;
use App\DivisaoOrganograma;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;

class DemandaRepository implements DemandaRepositoryI {

    public function listarDistribuidasParaUsuario(User $user) : array {
        return $this->listarDistribuidasPara($user);
    }

    public function listarDistribuidasParaDivisaoOrganograma(DivisaoOrganograma $divisaoOrganograma) : array {       
        return $this->listarDistribuidasPara($divisaoOrganograma);
    }

    public function listarIdsDemandasDistribuidasPara(Model $assignable) : array {
        $assignable_type = 'App\\User';
        if($assignable instanceof DivisaoOrganograma) {
            $assignable_type = 'App\\DivisaoOrganograma';
        }

        $ids = DB::table('demanda')
            ->join('distribuicaodemanda', 'demanda.id', '=', 'distribuicaodemanda.idDemanda')
            ->where([
                ['assignable_type', '=', $assignable_type],
                ['assignable_id', '=', $assignable->id],
                ['dataAtendimento', '=', null]
            ])
            ->select('demanda.id')
            ->get();
        $arr_ids = array();
        foreach ($ids as $id) {
            $arr_ids[] = $id->id;
        }
        return $arr_ids;
    }

    private function listarDistribuidasPara (Model $assignable) : array {
        $arr_ids = $this->listarIdsDemandasDistribuidasPara($assignable);
        $demandas = Demanda::whereIn('id', $arr_ids)
        ->with([
            'autor.cargo', 
            'autor.orgao',
            'procedimentoExterno.tipoProcedimentoExterno',
            'situacao',
            'distribuicoes.colaboradorDe',
            'distribuicoes.assignable'
            ])
        ->orderBy('dataPrazo')
        ->get();
        $return['demandas'] = $demandas;
        return $return;
    }
    
}

?>