<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class Endereco extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "endereco";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
    public $timestamps = false;
    protected $with = ['tipologradouro','municipio'];
    
    public function tipologradouro()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\TipoLogradouro','tiplog','codigo');
    }

    public function municipio()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\Municipios','cidade','codigo');
    }


}
