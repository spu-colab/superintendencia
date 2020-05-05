<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class Municipios extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "municipios";
    protected $primaryKey = 'codigo';
    protected $fillable = [];

    protected $with = ['estado'];
    
    public function estado()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\Estados','UF','codigo');
    }

}
