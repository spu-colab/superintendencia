<?php

namespace Modules\Auth\Entities;

use Illuminate\Database\Eloquent\Model;

class DivisaoOrganograma extends Model
{
    public const TABLE_NAME = 'divisaoorganograma';
    public const DEMANDA_REPRIMIDA = 10;
    
    protected $table = DivisaoOrganograma::TABLE_NAME;

    protected $fillable = ['nome', 'sigla', 'snSuperintendencia'];

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

    public function scopeAtivos($query)
    {
        return $query->where('divisaoorganograma.deleted_at', '=', null);
    }
}