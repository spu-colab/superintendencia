<?php

namespace Modules\Demarcacao\Entities;

use Illuminate\Database\Eloquent\Model;

class Demarcacao extends Model
{
    protected $table = "demar_demarcacao";
    protected $primaryKey = "id_demarcacao";
    protected $fillable = [
        'id_tipodemarcacao', 
        'id_situacaodemarcacao', 
        'id_trechodemarcacao', 
        'processo',
        'subtrecho',
        'lpm_ltm',
        'fonte',
        'edital',
        'datahomologacao'
    ];

    public function tipo() {
        return $this->belongsTo('Modules\Demarcacao\Entities\TipoDemarcacao',
            'id_tipodemarcacao', 'id_tipodemarcacao');
        
    }

    public function situacao() {
        return $this->belongsTo('Modules\Demarcacao\Entities\SituacaoDemarcacao',
            'id_situacaodemarcacao', 'id_situacaodemarcacao');
    }

    public function trecho() {
        return $this->belongsTo('Modules\Demarcacao\Entities\TrechoDemarcacao',
            'id_trechodemarcacao', 'id_trechodemarcacao');
    }
}
