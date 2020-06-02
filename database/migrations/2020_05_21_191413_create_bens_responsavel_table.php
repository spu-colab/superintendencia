<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBensResponsavelTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bens_responsavel', function (Blueprint $table) {
        $table->bigIncrements('id');
        $table->unsignedInteger('idUserResp');
        $table->bigInteger('idPatrimonio')->unsigned();
        $table->unsignedInteger('idUser');
        $table->timestamps();
        $table->softDeletes();
        $table->foreign('idUserResp')->references('id')->on('users');
        $table->foreign('idUser')->references('id')->on('users');
        $table->foreign('idPatrimonio')->references('id')->on('bens_patrimonio');
    });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
    }
}
