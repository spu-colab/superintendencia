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

// Rotas Abertas
Route::prefix('geo')

    ->namespace("\Modules\Geo\Http\Controllers")
    ->group(function() {

        Route::get('camada', 'GeoController@listarCamadas');
        Route::get('camada/ativas', 'GeoController@listarAtivas');
        Route::get('camada/{geoCamada}', 'GeoController@obterCamada');
        Route::get('camada/{geoCamada}/geojson', 'GeoController@obterGeojson');

    });

// Rotas Fechadas
Route::prefix('geo')
    ->middleware('jwt.auth')
    ->namespace("\Modules\Geo\Http\Controllers")
    ->group(function() {

        Route::post("camada", "GeoController@salvarCamada");
        Route::put("camada/{camada}", "GeoController@salvarCamada");

        Route::post('referencia', 'GeoController@salvarReferencia');
        Route::get('camada/{camada}/referencia', 'GeoController@listarReferenciasPorCamada');
        Route::get('camada/{tabelaReferenciaCamada}/referencia/{idReferenciado}', 'GeoController@obterReferencia')
            ->where([
                'tabelaReferenciaCamada' => '[A-Za-z/_]+',
                'idReferenciado' => '[0-9]+'
            ]);
    });