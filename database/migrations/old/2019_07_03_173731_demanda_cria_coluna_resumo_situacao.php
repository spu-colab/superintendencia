<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class DemandaCriaColunaResumoSituacao extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('demanda', function (Blueprint $table) {
            $table->text('resumoSituacao')->nullable()->after('demanda');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('demanda', function (Blueprint $table) {
            $table->dropColumn('resumoSituacao');
        });
    }
}
