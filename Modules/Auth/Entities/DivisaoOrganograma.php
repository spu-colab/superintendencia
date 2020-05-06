<?php

namespace Modules\Auth\Entities;

use Illuminate\Database\Eloquent\Model;

class DivisaoOrganograma extends Model
{
    public const DEMANDA_REPRIMIDA = 10;
    
    protected $table = 'divisaoorganograma';
//    protected $touches = ['UsuarioDivisaoOrganograma'];
    public function divisaoOrganogramaPai()
    {
        return $this->belongsTo(DivisaoOrganograma::class, 'idDivisaoOrganogramaPai');
    }

    public function usuarios()
    {  
        return $this->belongsToMany(
            'App\User', 
            'Modules\Auth\Entities\UsuarioDivisaoOrganograma',
            'idDivisaoOrganograma',
            'idUsuario');   
    } 
}
