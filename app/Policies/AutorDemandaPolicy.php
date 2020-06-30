<?php

namespace App\Policies;

use App\User;
use App\AutorDemanda;
use App\Permissao;
use Illuminate\Auth\Access\HandlesAuthorization;

class AutorDemandaPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view the autor demanda.
     *
     * @param  \App\User  $user
     * @param  \App\AutorDemanda  $autorDemanda
     * @return mixed
     */
    public function view(User $user, AutorDemanda $autorDemanda)
    {
        //
    }

    /**
     * Determine whether the user can create autor demandas.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function create(User $user)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()
            ->where('permissao', Permissao::DEMANDA_AUTOR_CADASTRAR)->first();
    }

    /**
     * Determine whether the user can update the autor demanda.
     *
     * @param  \App\User  $user
     * @param  \App\AutorDemanda  $autorDemanda
     * @return mixed
     */
    public function update(User $user, AutorDemanda $autorDemanda)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()
            ->where('permissao', Permissao::DEMANDA_AUTOR_CADASTRAR)->first();
    }

    /**
     * Determine whether the user can delete the autor demanda.
     *
     * @param  \App\User  $user
     * @param  \App\AutorDemanda  $autorDemanda
     * @return mixed
     */
    public function delete(User $user, AutorDemanda $autorDemanda)
    {
        //
    }

    /**
     * Determine whether the user can restore the autor demanda.
     *
     * @param  \App\User  $user
     * @param  \App\AutorDemanda  $autorDemanda
     * @return mixed
     */
    public function restore(User $user, AutorDemanda $autorDemanda)
    {
        //
    }

    /**
     * Determine whether the user can permanently delete the autor demanda.
     *
     * @param  \App\User  $user
     * @param  \App\AutorDemanda  $autorDemanda
     * @return mixed
     */
    public function forceDelete(User $user, AutorDemanda $autorDemanda)
    {
        //
    }
}
