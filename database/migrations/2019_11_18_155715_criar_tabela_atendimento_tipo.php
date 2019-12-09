<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriarTabelaAtendimentoTipo extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {

        // Atendimento Tipo
        Schema::create('atend_tipo', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->text('tipo');
            $table->timestamps();
        });
        DB::table('atend_tipo')->insert(
            [
                ['tipo' => 'Presencial'],
                ['tipo' => 'Telefônico'],                
            ]
        );

        // Atendimento Atendimento
        Schema::create('atend_atendimento', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedInteger('idusuario');
            $table->unsignedBigInteger('idtipo');
            $table->timestamp('dataHoraInicio');
            $table->timestamp('dataHoraFim')->nullable();
            $table->timestamps();
            
            $table->foreign('idusuario')->references('id')->on('users');
            $table->foreign('idtipo')->references('id')->on('atend_tipo');
        });

        // Atendimento Comentário
        Schema::create('atend_comentario', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idatendimento');
            $table->unsignedInteger('idusuario');
            $table->text('comentario');
            $table->timestamp('dataHora')->nullable();
            $table->timestamps();
            
            $table->foreign('idusuario')->references('id')->on('users');
            $table->foreign('idatendimento')->references('id')->on('atend_atendimento');

            //
        });

        // Atendimento Assunto
        Schema::create('atend_assunto', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->text('assunto');
            $table->timestamps();
        });

        // Atendimento AtendimentoAssunto
        Schema::create('atend_atendimento_atend_assunto', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idatendimento');
            $table->unsignedBigInteger('idassunto');
            $table->timestamps();

            $table->foreign('idatendimento')->references('id')->on('atend_atendimento');
            $table->foreign('idassunto')->references('id')->on('atend_assunto');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('atend_atendimento_atend_assunto');
        Schema::dropIfExists('atend_assunto');
        Schema::dropIfExists('atend_comentario');
        Schema::dropIfExists('atend_atendimento');
        Schema::dropIfExists('atend_tipo');
    }
}
