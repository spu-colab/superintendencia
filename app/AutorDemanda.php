<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class AutorDemanda extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'autordemanda';

    /**
     * Retorna o órgão ao qual o autor da demanda pertence
     * 
     * @return Orgao
     */
     public function orgao()
     {
         return $this->hasOne('App\Orgao', 'id', 'idOrgao');
     }

     /**
     * Retorna o cargo ao qual o autor da demanda pertence
     * 
     * @return Cargo
     */
    public function cargo()
    {
        return $this->hasOne('App\Cargo', 'id', 'idCargo');
    }
}
