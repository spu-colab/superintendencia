<?php

namespace Modules\Atendimento\Entities;

use Illuminate\Database\Eloquent\Model;

class Comentario extends Model
{
    protected  $table="atend_comentario";
    protected $visible = ['id','idUsuario','comentario','dataHora'];
    public $timestamps = false;
}
