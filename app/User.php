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
        'name', 'email', 'password',
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
            'idPermissao' // Local key on users table...
        );
    }

}
