<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CriaGeoReferencia extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('geo_camada', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->char('titulo', 100);
            $table->char('tabelaReferencia', 100);
            $table->char('colunaIdReferencia', 100);
            $table->char('colunaTituloReferencia', 100);
        });

        Schema::create('geo_referencia', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idCamada');
            $table->unsignedBigInteger('idReferenciado');
            $table->multiPolygon('poligonais');
            $table->unsignedInteger('idUsuarioCriacao');
            $table->unsignedInteger('idUsuarioAlteracao');
            $table->timestamps();

        });

        Schema::table('geo_referencia', function(Blueprint $table) {
            $table->foreign('idCamada')->references('id')->on('geo_camada');
            $table->foreign('idUsuarioCriacao')->references('id')->on('users');
            $table->foreign('idUsuarioAlteracao')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('geo_referencia');
        Schema::dropIfExists('geo_camada');
    }
}
