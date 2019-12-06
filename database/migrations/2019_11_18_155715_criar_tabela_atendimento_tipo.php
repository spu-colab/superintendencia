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
        Schema::create('atendimentoTipo', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->text('tipo');
            $table->timestamps();
        });
        DB::table('atendimentoTipo')->insert(
            [
                [
                    'tipo' => 'Presencial'
                ],
                [
                    'tipo' => 'Telefônico'
                ],
                
            ]
        );
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('atendimentoTipo');
    }
}
