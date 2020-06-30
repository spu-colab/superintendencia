<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class TipoProcedimentoExterno extends Model
{
    public const TABLE_NAME = "tipoprocedimentoexterno";

    protected $table = TipoProcedimentoExterno::TABLE_NAME;

    protected $fillable = ["tipoprocedimento"];
}
