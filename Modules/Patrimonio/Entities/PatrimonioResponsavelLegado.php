<?php

namespace Modules\Patrimonio\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Correspondencia\Entities\Tecnicos;
class PatrimonioResponsavelLegado extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "bens_tecnico";
    protected $primaryKey = 'codigo';
    public $timestamps = false;
    protected $with = ['tecnicoResp'];
    protected $fillable = [];
    public function tecnicoResp()
    {
        return $this->belongsTo('Modules\Correspondencia\Entities\Tecnicos','tecnico_rsp','codigo');
    }  
}
