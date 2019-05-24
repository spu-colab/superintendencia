<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class DistribuicaoDemanda extends Model
{
    protected $table = "distribuicaodemanda";

    public $timestamps = false;

     /**
     * Retorna o usuário que atribuiu a demanda
     * 
     * @return User
     */
    public function colaboradorDe()
    {
        return $this->hasOne('App\User', 'id', 'idUsuarioDe');
    }

    /**
     * Get all of the owning imageable models.
     */
    public function assignable()
    {
        return $this->morphTo();
    }

}
