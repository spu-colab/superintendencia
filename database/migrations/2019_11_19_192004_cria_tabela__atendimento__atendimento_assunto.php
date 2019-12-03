<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriaTabelaAtendimentoAtendimentoAssunto extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('Atendimento_AtendimentoAssunto', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idAtendimento');
            $table->unsignedBigInteger('idAtendimentoAssunto');
            $table->timestamps();

            $table->foreign('idAtendimento')->references('id')->on('atendimento');
            $table->foreign('idAtendimentoAssunto')->references('id')->on('atendimentoassunto');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('Atendimento_AtendimentoAssunto');
    }
}
