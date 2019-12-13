<?php

namespace Modules\Atendimento\Policies;

use App\User;
use Modules\Atendimento\Entities\Comentario;
use Illuminate\Auth\Access\HandlesAuthorization;

class ComentarioPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view the demanda.
     *
     * @param  \App\User  $user
     * @param  \Model\Atendimento\Entities\Comentario  $comentario
     * @return mixed
     */
    public function view(User $user, Comentario $comentario)
    {
        return true;
    }

    /**
     * Determine whether the user can create demandas.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function create(User $user)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()
            ->where('permissao', 'ATENDIMENTO_COMENTARIO_CRIAR')->first();
    }

    /**
     * Determine whether the user can update the demanda.
     *
     * @param  \App\User  $user
     * @param  \Model\Atendimento\Entities\Comentario  $comentario
     * @return mixed
     */
    public function update(User $user, Comentario $comentario)
    {
        return false;
    }

    /**
     * Determine whether the user can delete the demanda.
     *
     * @param  \App\User  $user
     * @param  \App\Demanda  $demanda
     * @return mixed
     */
    public function delete(User $user, Demanda $demanda)
    {
        return false;
    }

    /**
     * Determine whether the user can restore the demanda.
     *
     * @param  \App\User  $user
     * @param  \App\Demanda  $demanda
     * @return mixed
     */
    public function restore(User $user, Demanda $demanda)
    {
        return false;
    }

    /**
     * Determine whether the user can permanently delete the demanda.
     *
     * @param  \App\User  $user
     * @param  \App\Demanda  $demanda
     * @return mixed
     */
    public function forceDelete(User $user, Demanda $demanda)
    {
        return false;
    }
}
