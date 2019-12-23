<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AdicionarColunaCorATabelaCamada extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('geo_camada', function (Blueprint $table) {
            $table->text('cor')->nullable()->default('blue');
            $table->text('rotaFrontEnd')->nullable()->default('/nome-recurso/[id]');            
        });

        DB::table('geo_camada')
            ->where('tabelaReferencia', 'procedimentoexterno')
                ->update([
                    'cor' => 'red',
                    'rotaFrontEnd' => '/procedimento/[id]'
                ]);

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('geo_camada', function (Blueprint $table) {
            $table->dropColumn('cor');
            $table->dropColumn('rotaFrontEnd');
        });
    }
}
