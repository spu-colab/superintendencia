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

Route::middleware('jwt.auth')
    ->namespace("\Modules\Correspondencia\Http\Controllers")
    ->group(function () {     
    Route::prefix('correspondencia')->group(function () {
        Route::get('listar', 'CorrespondenciaController@index');
        Route::get('destinatarios/{codigo}', 'CorrespondenciaController@show');
        Route::get('setores', 'CorrespondenciaController@setores');
        Route::get('tipos', 'CorrespondenciaController@tipos');
        Route::get('tipoPostagem', 'CorrespondenciaController@tipoPostagem');
        Route::get('logradouros', 'CorrespondenciaController@tipoLogradouro');   
        Route::get('pesquisaMunicipio', 'CorrespondenciaController@pesquisaMunicipio');
        Route::get('gerarEtiqueta/{codigo}', 'CorrespondenciaController@gerarEtiqueta');
        Route::get('postagem', 'CorrespondenciaController@postagem');
        Route::put('postagem/{userLegado}', 'CorrespondenciaController@postagem');
        Route::get('gerarLista', 'CorrespondenciaController@gerarLista');
        Route::get('concluirLista', 'CorrespondenciaController@concluirLista');    
        Route::put('descartaCorresp/{id}', 'CorrespondenciaController@descartaCorresp');
        Route::put('receberAR/{id}', 'CorrespondenciaController@receberAR');
        Route::put('descartaDest/{id}', 'CorrespondenciaController@descartaDest');
        Route::put('descartarDestLista/{id}', 'CorrespondenciaController@descartarDestLista');
        Route::get('criarDestinatario', 'CorrespondenciaController@criarDestinatario');
        Route::post('criarCorrespondencia', 'CorrespondenciaController@criarCorrespondencia');
        Route::post('inserirLista', 'CorrespondenciaController@inserirLista');
    });
});