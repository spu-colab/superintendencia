<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Auth\Entities\DivisaoOrganograma;
class SetorDivisaoOrganograma extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "setordivisaoorganograma";
    protected $fillable = [];
}