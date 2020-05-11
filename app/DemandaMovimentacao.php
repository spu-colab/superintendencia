<?php

namespace App;
use Modules\Auth\Entities\DivisaoOrganograma;
use Illuminate\Database\Eloquent\Model;


class DemandaMovimentacao extends Model
{
    protected $table = "demandamovimentacao";

    public function divisaoOrigem()
    {
        return $this->hasOne('Modules\Auth\Entities\DivisaoOrganograma', 'id', 'idDivisaoOrganogramaOrigem');
    }

    public function divisaoDestino()
    {
        return $this->hasOne('Modules\Auth\Entities\DivisaoOrganograma', 'id', 'idDivisaoOrganogramaDestino');
    }
}
