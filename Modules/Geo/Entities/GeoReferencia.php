<?php

namespace Modules\Geo\Entities;

use Illuminate\Database\Eloquent\Model;
use Grimzy\LaravelMysqlSpatial\Eloquent\SpatialTrait;

class GeoReferencia extends Model
{
    use SpatialTrait;

    public const TABLE_NAME = "geo_referencia";
    
    protected $table = GeoReferencia::TABLE_NAME;

    protected $spatialFields = [
        'poligonais'
    ];
}
