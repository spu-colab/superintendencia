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

    Route::get('atendimento/assunto', 'AtendimentoController@listarAssuntos');
    Route::resource('atendimento', 'AtendimentoController');
    Route::get('atendimento/listar/{data}', 'AtendimentoController@listarAtendimentos')
        ->where(
            ['data' => '[0-9]{4}-[0-9]{2}-[0-9]{2}']
        );
    
    // Route::get('atendimento/nao-concluidos/', 'AtendimentoController@listarAtendimentoNaoConcluido')    ;    
    // Route::post('atendimento/comentar/{id}', 'AtendimentoController@inserirComentario');

});
    
