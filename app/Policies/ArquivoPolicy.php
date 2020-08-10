<?php

namespace App\Policies;

use App\Http\Controllers\PermissaoDivisaoOrganogramaTrait;
use App\Permissao;
use App\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class ArquivoPolicy
{
    use HandlesAuthorization;

    use PermissaoDivisaoOrganogramaTrait;

    /**
     * Create a new policy instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    public function upload() {
        return $this->verificaUsuarioPermissao([Permissao::ARQUIVO_ARQUIVO_UPLOAD]);
    }
}
