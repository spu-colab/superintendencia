<?php

namespace Modules\Atendimento\Entities;

use Illuminate\Database\Eloquent\Model;

class AtendimentoComentario extends Model
{
    protected  $table="atendimentocomentario";
    protected $visible = ['id','idUsuario','comentario','dataHora'];
    public $timestamps = false;
}
