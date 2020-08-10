<?php

namespace Modules\Geo\Entities;

use Illuminate\Database\Eloquent\Model;

class GeoCamada extends Model
{
    public const TABLE_NAME = "geo_camada";

    protected $table = GeoCamada::TABLE_NAME;
    
    /*
    protected $casts = [
        'geojson' => 'array'
    ];
    */

    public function arquivoGeo()
    {
        return $this->hasOne('App\Arquivo', 'id', 'idArquivoGeo');
    }
    
}
