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
    Route::apiResource('patrimonio', 'PatrimonioController');
    Route::get('patrimonio/tabelas', 'PatrimonioController@tabelas');
    Route::get('patrimonio/divisao', 'PatrimonioController@divisao');
    Route::post('patrimonio/gerarRelatorio', 'PatrimonioController@gerarRelatorio');
    Route::put('patrimonio/editar/{id}', 'PatrimonioController@editar');
    Route::put('patrimonio/editarLocal/{id}', 'PatrimonioController@editarLocal');
    Route::get('patrimonio/gerarTermo/{id}', 'PatrimonioController@gerarTermo');
    Route::post('patrimonio/criar', 'PatrimonioController@criar');
    Route::post('patrimonio/criarLocal', 'PatrimonioController@criarLocal');
});