<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use App\DistribuicaoDemanda;

class User extends Authenticatable
{
    use Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'cpf', 'email', 'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    public function permissoes()
    {
        return $this->hasManyThrough(
            'App\Permissao',
            'App\UsuarioPermissao',
            'idUsuario', // Foreign key on usuariopermissao table...
            'id', // Foreign key on permissao table...
            'id', // Local key on countries table...
            'idPermissao' // 
        );
    }

    public function divisoesOrganograma()
    {
        return $this->hasManyThrough(
            'App\DivisaoOrganograma',
            'App\UsuarioDivisaoOrganograma',
            'idUsuario', // Foreign key on usuariodivisaoorganograma table...
            'id', // Foreign key on divisaoorganograma table...
            'id', // Local key on users table...
            'idDivisaoOrganograma' // 
        );
    }

}
