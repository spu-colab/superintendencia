<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Correspondencia\Entities\SetorDivisaoOrganograma;

class Setor extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "setor";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
    public $timestamps = false;
    protected $hidden = ['chefia','cargo','telefone'];
    protected $with = ['setorDivisaoOrg'];

    public function setorDivisaoOrg()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\SetorDivisaoOrganograma','codigo','idSetor');
    }    
}
