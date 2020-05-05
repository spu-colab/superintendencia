<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class TipoCorrespondencia extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "tipo_correspondencia";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
    
}
