<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriaUsuarioDivisaoOrganograma extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('usuariodivisaoorganograma', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedInteger('idUsuario');
            $table->unsignedInteger('idDivisaoOrganograma');
            $table->timestamps();
        });

        Schema::table('usuariodivisaoorganograma', function(Blueprint $table) {
            $table->foreign('idUsuario')->references('id')->on('users');
            $table->foreign('idDivisaoOrganograma')->references('id')->on('divisaoorganograma');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('usuariodivisaoorganograma');
    }
}
