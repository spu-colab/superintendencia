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

/**
 * Rotas abertas do módulo
 */
Route::prefix('auth')
    ->namespace("\Modules\Auth\Http\Controllers")
    ->group(function() {
    
    Route::get('divisao-organograma/superintendencia', 'DivisaoOrganogramaController@obterSuperintendencia');

});


/**
 * Rotas fechadas do módulo
 */
Route::prefix('auth')
    ->namespace("\Modules\Auth\Http\Controllers")
    ->middleware('jwt.auth')
    ->group(function() {

    Route::apiResource("menu", "MenuController");

});


Route::middleware('jwt.auth')->group(function () {     
    Route::apiResource('usuario', '\Modules\Auth\Http\Controllers\AuthController');
    Route::get('usuario/reduzido', '\Modules\Auth\Http\Controllers\AuthController@listarReduzido');    

    Route::resource('permissao', 'PermissaoController');
    Route::get('permissao/usuario/{permissaoId}', 'PermissaoController@usuarioPossuiPermissao');

    Route::apiResource('divisao-organograma', '\Modules\Auth\Http\Controllers\DivisaoOrganogramaController');
});

    
Route::get('divisaoOrganograma/listarPai', 'DivisaoOrganogramaController@listarPai');
    
