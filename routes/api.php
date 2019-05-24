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

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('user/register', 'APIRegisterController@register');
Route::post('user/login', 'APILoginController@login');
Route::middleware('jwt.auth')->get('procedimentoExterno/{search}', 'ProcedimentoExternoController@search');


Route::middleware('jwt.auth')->group(function () {
    Route::get('demanda/entidadeAtribuivel', 'DemandaController@listarAtribuiveis');
    Route::post('demanda/cancelar', 'DemandaController@cancelar');
    Route::post('demanda/aguardar-assinatura', 'DemandaController@aguardarAssinatura');
    Route::post('demanda/aguardar-AR', 'DemandaController@aguardarAR');
    Route::post('demanda/resolver', 'DemandaController@resolver');
    Route::get('demanda/procedimento/{idProcedimentoExterno}', 'DemandaController@listarPorProcedimentoExterno');

    Route::post('demanda/distribuicao/{id?}', 'DemandaController@salvarDistribuicao');

    Route::resource('demanda', 'DemandaController');
    Route::resource('autorDemanda', 'AutorDemandaController');
    Route::resource('cargo', 'CargoController');
    Route::resource('orgao', 'OrgaoController');
    Route::resource('tipoDocumento', 'TipoDocumentoController');
    Route::resource('situacaoDemanda', 'SituacaoDemandaController');
    Route::resource('divisaoOrganograma', 'DivisaoOrganogramaController');
    Route::resource('procedimentoExterno', 'ProcedimentoExternoController');
    Route::resource('tipoProcedimentoExterno', 'TipoProcedimentoExternoController');
    Route::resource('poloProcedimentoExterno', 'PoloProcedimentoExternoController');

    Route::middleware('jwt.refresh')->post('demanda', 'DemandaController@store');
    Route::middleware('jwt.refresh')->put('demanda/{demanda}', 'DemandaController@update');
    Route::middleware('jwt.refresh')->post('procedimentoExterno', 'ProcedimentoExternoController@store');
    Route::middleware('jwt.refresh')->put('procedimentoExterno/{procedimentoExterno}', 'ProcedimentoExternoController@update');
    Route::middleware('jwt.refresh')->post('autorDemanda', 'AutorDemandaController@store');
    Route::middleware('jwt.refresh')->put('autorDemanda/{autorDemanda}', 'AutorDemandaController@update');
    Route::middleware('jwt.refresh')->post('orgao', 'OrgaoController@store');
    Route::middleware('jwt.refresh')->put('orgao/{orgao}', 'OrgaoController@update');
    Route::middleware('jwt.refresh')->get('user/refresh', function () {
        return "OK";
        });
    }
);

Route::get('arquivo', 'ArquivoController@index');
Route::get('arquivo/criar', 'ArquivoController@create');
Route::post('arquivo', 'ArquivoController@uploadFile');

//RELATÓRIOS
Route::get('demanda/relatorio/entrada-saida-diaria', 'DemandaController@relatorioEntradaSaidaDiaria');
Route::get('demanda/relatorio/abertas-situacao', 'DemandaController@relatorioAbertasPorSituacao');
Route::get('demanda/relatorio/abertas-distribuicao', 'DemandaController@relatorioAbertasPorDistribuicao');
Route::get('demanda/relatorio/abertas-demandante', 'DemandaController@relatorioAbertasPorDemandante');
