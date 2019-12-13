<?php

namespace Modules\Atendimento\Entities;

use Illuminate\Database\Eloquent\Model;

class Tipo extends Model
{

    const PRESENCIAL = 1;
    const TELEFONICO = 2;
    const EMAIL = 3;

    protected  $table="atend_tipo";
    protected $visible = ['id', 'tipo'];
}
