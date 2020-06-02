<?php

namespace Modules\Patrimonio\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class BensResponsavel extends Model
{

    use SoftDeletes;
    protected $table = "bens_responsavel";
    protected $fillable = [];

}