<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class TipoLogradouro extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "tipo_logradouro";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
}
