<?php

namespace Modules\Atendimento\Policies;

use App\User;
use Modules\Atendimento\Entities\Atendimento;
use Illuminate\Auth\Access\HandlesAuthorization;

class AtendimentoPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view the atendimento.
     *
     * @param  \App\User  $user
     * @param  \Model\Atendimento\Entities\Atendimento  $atendimento
     * @return mixed
     */
    public function view(User $user, Atendimento $atendimento)
    {
        return true;
    }

    /**
     * Determine whether the user can create atendimentos.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function criarPresencial(User $user)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()
            ->where('permissao', 'ATENDIMENTO_ATENDIMENTO_CRIAR_PRESENCIAL')->first();
    }

    /**
     * Determine whether the user can create atendimentos.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function criarTelefonico(User $user)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()
            ->where('permissao', 'ATENDIMENTO_ATENDIMENTO_CRIAR_TELEFONICO')->first();
    }

    /**
     * Determine whether the user can create atendimentos.
     *
     * @param  \App\User  $user
     * @return mixed
     */
    public function criarEmail(User $user)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()
            ->where('permissao', 'ATENDIMENTO_ATENDIMENTO_CRIAR_EMAIL')->first();
    }

    /**
     * Determine whether the user can update the atendimento.
     *
     * @param  \App\User  $user
     * @param  \Model\Atendimento\Entities\Atendimento  $atendimento
     * @return mixed
     */
    public function update(User $user, Atendimento $atendimento)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->id == $atendimento->idusuario;
    }

    /**
     * Determine whether the user can delete the atendimento.
     *
     * @param  \App\User  $user
     * @param  \Modules\Atendimento\Entities\Atendimento $atendimento
     * @return mixed
     */
    public function delete(User $user, Atendimento $atendimento)
    {
        return false;
    }

    /**
     * Determine whether the user can restore the atendimento.
     *
     * @param  \App\User  $user
     * @param  \Modules\Atendimento\Entities\Atendimento $atendimento
     * @return mixed
     */
    public function restore(User $user, Atendimento $atendimento)
    {
        return false;
    }

    /**
     * Determine whether the user can permanently delete the atendimento.
     *
     * @param  \App\User  $user
     * @param  \Modules\Atendimento\Entities\Atendimento $atendimento
     * @return mixed
     */
    public function forceDelete(User $user, Atendimento $atendimento)
    {
        return false;
    }
}
