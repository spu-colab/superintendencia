<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriaTabelaNaturezaOrgao extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::dropIfExists('naturezaorgao');
        Schema::create('naturezaorgao', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->char('natureza', 100);
            $table->timestamps();
        });

        Schema::table('orgao', function (Blueprint $table) {
            $table->unsignedBigInteger('idNaturezaOrgao')->after('idorgaopai')->nullable();        
            $table->foreign('idNaturezaOrgao')->references('id')->on('naturezaorgao');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('orgao', function (Blueprint $table) {
            $table->dropForeign('orgao_idnaturezaorgao_foreign');
            $table->dropColumn('idNaturezaOrgao');
        });

        Schema::drop('naturezaorgao');
    }
}
