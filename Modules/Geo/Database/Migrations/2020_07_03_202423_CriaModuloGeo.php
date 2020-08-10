<?php

use App\Permissao;
use App\UsuarioPermissao;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Modules\Geo\Entities\GeoCamada;

class CriaModuloGeo extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // cadastra permissão
        DB::table(Permissao::TABLE_NAME)->insert([
            [
                'permissao' => Permissao::GEO_CAMADA_CADASTRAR,
                'descricao' => 'Permite que o faça a gestão das camadas de geo informação'
            ]
        ]);

        Schema::table(GeoCamada::TABLE_NAME, function (Blueprint $table) {
            $table->string('tabelaReferencia', 100)->nullable()->change();
            $table->string('colunaIdReferencia', 100)->nullable()->change();
            $table->string('colunaTituloReferencia', 100)->nullable()->change();
            $table->string('colunaSubTituloReferencia', 100)->nullable()->change();

            $table->boolean('ativa')->default(true);
            $table->boolean('estatica')->default(true);
            $table->json('geojson')->nullable();

            $table->string('propriedadeTitulo', 100)->nullable()->default('titulo');
            $table->string('propriedadeSubTitulo', 100)->nullable()->default('subtitulo');
            $table->foreignId('idUsuarioCriacao');
            $table->foreignId('idUsuarioAlteracao')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table(GeoCamada::TABLE_NAME, function (Blueprint $table) {
            $table->dropTimestamps();
            $table->dropColumn(['idUsuarioAlteracao', 'idUsuarioCriacao', 'propriedadeTitulo', 'propriedadeSubTitulo', 'geojson', 'estatica', 'ativa']);
        });

        $permissaoGeoCamadaCadastrar = Permissao::where("permissao", "=", Permissao::GEO_CAMADA_CADASTRAR)->first();
        DB::table(UsuarioPermissao::TABLE_NAME)->where("idPermissao", "=", $permissaoGeoCamadaCadastrar->id)->delete();
        DB::table(Permissao::TABLE_NAME)->where("permissao", "=", Permissao::GEO_CAMADA_CADASTRAR)->delete();
    }
}
