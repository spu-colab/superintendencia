<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::middleware('jwt.auth')->group(function () {     
    Route::resource('usuario', 'AuthController');
    Route::resource('permissao', 'PermissaoController');
    Route::resource('divisaoOrganograma', 'DivisaoOrganogramaController');
    Route::get('divisaoOrganograma/listarPai', 'DivisaoOrganogramaController@listarPai');
    Route::get('usuario/reduzido', 'AuthController@listarReduzido');    
//    Route::get('usuario', 'AuthController' ) ; 
//    Route::get('usuario/reduzido', 'AuthController@listarReduzido');    
/*    Route::get('usuario', function (Request $request) {    
        
        return App\User::with(['permissoes:Permissao.id,permissao,descricao',
            'divisoesOrganograma:DivisaoOrganograma.id,sigla,nome'])     
            ->whereRaw("name LIKE '%".strtolower($request->search)."%'")
            ->orWhereRaw("email LIKE '%".strtolower($request->search)."%'")
            ->orWhereRaw("telefone LIKE '%".strtolower($request->search)."%'")
            ->orWhereRaw("CONVERT(cpf , CHAR) LIKE '%" . strtolower($request->search) . "%'")
            ->orderBy('name', 'asc')->paginate($request->per_page);
    });
*/
});