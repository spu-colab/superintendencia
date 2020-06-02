<?php

namespace Modules\Patrimonio\Entities;

use Illuminate\Database\Eloquent\Model;

class BensSala extends Model
{
    protected $table = "bens_sala";

    protected $fillable = [];
    protected $with = ['divisao'];
    public function divisao()
    {
        return $this->belongsTo('Modules\Auth\Entities\DivisaoOrganograma','idDivisaoOrganograma','id');
    }

}
