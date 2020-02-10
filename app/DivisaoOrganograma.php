<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Modules\Auth\Entities\DivisaoOrganogramaPai;

class DivisaoOrganograma extends Model
{
    public const DEMANDA_REPRIMIDA = 10;
    
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
