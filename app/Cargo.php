<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Cargo extends Model
{
    public const TABLE_NAME = 'cargo';

    protected $table = Cargo::TABLE_NAME;

    protected $fillable = ["cargo"];
}
