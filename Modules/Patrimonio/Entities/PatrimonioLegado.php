<?php

namespace Modules\Patrimonio\Entities;

use Illuminate\Database\Eloquent\Model;

class PatrimonioLegado extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "bens";
    protected $primaryKey = 'codigo';
    public $timestamps = false;
    protected $fillable = [];
}
