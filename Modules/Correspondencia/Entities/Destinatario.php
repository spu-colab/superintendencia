<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class Destinatario extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "destinatario";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
    protected $with = ['enderecoDest'];
    public $timestamps = false;
    
    public function enderecoDest()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\Endereco','endereco','codigo');
    }
}
