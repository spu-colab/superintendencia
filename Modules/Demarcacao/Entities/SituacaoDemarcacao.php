<?php

namespace Modules\Demarcacao\Entities;

use Illuminate\Database\Eloquent\Model;

class SituacaoDemarcacao extends Model
{
    protected $table = "demar_situacaodemarcacao";
    protected $primaryKey = "id_situacaodemarcacao";
    protected $fillable = [];
}
