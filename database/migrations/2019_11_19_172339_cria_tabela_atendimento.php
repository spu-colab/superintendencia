<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriaTabelaAtendimento extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('atendimento', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedInteger('idUsuario');
            $table->unsignedInteger('idTipo');
            $table->timestamp('dataHoraInicio')->nullable();
            $table->timestamp('dataHoraFim')->nullable();
            $table->timestamps();
            
            $table->foreign('idUsuario')->references('id')->on('users');
            $table->foreign('idTipo')->references('id')->on('atendimentoTipo');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('atendimento');
    }
}
