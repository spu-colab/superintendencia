<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Demanda extends Model
{
    protected $table = 'demanda';

    public function autor()
    {
        return $this->hasOne('App\AutorDemanda', 'id', 'idAutorDemanda');
    }

    public function tipoDocumento()
    {
        return $this->hasOne('App\TipoDocumento', 'id', 'idTipoDocumento');
    }

    public function situacao()
    {
        return $this->hasOne('App\SituacaoDemanda', 'id', 'idSituacaoDemanda');
    }

    public function movimentacoes()
    {
        return $this->hasMany('App\DemandaMovimentacao', 'idDemanda', 'id');
    }

    public function distribuicoes()
    {
        return $this->hasMany('App\DistribuicaoDemanda', 'idDemanda', 'id');
    }

    public function procedimentoExterno()
    {
        return $this->hasOne('App\ProcedimentoExterno', 'id', 'idProcedimentoExterno');
    }
}
