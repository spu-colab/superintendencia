<?php

namespace Modules\Atendimento\Entities;

use Modules\Atendimento\Entities\Tipo;

use Illuminate\Database\Eloquent\Model;

class Atendimento extends Model
{
    protected $table = 'atend_atendimento';
    // protected $hidden = ['idUsuario','idTipo','created_at','updated_at'];
    //

    public function assuntos()
    {
       return $this->belongsToMany('Modules\Atendimento\Entities\Assunto',
                    'atend_atendimento_atend_assunto','idatendimento','idassunto');
    }
    public function comentarios()
    {
       return $this->hasMany('Modules\Atendimento\Entities\Comentario','idatendimento');
    }

    public function tipo()
    {
        return $this->belongsTo('Modules\Atendimento\Entities\Tipo','idtipo');
        
    }
    public function usuario()
    {
        return $this->belongsTo('App\User','idusuario');
    }

    public function isPresencial() {
        return $this->idtipo == Tipo::PRESENCIAL;
    }

    public function isTelefonico() {
        return $this->idtipo == Tipo::TELEFONICO;
    }

    public function isEmail() {
        return $this->idtipo == Tipo::EMAIL;
    }

}
