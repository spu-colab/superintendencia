<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class GeoCamadaColunaRotulo extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('geo_camada', function (Blueprint $table) {
            $table->char('rotulo', 150)->after('titulo');
            $table->char('colunaSubTituloReferencia', 100)->after('colunaTituloReferencia');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('geo_camada', function (Blueprint $table) {
            $table->dropColumn('rotulo');
            $table->dropColumn('colunaTituloReferencia');
        });
    }
}
