<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\DistribuicaoDemanda;

class DivisaoOrganograma extends Model
{
    public const DEMANDA_REPRIMIDA = 10;
    
    protected $table = 'divisaoorganograma';
    
}
