<?php

namespace App\Policies;

use App\User;
use App\Orgao;
use App\Permissao;
use Illuminate\Auth\Access\HandlesAuthorization;

class OrgaoPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view the orgao.
     *
     * @param  \App\User  $user
     * @param  \App\Orgao  $orgao
     * @return mixed
     */
    public function view(User $user, Orgao $orgao)
    {
        //
    }

    /**
     * Determine whether the user can create orgaos.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function create(User $user)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()
            ->where('permissao', Permissao::DEMANDA_ORGAO_CADASTRAR)->first();
    }

    /**
     * Determine whether the user can update the orgao.
     *
     * @param  \App\User  $user
     * @param  \App\Orgao  $orgao
     * @return mixed
     */
    public function update(User $user, Orgao $orgao)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()
            ->where('permissao', Permissao::DEMANDA_ORGAO_CADASTRAR)->first();
    }

    /**
     * Determine whether the user can delete the orgao.
     *
     * @param  \App\User  $user
     * @param  \App\Orgao  $orgao
     * @return mixed
     */
    public function delete(User $user, Orgao $orgao)
    {
        return false;
    }

    /**
     * Determine whether the user can restore the orgao.
     *
     * @param  \App\User  $user
     * @param  \App\Orgao  $orgao
     * @return mixed
     */
    public function restore(User $user, Orgao $orgao)
    {
        return false;
    }

    /**
     * Determine whether the user can permanently delete the orgao.
     *
     * @param  \App\User  $user
     * @param  \App\Orgao  $orgao
     * @return mixed
     */
    public function forceDelete(User $user, Orgao $orgao)
    {
        return false;
    }
}
