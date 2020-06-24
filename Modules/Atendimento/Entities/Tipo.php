<?php

namespace Modules\Atendimento\Entities;

use Illuminate\Database\Eloquent\Model;

class Tipo extends Model
{

    public const TABLE_NAME = "atend_tipo";

    const PRESENCIAL = 1;
    const TELEFONICO = 2;
    const EMAIL = 3;

    protected  $table = Tipo::TABLE_NAME;
    protected $visible = ['id', 'tipo'];
}
