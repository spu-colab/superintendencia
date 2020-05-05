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
    Route::resource('correspondencia', 'CorrespondenciaController');
    Route::get('correspondencia/setores', 'CorrespondenciaController@setores');
    Route::get('correspondencia/tipos', 'CorrespondenciaController@tipos');
    Route::get('correspondencia/autocomplete', 'CorrespondenciaController@autocomplete');
    Route::get('correspondencia/pesquisaMunicipio', 'CorrespondenciaController@pesquisaMunicipio');    
    Route::get('correspondencia/logradouros', 'CorrespondenciaController@tipoLogradouro');   
    Route::get('correspondencia/gerarEtiqueta/{codigo}', 'CorrespondenciaController@gerarEtiqueta'); 
    Route::put('correspondencia/postagem/{userLegado}', 'CorrespondenciaController@postagem');
    Route::get('correspondencia/gerarLista', 'CorrespondenciaController@gerarLista');
    Route::get('correspondencia/concluirLista', 'CorrespondenciaController@concluirLista');    
    Route::put('correspondencia/descartaCorresp/{id}', 'CorrespondenciaController@descartaCorresp');
    Route::put('correspondencia/receberAR/{id}', 'CorrespondenciaController@receberAR');
    Route::put('correspondencia/descartaDest/{id}', 'CorrespondenciaController@descartaDest');
    Route::put('correspondencia/descartarDestLista/{id}', 'CorrespondenciaController@descartarDestLista');
    Route::get('correspondencia/criarDestinatario', 'CorrespondenciaController@criarDestinatario');
    Route::get('correspondencia/criarCorrespondencia', 'CorrespondenciaController@criarCorrespondencia');
    Route::get('correspondencia/inserirLista', 'CorrespondenciaController@inserirLista');
});