<?php

namespace Modules\Demarcacao\Policies;

use Illuminate\Auth\Access\HandlesAuthorization;

use App\User;
use App\Permissao;
use Modules\Demarcacao\Entities\Demarcacao;

class DemarcacaoPolicy
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

    /**
     * Determine whether the user can update the demarcacao.
     *
     * @param  \App\User  $user
     * @param  \Model\Demarcacao\Entities\Demarcacao  $demarcacao
     * @return mixed
     */
    public function create(User $user, Demarcacao $demarcacao)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        
        return $usuario->permissoes()
            ->where('permissao', Permissao::DEMARCACAO_DEMARCACAO_CADASTRAR)->first();
    }

    /**
     * Determine whether the user can update the demarcacao.
     *
     * @param  \App\User  $user
     * @param  \Model\Demarcacao\Entities\Demarcacao  $demarcacao
     * @return mixed
     */
    public function update(User $user, Demarcacao $demarcacao)
    {
        $usuario = User::with(['permissoes'])->find($user->id);
        
        return $usuario->permissoes()
            ->where('permissao', Permissao::DEMARCACAO_DEMARCACAO_CADASTRAR)->first();
    }
}
