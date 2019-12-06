<?php

namespace Modules\Atendimento\Entities;


use Illuminate\Database\Eloquent\Model;

class Atendimento extends Model
{
    protected $table = 'atendimento';
    protected $hidden = ['idUsuario','idTipo','created_at','updated_at'];
    //

    public function assuntos()
    {
       return $this->belongsToMany('Modules\Atendimento\Entities\AtendimentoAssunto',
                    'atendimento_atendimentoassunto','idAtendimento','idAtendimentoAssunto');
    }
    public function comentarios()
    {
       return $this->hasMany('Modules\Atendimento\Entities\AtendimentoComentario','idAtendimento');
    }

    public function tipo()
    {
        return $this->belongsTo('Modules\Atendimento\Entities\AtendimentoTipo','idTipo');
        
    }
    public function usuario()
    {
        return $this->belongsTo('App\User','idUsuario');
        
    }

}
