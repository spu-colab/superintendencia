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
                    'permissao' => 'CORRESPONDENCIA_CORRESPONDENCIA_POSTAR',
                    'descricao' => 'Permite ao usuário da área de apoio gerir postagens'
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
        $permissao = DB::table('permissao')->where('permissao', 'CORRESPONDENCIA_CORRESPONDENCIA_POSTAR')->first();
        if(@$permissao->id) {
            DB::table('usuariopermissao')->where('idPermissao', '=', $permissao->id)->delete();
        }
        DB::table('permissao')->where('permissao', '=', 'CORRESPONDENCIA_CORRESPONDENCIA_POSTAR')->delete();
    }
}
