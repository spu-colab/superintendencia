<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Permissao extends Model
{
    protected $table = "permissao";


    public const USUARIO_CADASTRAR = 'USUARIO_CADASTRAR';
    public const ORGANOGRAMA_CADASTRAR = 'ORGANOGRAMA_CADASTRAR';
    public const PERMISSAO_CADASTRAR = 'PERMISSAO_CADASTRAR';

    // seguir este padrão: MODULO RECURSO AÇÃO
    public const DEMARCACAO_DEMARCACAO_CADASTRAR = 'DEMARCACAO_DEMARCACAO_CADASTRAR';
    public const CORRESPONDENCIA_CORRESPONDENCIA_POSTAR = 'CORRESPONDENCIA_CORRESPONDENCIA_POSTAR';
    public const PATRIMONIO_PATRIMONIO_CADASTRAR  =  'PATRIMONIO_PATRIMONIO_CADASTRAR';

    public function usuarios(){    

        return $this->belongsToMany(
            'App\User',
            'App\UsuarioPermissao',
            'idPermissao', // Foreign key on usuariopermissao table...
//            'id', // Local key on user table...
//            'id', // Local key on permissao table...
            'idUsuario' // Foreign key on usuariopermissao table... 
        )->orderBy('name', 'asc'); 
    }  
}