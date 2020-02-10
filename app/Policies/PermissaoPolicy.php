<?php
namespace App\Policies;
use App\Http\Controllers\PermissaoDivisaoOrganogramaTrait;
class PermissaoPolicy
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
        return $this->verificaUsuarioPermissao(["PERMISSAO_CADASTRAR"]);
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
        return $this->verificaUsuarioPermissao(["PERMISSAO_CADASTRAR"]);
    }
    
    public function destroy()
    {
        //
    }
    
}