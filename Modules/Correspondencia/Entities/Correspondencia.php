<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class Correspondencia extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "controle_correspondencia";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
    protected $with = ['dscSetor', 'dscTipo', 'postagens' ];
    public $timestamps = false;
    
    public function dscSetor()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\Setor','setor','codigo');
    }
    public function dscTipo()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\TipoCorrespondencia','tipo','codigo');
    }
    public function postagens()
    {
        return $this->hasMany('Modules\Correspondencia\Entities\CorrespDest','codcor')->Ativo();        
    }
    public function scopeAtivo($query)
    {
        return $query->where('situacao', '=', 1);
    }
    
}
