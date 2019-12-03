<?php

namespace Modules\Atendimento\Entities;

use Illuminate\Database\Eloquent\Model;

class AtendimentoAssunto extends Model
{
    protected  $table="atendimentoassunto";
    protected $visible = ['id', 'assunto'];
}
