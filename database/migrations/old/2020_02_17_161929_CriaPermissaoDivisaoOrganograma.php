<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriaPermissaoDivisaoOrganograma extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::table('permissao')->insert(
            [
                [
                    'permissao' => 'ORGANOGRAMA_CADASTRAR',
                    'descricao' => 'Permite ao usuário gerir divisões do organograma'
                ],
            ]
        );
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::table('permissao')
            ->whereIn('permissao', [
                'ORGANOGRAMA_CADASTRAR'
            ])
            ->delete();
    }
}
