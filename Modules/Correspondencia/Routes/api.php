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

    Route::apiResource('correspondencia', 'CorrespondenciaController');

    Route::get('correspondencia/setores', 'CorrespondenciaController@setores');
    Route::get('correspondencia/tipos', 'CorrespondenciaController@tipos');
    Route::get('correspondencia/logradouros', 'CorrespondenciaController@tipoLogradouro');   
    

//    Route::resource('correspondencia/pesquisaMunicipio', 'CorrespondenciaController@pesquisaMunicipio');    
    Route::get('correspondencia/pesquisaMunicipio', 'CorrespondenciaController@pesquisaMunicipio');
    Route::get('correspondencia/autocomplete', 'CorrespondenciaController@autocomplete');

    Route::get('correspondencia/gerarEtiqueta/{codigo}', 'CorrespondenciaController@gerarEtiqueta'); 
    Route::get('correspondencia/postagem', 'CorrespondenciaController@postagem');
    Route::put('correspondencia/postagem/{userLegado}', 'CorrespondenciaController@postagem');
    Route::get('correspondencia/gerarLista', 'CorrespondenciaController@gerarLista');
    Route::get('correspondencia/concluirLista', 'CorrespondenciaController@concluirLista');    
    //Route::post('correspondencia/descartaCorresp', 'CorrespondenciaController@descartaCorresp');
    Route::put('correspondencia/descartaCorresp/{id}', 'CorrespondenciaController@descartaCorresp');
    
    Route::put('correspondencia/receberAR/{id}', 'CorrespondenciaController@receberAR');
    //Route::post('correspondencia/receberAR/{id}', 'CorrespondenciaController@receberAR'); 

    Route::put('correspondencia/descartaDest/{id}', 'CorrespondenciaController@descartaDest');
    //Route::post('correspondencia/descartaDest', 'CorrespondenciaController@descartaDest'); 
    Route::put('correspondencia/descartarDestLista/{id}', 'CorrespondenciaController@descartarDestLista');
    //Route::post('correspondencia/descartarDestLista', 'CorrespondenciaController@descartarDestLista');
    Route::get('correspondencia/criarDestinatario', 'CorrespondenciaController@criarDestinatario');
    Route::post('correspondencia/criarCorrespondencia', 'CorrespondenciaController@criarCorrespondencia');
    Route::post('correspondencia/inserirLista', 'CorrespondenciaController@inserirLista');


});