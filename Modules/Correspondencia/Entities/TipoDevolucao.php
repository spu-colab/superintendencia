<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class TipoDevolucao extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "tipo_devolucao";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
}
