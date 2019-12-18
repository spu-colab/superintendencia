<?php

namespace Modules\Auth\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Auth\Entities\DivisaoOrganogramaPai;

class DivisaoOrganograma extends Model
{
    protected $table = 'divisaoorganograma';
    
    public function divisaoOrganogramaPai()
    {
        return $this->belongsTo(DivisaoOrganograma::class, 'idDivisaoOrganogramaPai');
    }
}
