<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Arquivo extends Model
{

    protected $table = 'arquivo';
    
    protected $fillable = ['filename', 'mime', 'path', 'size'];
}
