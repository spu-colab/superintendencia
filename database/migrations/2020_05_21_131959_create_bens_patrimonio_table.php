<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBensPatrimonioTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bens_patrimonio', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('codigo')->unique();
            $table->text('descricao');
            $table->decimal('preco', 8, 2);
            $table->date('garantia')->nullable();
            $table->bigInteger('idSala')->unsigned();
            $table->bigInteger('idCategoria')->unsigned();
            $table->bigInteger('idSituacao')->unsigned()->default(4);
            $table->bigInteger('idDesfazimento')->unsigned()->nullable();
            $table->bigInteger('idConservacao')->unsigned()->default(1);
            $table->bigInteger('idLevantamento')->unsigned()->default(1);
            $table->unsignedInteger('idUser');
            $table->timestamps();
            $table->foreign('idUser')->references('id')->on('users');
            $table->foreign('idSala')->references('id')->on('bens_sala');
            $table->foreign('idCategoria')->references('id')->on('bens_categoria');
            $table->foreign('idSituacao')->references('id')->on('bens_situacao');
            $table->foreign('idDesfazimento')->references('id')->on('bens_termo_desfazimento');
        });
    }
    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('bens_patrimonio', function (Blueprint $table) {
            //
        });
    }
}
