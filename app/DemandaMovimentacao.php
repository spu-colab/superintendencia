<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class DemandaMovimentacao extends Model
{
    protected $table = "demandamovimentacao";

    public function divisaoOrigem()
    {
        return $this->hasOne('App\DivisaoOrganograma', 'id', 'idDivisaoOrganogramaOrigem');
    }

    public function divisaoDestino()
    {
        return $this->hasOne('App\DivisaoOrganograma', 'id', 'idDivisaoOrganogramaDestino');
    }
}
