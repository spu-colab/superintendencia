<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class NaturezaOrgao extends Model
{
    public const TABLE_NAME = "naturezaorgao";

    protected $table = NaturezaOrgao::TABLE_NAME;

    protected $fillable = ["natureza"];
}
