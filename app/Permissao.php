<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Permissao extends Model
{
    protected $table = "permissao";

    public const USUARIO_CADASTRAR = 'USUARIO_CADASTRAR';
    public const DIVISAO_ORGANOGRAMA_CADASTRAR = 'DIVISAO_ORGANOGRAMA_CADASTRAR';
    public const PERMISSAO_CADASTRAR = 'PERMISSAO_CADASTRAR';

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