<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Permissao extends Model
{
    protected $table = "permissao";

    public function usuarios(){    

        return $this->hasManyThrough(
            'App\User',
            'App\UsuarioPermissao',
            'idPermissao', // Foreign key on usuariopermissao table...
            'id', // Local key on user table...
            'id', // Local key on permissao table...
            'idUsuario' // Foreign key on usuariopermissao table... 
        ); 
    }  
}