<?php

namespace Modules\Atendimento\Entities;

use Illuminate\Database\Eloquent\Model;

class Tipo extends Model
{
    protected  $table="atend_tipo";
    protected $visible = ['id', 'tipo'];
}
