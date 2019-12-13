<?php

namespace Modules\Atendimento\Entities;

use Illuminate\Database\Eloquent\Model;

class Comentario extends Model
{
    protected  $table="atend_comentario";
    public $timestamps = false;

    public function usuario()
    {
        return $this->belongsTo('App\User','idusuario');
    }
}
