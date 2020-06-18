<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriarPermissoesAuth extends Migration
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
                    'permissao' => 'PERMISSAO_CADASTRAR',
                    'descricao' => 'Permite ao usuário gerir permissões do sistema'
                ],
                [
                    'permissao' => 'USUARIO_CADASTRAR',
                    'descricao' => 'Permite ao usuário gerir usuários'
                ]
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
                'PERMISSAO_CADASTRAR',
                'USUARIO_CADASTRAR'
            ])
            ->delete();
    }
}
