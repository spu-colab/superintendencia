<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class UsuarioPermissao extends Model
{
    public const TABLE_NAME = "usuariopermissao";
    
    protected $table = UsuarioPermissao::TABLE_NAME;
}
