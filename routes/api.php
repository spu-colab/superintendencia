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


Route::middleware('jwt.auth')->group(function () {
    
    Route::resource('correspondencia/setores', 'CorrespondenciaController@setores'); 
    Route::resource('correspondencia/tipos', 'CorrespondenciaController@tipos'); 
    Route::resource('correspondencia/pesquisaMunicipio', 'CorrespondenciaController@pesquisaMunicipio');

    Route::get('correspondencia/postagem', 'CorrespondenciaController@postagem');
    Route::get('correspondencia/gerarLista', 'CorrespondenciaController@gerarLista');
    Route::get('correspondencia/concluirLista', 'CorrespondenciaController@concluirLista');    
    Route::get('correspondencia/gerarEtiqueta/{codigo}', 'CorrespondenciaController@gerarEtiqueta');
    Route::get('correspondencia/criarDestinatario', 'CorrespondenciaController@criarDestinatario');
    Route::post('correspondencia/inserirLista', 'CorrespondenciaController@inserirLista');
    Route::resource('correspondencia/autocomplete', 'CorrespondenciaController@autocomplete');
    Route::resource('correspondencia/logradouros', 'CorrespondenciaController@tipoLogradouro'); 
    Route::post('correspondencia/descartaCorresp', 'CorrespondenciaController@descartaCorresp');
    Route::post('correspondencia/receberAR/{id}', 'CorrespondenciaController@receberAR'); 
    Route::post('correspondencia/descartaDest', 'CorrespondenciaController@descartaDest'); 
    Route::post('correspondencia/descartarDestLista', 'CorrespondenciaController@descartarDestLista');
    
//Route::get('correspondencia/pesquisaMunicipio', 'CorrespondenciaController@pesquisaMunicipio');

    Route::resource('usuario/reduzido', 'AuthController@listarReduzido');
    Route::resource('divisaoOrganograma/listarPai', 'DivisaoOrganogramaController@listarPai');
    Route::resource('procedimentoExterno', 'ProcedimentoExternoController');
    Route::get('procedimentoExterno/buscar/{search}', 'ProcedimentoExternoController@search');
    Route::resource('tipoProcedimentoExterno', 'TipoProcedimentoExternoController');
    Route::resource('poloProcedimentoExterno', 'PoloProcedimentoExternoController');

//    Route::post('correspondencia/criarCorrespondencia', 'CorrespondenciaController@criarCorrespondencia');



    // Route::resource('conteudo', 'ConteudoController');
    Route::get('demanda/entidadeAtribuivel', 'DemandaController@listarAtribuiveis');
    Route::post('demanda/cancelar', 'DemandaController@cancelar');
    Route::post('demanda/aguardar-assinatura', 'DemandaController@aguardarAssinatura');
    Route::post('demanda/aguardar-AR', 'DemandaController@aguardarAR');
    Route::post('demanda/resolver', 'DemandaController@resolver');
    Route::get('demanda/procedimento/{idProcedimentoExterno}', 'DemandaController@listarPorProcedimentoExterno');
    Route::get('demanda/pdf/{ids}', 'DemandaController@gerarPDF');
    Route::post('demanda/distribuicao/{id?}', 'DemandaController@salvarDistribuicao');
    Route::get('demanda/usuario/{user}', 'DemandaController@listarDistribuidasParaUsuario');
    Route::get('demanda/divisao-organograma/{divisaoOrganograma}', 'DemandaController@listarDistribuidasParaDivisaoOrganograma');
    Route::resource('demanda', 'DemandaController');

    Route::apiResource('autorDemanda', 'AutorDemandaController');
    Route::resource('cargo', 'CargoController');
    Route::resource('orgao', 'OrgaoController');
    Route::get('natureza-orgao', 'OrgaoController@listarNaturezas');

    Route::resource('tipoDocumento', 'TipoDocumentoController');
    Route::resource('situacaoDemanda', 'SituacaoDemandaController');
    Route::resource('usuario/reduzido', '\Modules\Auth\Http\Controllers\AuthController@listarReduzido');
    // Route::resource('divisaoOrganograma/listarPai', '\Modules\Auth\Http\Controllers\DivisaoOrganogramaController@listarPai');
    Route::resource('procedimentoExterno', 'ProcedimentoExternoController');
    Route::get('procedimentoExterno/buscar/{search}', 'ProcedimentoExternoController@search');
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

    Route::post('geo/referencia', 'GeoController@salvarReferencia');
    Route::get('geo/camada', 'GeoController@listarCamadas');
    Route::get('geo/camada/{camada}/referencia', 'GeoController@listarReferenciasPorCamada');
    Route::get('geo/camada/{id}', 'GeoController@obterCamada');
    Route::get('geo/camada/{tabelaReferenciaCamada}/referencia/{idReferenciado}', 'GeoController@obterReferencia')
        ->where([
            'tabelaReferenciaCamada' => '[A-Za-z/_]+',
            'idReferenciado' => '[0-9]+'
        ]);
    
    //RELATÓRIOS
    Route::get('demanda/relatorio/entrada-saida-diaria', 'DemandaController@relatorioEntradaSaidaDiaria');
    Route::post('demanda/relatorio/acompanhamento', 'DemandaController@gerarPDFAcompanhamento');
    
    Route::get('demanda/relatorio/abertas-distribuicao', 'DemandaController@relatorioAbertasPorDistribuicao');
    Route::get('demanda/relatorio/abertas-distribuicao/{dataDe}/{dataAte}', 'DemandaController@relatorioAbertasPorDistribuicao')
        ->where([
            'dataDe' => '[0-9]{4}-[0-9]{2}-[0-9]{2}',
            'dataAte' => '[0-9]{4}-[0-9]{2}-[0-9]{2}',
            ]);
    
    Route::get('demanda/relatorio/abertas-demandante', 'DemandaController@relatorioAbertasPorDemandante');
    Route::get('demanda/relatorio/abertas-demandante/{dataDe}/{dataAte}', 'DemandaController@relatorioAbertasPorDemandante')
    ->where([
        'dataDe' => '[0-9]{4}-[0-9]{2}-[0-9]{2}',
        'dataAte' => '[0-9]{4}-[0-9]{2}-[0-9]{2}',
        ]);
        
        Route::get('demanda/relatorio/estatistica-periodo', 'DemandaController@relatorioEstatisticaPeriodo');
        Route::get('demanda/relatorio/estatistica-periodo/{dataDe}/{dataAte}', 'DemandaController@relatorioEstatisticaPeriodo')
        ->where([
            'dataDe' => '[0-9]{4}-[0-9]{2}-[0-9]{2}',
            'dataAte' => '[0-9]{4}-[0-9]{2}-[0-9]{2}',
        ]);
    
    Route::get('demanda/relatorio/abertas-natureza', 'DemandaController@relatorioAbertasPorNaturezaOrgao');
    Route::get('demanda/relatorio/abertas-natureza/{dataDe}/{dataAte}', 'DemandaController@relatorioAbertasPorNaturezaOrgao')
        ->where([
            'dataDe' => '[0-9]{4}-[0-9]{2}-[0-9]{2}',
            'dataAte' => '[0-9]{4}-[0-9]{2}-[0-9]{2}',
        ]);
        
    //Route::resource('usuario', 'UsuarioController');
    
    // Route::get('arquivo', 'ArquivoController@index');
    // Route::get('arquivo/criar', 'ArquivoController@create');
    // Route::post('arquivo', 'ArquivoController@uploadFile');
});


 
