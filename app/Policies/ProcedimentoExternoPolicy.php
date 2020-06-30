<?php

namespace App\Policies;

use App\Permissao;
use App\User;
use App\ProcedimentoExterno;
use Illuminate\Auth\Access\HandlesAuthorization;

class ProcedimentoExternoPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view the procedimento externo.
     *
     * @param  \App\User  $user
     * @param  \App\ProcedimentoExterno  $procedimentoExterno
     * @return mixed
     */
    public function view(User $user, ProcedimentoExterno $procedimentoExterno)
    {
        //
    }

    /**
     * Determine whether the user can create procedimento externos.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function create(User $user)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()
            ->where('permissao', Permissao::DEMANDA_PROCEDIMENTO_CADASTRAR)->first();
    }

    /**
     * Determine whether the user can update the procedimento externo.
     *
     * @param  \App\User  $user
     * @param  \App\ProcedimentoExterno  $procedimentoExterno
     * @return mixed
     */
    public function update(User $user, ProcedimentoExterno $procedimentoExterno)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()
            ->where('permissao', Permissao::DEMANDA_PROCEDIMENTO_CADASTRAR)->first();
    }

    /**
     * Determine whether the user can delete the procedimento externo.
     *
     * @param  \App\User  $user
     * @param  \App\ProcedimentoExterno  $procedimentoExterno
     * @return mixed
     */
    public function delete(User $user, ProcedimentoExterno $procedimentoExterno)
    {
        return false;
    }

    /**
     * Determine whether the user can restore the procedimento externo.
     *
     * @param  \App\User  $user
     * @param  \App\ProcedimentoExterno  $procedimentoExterno
     * @return mixed
     */
    public function restore(User $user, ProcedimentoExterno $procedimentoExterno)
    {
        return false;
    }

    /**
     * Determine whether the user can permanently delete the procedimento externo.
     *
     * @param  \App\User  $user
     * @param  \App\ProcedimentoExterno  $procedimentoExterno
     * @return mixed
     */
    public function forceDelete(User $user, ProcedimentoExterno $procedimentoExterno)
    {
        return false;
    }
}
