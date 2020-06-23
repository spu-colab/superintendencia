<?php

use App\Permissao;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CorrecaoPermissoesAuth extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::table(Permissao::TABLE_NAME)
              ->where('permissao', Permissao::USUARIO_CADASTRAR)
              ->update(['permissao' => Permissao::AUTH_USUARIO_CADASTRAR]);

        DB::table(Permissao::TABLE_NAME)
              ->where('permissao', Permissao::PERMISSAO_CADASTRAR)
              ->update(['permissao' => Permissao::AUTH_PERMISSAO_CADASTRAR]);

        DB::table(Permissao::TABLE_NAME)
              ->where('permissao', Permissao::ORGANOGRAMA_CADASTRAR)
              ->update(['permissao' => Permissao::AUTH_ORGANOGRAMA_CADASTRAR]);
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::table(Permissao::TABLE_NAME)
              ->where('permissao', Permissao::AUTH_USUARIO_CADASTRAR)
              ->update(['permissao' => Permissao::USUARIO_CADASTRAR]);

        DB::table(Permissao::TABLE_NAME)
              ->where('permissao', Permissao::AUTH_PERMISSAO_CADASTRAR)
              ->update(['permissao' => Permissao::PERMISSAO_CADASTRAR]);

        DB::table(Permissao::TABLE_NAME)
              ->where('permissao', Permissao::AUTH_ORGANOGRAMA_CADASTRAR)
              ->update(['permissao' => Permissao::ORGANOGRAMA_CADASTRAR]);
    }
}
