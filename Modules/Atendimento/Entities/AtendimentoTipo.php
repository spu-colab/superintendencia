<?php

namespace Modules\Atendimento\Entities;

use Illuminate\Database\Eloquent\Model;

class AtendimentoTipo extends Model
{
    protected  $table="atendimentotipo";
    protected $visible = ['id', 'tipo'];
}
