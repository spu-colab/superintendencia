<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSetorDivisaoOrganograma extends Migration
{

    const ENV_DB_VAR = "DB_DATABASE_ADMIN";

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create(\env($this::ENV_DB_VAR).".setordivisaoorganograma", function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedInteger('idSetor');
            $table->unsignedInteger('idDivisaoOrganograma');
            $table->timestamps();
        });        
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists(\env($this::ENV_DB_VAR).'.setordivisaoorganograma');
    }
}
