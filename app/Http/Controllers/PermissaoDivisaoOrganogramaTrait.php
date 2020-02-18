<?php
namespace App\Http\Controllers;
use App\User;
use App\UsuarioPermissao;
use Modules\Auth\Entities\UsuarioDivisaoOrganograma; 
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

trait PermissaoDivisaoOrganogramaTrait {

    public function removeUsuarioUsuarioPermissao($idUsuario){
        UsuarioPermissao::where('idUsuario', $idUsuario)->delete();
    }

    public function removeUsuarioUsuarioDivisaoOrganograma($idUsuario){
        UsuarioDivisaoOrganograma::where('idUsuario', $idUsuario)->delete();
    }

    public function removePermissaoUsuarioPermissao($idPermissao){
        UsuarioPermissao::where('idPermissao', $idPermissao)->delete(); 
    }

    public function removeDivisaoUsuarioDivisaoOrganograma($idDivisaoOrganograma){
        UsuarioDivisaoOrganograma::where('idDivisaoOrganograma', $idDivisaoOrganograma)->delete();
    }
    
    public function incluiUsuarioUsuarioDivisaoOrganograma($idUsuario, $idDivisaoOrganograma){
        date_default_timezone_set('America/Sao_Paulo');
        $dataAtual  = date("Y-m-d H:i:s");      
        UsuarioDivisaoOrganograma::insert(
            [
            'idUsuario'  => $idUsuario,
            'idDivisaoOrganograma' => $idDivisaoOrganograma,
            'created_at' => $dataAtual
            ]
        );        
    }
    public function incluiUsuarioPermissao($idUsuario, $idPermissao){
        date_default_timezone_set('America/Sao_Paulo');
        $dataAtual  = date("Y-m-d H:i:s");  
        UsuarioPermissao::insert(
            [
            'idUsuario'  => $idUsuario,
            'idPermissao' => $idPermissao,
            'created_at' => $dataAtual
            ]
        );                
    }
    public function verificaUsuarioPermissao($permissoesArray){
        $user = Auth::user();
        $usuario = User::with(['permissoes'])->find($user->id);
        return $usuario->permissoes()->whereIn('permissao', $permissoesArray)->first();
    }
}