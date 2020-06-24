<?php

namespace Modules\Atendimento\Entities;

use Illuminate\Database\Eloquent\Model;

class Assunto extends Model
{
    public const TABLE_NAME = "atend_assunto";
    protected $table = Assunto::TABLE_NAME;
    protected $visible = ['id', 'assunto'];
}
