<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBensSalaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bens_sala', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedInteger('idDivisaoOrganograma');
            $table->char('descricao',100);
            $table->unsignedInteger('idUser');
            $table->timestamps();            
            $table->foreign('idDivisaoOrganograma')->references('id')->on('divisaoorganograma');
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
        Schema::dropIfExists('bens_sala');
    }
}