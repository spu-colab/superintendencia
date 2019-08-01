<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Grimzy\LaravelMysqlSpatial\Eloquent\SpatialTrait;

class GeoReferencia extends Model
{
    use SpatialTrait;
    
    protected $table = "geo_referencia";

    protected $spatialFields = [
        'poligonais'
    ];
}
