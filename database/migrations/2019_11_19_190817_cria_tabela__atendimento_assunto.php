<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriaTabelaAtendimentoAssunto extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('AtendimentoAssunto', function (Blueprint $table) {

            $table->bigIncrements('id');
            $table->text('assunto');
            $table->timestamp('dataHora')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('AtendimentoAssunto');        
            //
    }
}
