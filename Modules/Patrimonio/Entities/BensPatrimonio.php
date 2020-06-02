<?php

namespace Modules\Patrimonio\Entities;

use Illuminate\Database\Eloquent\Model;

class BensPatrimonio extends Model
{
    protected $table = "bens_patrimonio";    
    protected $fillable = [];
    protected $casts = [
        'codigo' => 'string'
    ];
    
//    protected $with = ['conservacao','levantamento'];
    public function sala()
    {
        return $this->belongsTo('Modules\Patrimonio\Entities\BensSala');
    }  
    public function levantamento()
    {
        return $this->belongsTo('Modules\Patrimonio\Entities\BensLevantamento','idLevantamento','id');
    }  
    public function conservacao()
    {
        return $this->belongsTo('Modules\Patrimonio\Entities\BensConservacao','idConservacao','id');
    }  
    public function categoria()
    {
        return $this->belongsTo('Modules\Patrimonio\Entities\BensCategoria','idCategoria','id');
    }  
    public function situacao()
    {
        return $this->belongsTo('Modules\Patrimonio\Entities\BensSituacao','idSituacao','id');
    }
    public function responsavel()
    {
        return $this->belongsToMany(
            'App\User', 
            'Modules\Patrimonio\Entities\BensResponsavel',
            'idUserResp',
            'idUser');   
    }
      
}
