<?php
namespace App\Policies;
use App\Http\Controllers\PermissaoDivisaoOrganogramaTrait;
use App\Permissao;
class AuthPolicy
{    
    
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

    public function index()
    {
        //
    }
    public function create()
    {
        //
    }

    public function store()
    {
        return $this->verificaUsuarioPermissao([Permissao::AUTH_USUARIO_CADASTRAR]);
    }

    public function show()
    {
        //
    }

    public function edit()
    {
        //
    }

    public function update()
    {
        return $this->verificaUsuarioPermissao([Permissao::AUTH_USUARIO_CADASTRAR]);
    }
    
    public function destroy()
    {
        //
    }
    
}