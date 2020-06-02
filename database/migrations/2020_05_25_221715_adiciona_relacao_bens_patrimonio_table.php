<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AdicionaRelacaoBensPatrimonioTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('bens_patrimonio', function (Blueprint $table) {
            $table->foreign('idLevantamento')->references('id')->on('bens_levantamento');
            $table->foreign('idConservacao')->references('id')->on('bens_conservacao');
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
