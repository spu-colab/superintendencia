<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Auth::routes();

Route::get('/', function () {
    return view('template');
});

Route::get('/home', function () {
    return view('auth.login');
});

Route::middleware('auth')->group(function () {
    Route::get('demanda/entidadeAtribuivel', 'DemandaController@listarAtribuiveis');
    Route::post('demanda/cancelar', 'DemandaController@cancelar');
    Route::post('demanda/aguardar-assinatura', 'DemandaController@aguardarAssinatura');
    Route::post('demanda/aguardar-AR', 'DemandaController@aguardarAR');
    Route::post('demanda/resolver', 'DemandaController@resolver');
    Route::get('demanda/procedimento/{idProcedimentoExterno}', 'DemandaController@listarPorProcedimentoExterno');

    Route::post('demanda/distribuicao/{id?}', 'DemandaController@salvarDistribuicao');

    Route::get('demandas', function() { return view('demanda');});
    Route::resource('demanda', 'DemandaController');

    Route::get('procedimentos', function() { return view('procedimento');});
    Route::resource('procedimentoExterno', 'ProcedimentoExternoController');

    Route::get('demandantes', function() { return view('autor-demanda');});
    Route::resource('autorDemanda', 'AutorDemandaController');

    Route::get('orgaos', function() { return view('orgao');});
    Route::resource('orgao', 'OrgaoController');

    Route::resource('cargo', 'CargoController');
    Route::resource('tipoDocumento', 'TipoDocumentoController');
    Route::resource('situacaoDemanda', 'SituacaoDemandaController');
    Route::resource('divisaoOrganograma', 'DivisaoOrganogramaController');
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

//RELATÓRIOS
Route::get('demanda/relatorio/entrada-saida-diaria', 'DemandaController@relatorioEntradaSaidaDiaria');
Route::get('demanda/relatorio/abertas-situacao', 'DemandaController@relatorioAbertasPorSituacao');
Route::get('demanda/relatorio/abertas-distribuicao', 'DemandaController@relatorioAbertasPorDistribuicao');
Route::get('demanda/relatorio/abertas-demandante', 'DemandaController@relatorioAbertasPorDemandante');

// Route::get('extrator/spunet', 'SPUnetController@extrair');