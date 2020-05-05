<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class CorrespDest extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "corresp_dest";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
    public $timestamps = false;
    protected $with = ['destinatario', 'sitPostagem', 'motivoDevolucao' ];

    public function destinatario()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\Destinatario','coddest','codigo');
    }

    public function destSemEndereco()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\Destinatario','coddest','codigo')->without('enderecoDest');
    }    
    public function sitPostagem()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\TipoDevolucao','tipo_dev','codigo');
    }

    public function documento()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\Correspondencia','codcor','codigo');
    }
    
    public function motivoDevolucao()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\MotivoDevolucao','mot_dev','codigo');
    }    

    public function scopePreparado($query)
    {
        return $query->where('situacao', '=', 1)->where('tipo_dev', '=', 2);
    }

    public function scopeAtivo($query){
        return $query->where('situacao', '=', 1);
    }
}
