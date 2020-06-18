<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriaPermissoesAtendimentoDemanda extends Migration
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
                    'permissao' => 'DEMANDA_DEMANDA_ALTERAR_RESUMO_GERENCIAL',
                    'descricao' => 'Permite ao usuário alterar o campo resumo gerencial'
                ],
                [
                    'permissao' => 'DEMANDA_DEMANDA_ATENDER_DISTRIBUICAO',
                    'descricao' => 'Permite a um usuário atender distruição feita a si próprio ou ao seu núcleo'
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
    }
}
