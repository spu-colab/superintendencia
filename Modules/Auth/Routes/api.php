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
    Route::resource('permissao', 'PermissaoController');
    Route::get('divisaoOrganograma/listarPai', '\Modules\Auth\Http\Controllers\DivisaoOrganogramaController@listarPai');
    
    Route::resource('usuario', '\Modules\Auth\Http\Controllers\AuthController');
    Route::get('usuario/reduzido', '\Modules\Auth\Http\Controllers\AuthController@listarReduzido');    
});