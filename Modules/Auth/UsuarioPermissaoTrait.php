<?php
namespace Modules\Auth;

use Illuminate\Support\Facades\Auth;

use App\User;
use Tymon\JWTAuth\Facades\JWTAuth;

trait UsuarioPermissaoTrait {

    public function usuarioPossuiAlgumaDasPermissoes(Array $permissoes){
        $user = Auth::user();
        if(!@$user->id) {
            return false;
        }
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()->whereIn('permissao', $permissoes)->exists();
    }

}

?>