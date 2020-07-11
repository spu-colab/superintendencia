<?php

namespace Modules\Geo\Policies;

use App\Permissao;
use App\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class GeoCamadaPolicy
{
    use HandlesAuthorization;

    /**
     * Create a new policy instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    public function create(User $user) {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()
            ->where('permissao', Permissao::GEO_CAMADA_CADASTRAR)->first();
    }

    public function update(User $user) {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()
            ->where('permissao', Permissao::GEO_CAMADA_CADASTRAR)->first();
    }
}
