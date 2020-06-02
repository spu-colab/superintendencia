<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBensTermoDesfazimentoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bens_termo_desfazimento', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->dateTime('concluido_em')->nullable();
            $table->char('destino',50)->nullable();
            $table->char('processo',50)->nullable();
            $table->char('oficio',50)->nullable();
            $table->char('despacho',50)->nullable();
            $table->char('observacoes',200)->nullable();
            $table->unsignedInteger('idUser');
            $table->timestamps();            
            $table->foreign('idUser')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('bens_termo_desfazimento');    
    }
}
