<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Orgao extends Model
{
    protected $table = 'orgao';

    /**
     * Retorna o orgao pai do orgao
     * 
     * @return Orgao
     */
    public function orgaoPai()
    {
        return $this->hasOne('App\Orgao', 'id', 'idOrgaoPai');
    }

    /**
     * Retorna a natureza do orgao
     * 
     * @return NaturezaOrgao
     */
    public function natureza()
    {
        return $this->hasOne('App\NaturezaOrgao', 'id', 'idNaturezaOrgao');
    }
}
