<?php

namespace Modules\Demarcacao\Entities;

use Illuminate\Database\Eloquent\Model;

class TrechoDemarcacao extends Model
{
    protected $table = "demar_trechodemarcacao";
    protected $primaryKey = "id_trechodemarcacao";
    protected $fillable = [];
}
