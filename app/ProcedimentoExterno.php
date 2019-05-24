<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProcedimentoExterno extends Model
{
    protected $table = "procedimentoexterno";

    public function tipoProcedimentoExterno()
    {
        return $this->hasOne('App\TipoProcedimentoExterno', 'id', 'idTipoProcedimentoExterno');
    }
}
