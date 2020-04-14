<?php

namespace Modules\Demarcacao\Entities;

use Illuminate\Database\Eloquent\Model;

class TipoDemarcacao extends Model
{
    protected $table = "demar_tipodemarcacao";
    protected $primaryKey = "id_tipodemarcacao";
    protected $fillable = [];
}
