<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Permissao extends Model
{

    public const TABLE_NAME = "permissao";
    protected $table = Permissao::TABLE_NAME;

    // seguir este padrão: MODULO_RECURSO_AÇÃO
    public const ATENDIMENTO_ATENDIMENTO_CRIAR_PRESENCIAL = "ATENDIMENTO_ATENDIMENTO_CRIAR_PRESENCIAL";
    public const ATENDIMENTO_ATENDIMENTO_CRIAR_TELEFONICO = "ATENDIMENTO_ATENDIMENTO_CRIAR_TELEFONICO";
    public const ATENDIMENTO_ATENDIMENTO_CRIAR_EMAIL = "ATENDIMENTO_ATENDIMENTO_CRIAR_EMAIL";
    public const ATENDIMENTO_COMENTARIO_CRIAR = "ATENDIMENTO_COMENTARIO_CRIAR";

    public const AUTH_USUARIO_CADASTRAR = "AUTH_USUARIO_CADASTRAR";
    public const AUTH_PERMISSAO_CADASTRAR = "AUTH_PERMISSAO_CADASTRAR";
    public const AUTH_ORGANOGRAMA_CADASTRAR = "AUTH_ORGANOGRAMA_CADASTRAR";
    
    public const CORRESPONDENCIA_CORRESPONDENCIA_POSTAR = 'CORRESPONDENCIA_CORRESPONDENCIA_POSTAR';

    public const DEMANDA_DEMANDA_CADASTRAR = "DEMANDA_DEMANDA_CADASTRAR";
    public const DEMANDA_DEMANDA_ALTERAR_RESUMO_GERENCIAL = "DEMANDA_DEMANDA_ALTERAR_RESUMO_GERENCIAL";
    public const DEMANDA_DEMANDA_ATENDER_DISTRIBUICAO = "DEMANDA_DEMANDA_ATENDER_DISTRIBUICAO";

    public const DEMARCACAO_DEMARCACAO_CADASTRAR = 'DEMARCACAO_DEMARCACAO_CADASTRAR';

    public const PATRIMONIO_PATRIMONIO_CADASTRAR  =  'PATRIMONIO_PATRIMONIO_CADASTRAR';

    /**
     * Não usar! Use Permissao::AUTH_USUARIO_CADASTRAR.
     */
    public const USUARIO_CADASTRAR = 'USUARIO_CADASTRAR';

    /**
     * Não usar! Use Permissao::AUTH_ORGANOGRAMA_CADASTRAR.
     */
    public const ORGANOGRAMA_CADASTRAR = 'ORGANOGRAMA_CADASTRAR';

    /**
     * Não usar! Use Permissao::AUTH_PERMISSAO_CADASTRAR.
     */
    public const PERMISSAO_CADASTRAR = 'PERMISSAO_CADASTRAR';

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