<?php

namespace Modules\Atendimento\Entities;

use Illuminate\Database\Eloquent\Model;

class Assunto extends Model
{
    protected $table = "atend_assunto";
    protected $visible = ['id', 'assunto'];
}
