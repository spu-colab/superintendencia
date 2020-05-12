<?php

namespace Modules\Correspondencia\Policies;

use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;
use Modules\Correspondencia\Entities\CorrespDest;
use App\User;
use App\Permissao;

class CorrespondenciaPolicy
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

    public function create()
    {
        $user = Auth::user();
        $usuario = User::with(['permissoes'])->find($user->id);
        
        return $usuario->permissoes()
            ->where('permissao', Permissao::CORRESPONDENCIA_CORRESPONDENCIA_POSTAR)->first();
    }

    public function update()
    {
        $user = Auth::user();
        $usuario = User::with(['permissoes'])->find($user->id);        
        return $usuario->permissoes()
            ->where('permissao', Permissao::CORRESPONDENCIA_CORRESPONDENCIA_POSTAR)->first();
    }
}
