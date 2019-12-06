<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriaTabelaAtendimentoComentario extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('AtendimentoComentario', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idAtendimento');
            $table->unsignedInteger('idUsuario');
            $table->text('comentario');
            $table->timestamp('dataHora')->nullable();
            $table->timestamps();
            
            $table->foreign('idUsuario')->references('id')->on('users');
            $table->foreign('idAtendimento')->references('id')->on('atendimento');

            //
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('AtendimentoComentario');        
    }
}
