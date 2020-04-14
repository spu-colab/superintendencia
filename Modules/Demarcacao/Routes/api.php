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
    Route::apiResource('demarcacao/demarcacao', '\Modules\Demarcacao\Http\Controllers\DemarcacaoController');
    Route::apiResource('demarcacao/tipo', '\Modules\Demarcacao\Http\Controllers\TipoDemarcacaoController');
    Route::apiResource('demarcacao/situacao', '\Modules\Demarcacao\Http\Controllers\SituacaoDemarcacaoController');
    Route::apiResource('demarcacao/trecho', '\Modules\Demarcacao\Http\Controllers\TrechoDemarcacaoController');
});
