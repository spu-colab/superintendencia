<?php

namespace Modules\Auth\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Modules\Auth\UsuarioPermissaoTrait;
use Nwidart\Modules\Facades\Module;
use Ramsey\Collection\Tool\ValueToStringTrait;

class MenuController extends Controller
{

    use UsuarioPermissaoTrait;

    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        $menu = [
            /*
            'SPU-Admin (Interno)' => [
                "rotulo" => 'SPU-Admin (Interno)',
                "icone" => 'desktop_windows',
                "url" => 'http://10.209.232.190/'
            ]
            */
            'Geovisualizador' => [
                "rotulo" => 'Geovisualizador',
                "icone" => 'map', 
                "rota" => '/geo',
            ],
        ];
        foreach (Module::getOrdered() as $m => $module) {
            if($module->isEnabled()) {
                $prefixo = $module->getLowerName();
                $menu_modulo = config($prefixo . ".menu");
                if(is_array($menu_modulo)) {
                    $menu[$menu_modulo["rotulo"]] = $menu_modulo;
                }
            }
        }
        ksort($menu, SORT_STRING);
        $menu = array_values($menu);
        array_unshift($menu, 
            [
                "rotulo" => 'Início',
                "icone" => 'home', 
                "rota" => '/',
            ],
            [
                "rotulo" => "Base de Conhecimento",
                "icone" => 'local_library',
                "url" => 'http://conhecimento.spu.nossa.floripa.br'
            ],
            [
                "divisor" => true
            ],
        );
        $menu = $this->filtrarPorPermissao($menu);
        return $menu;
    }


    private function filtrarPorPermissao(Array $menu) {
        $menuFiltrado = [];

        foreach ($menu as $m => $itemMenu) {
            if(isset($itemMenu["submenu"])) {
                // se tem submenu, faz a chamada recursiva
                $itemMenu["submenu"] = $this->filtrarPorPermissao($itemMenu["submenu"]);
                if(sizeof($itemMenu["submenu"])) {
                    $menuFiltrado[] = $itemMenu;        
                }
            } else {
                // se não tem submenu... 
                $permissoesNecessarias = $itemMenu["permissoes"] ?? null;
                
                // ...verifica se necessita de permissão...
                if(!$permissoesNecessarias) {
                    $menuFiltrado[] = $itemMenu;
                } else {
                    // ...ou se possui alguma das permissões necessárias
                    if($this->usuarioPossuiAlgumaDasPermissoes($permissoesNecessarias)) {
                        $menuFiltrado[] = $itemMenu;
                    }
                }

            }
        }

        return $menuFiltrado;
    }

    /**
     * Show the form for creating a new resource.
     * @return Response
     */
    public function create()
    {
        return view('auth::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Response
     */
    public function show($id)
    {
        return view('auth::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Response
     */
    public function edit($id)
    {
        return view('auth::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Response
     */
    public function destroy($id)
    {
        //
    }
}
