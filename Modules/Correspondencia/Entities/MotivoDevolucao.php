<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class MotivoDevolucao extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "motivo_devolucao";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
}
