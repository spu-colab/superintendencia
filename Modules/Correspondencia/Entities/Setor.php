<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class Setor extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "setor";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
    protected $hidden = ['chefia','cargo','telefone'];
}
