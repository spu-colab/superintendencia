<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriarPermissaoPatrimonioCadastrar extends Migration
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
                    'permissao' => 'PATRIMONIO_PATRIMONIO_CADASTRAR',
                    'descricao' => 'Permite ao usuário da área de apoio gerir bens patrimoniais'
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
        DB::table('permissao')->where('permissao', '=', 'PATRIMONIO_PATRIMONIO_CADASTRAR')->delete();
    }
}
