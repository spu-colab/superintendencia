<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class Estados extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "estados";
    protected $primaryKey = 'codigo';
    protected $fillable = [];
}
