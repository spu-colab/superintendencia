<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Modules\Auth\Entities\DivisaoOrganogramaPai;

class DivisaoOrganograma extends Model
{
    protected $table = 'divisaoorganograma';
    
    public function divisaoOrganogramaPai()
    {
        return $this->belongsTo(DivisaoOrganograma::class, 'idDivisaoOrganogramaPai');
    }

    public function usuarios()
    {  
        return $this->belongsToMany(
            'App\User', 
            'App\UsuarioDivisaoOrganograma',
            'idDivisaoOrganograma',
            'idUsuario');   
    } 
}
