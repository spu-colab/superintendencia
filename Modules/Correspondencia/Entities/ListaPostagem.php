<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class ListaPostagem extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "corresp_lista";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
    public $timestamps = false;
    protected $with = ['tec_resp','destPost'];

    public function destPost()
    {        
        return $this->hasMany('Modules\Correspondencia\Entities\CorrespDest','lista')
            ->without('sitPostagem','motivoDevolucao')->with('documento');
    }

    public function tec_resp()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\Tecnicos','tecnico','codigo');
    }

    public function scopeAberta($query)
    {
        return $query->where('situacao', '=', 3);
    }
}