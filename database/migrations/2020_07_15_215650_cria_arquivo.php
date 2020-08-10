<?php

use App\Arquivo;
use App\Permissao;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class CriaArquivo extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::dropIfExists(Arquivo::TABLE_NAME);

        Schema::create(Arquivo::TABLE_NAME, function (Blueprint $table) {
            $table->id();
            $table->string('disco');
            $table->string('diretorio');
            $table->string('nome');
            $table->string('nome_real');            
            $table->string('caminho_absoluto');
            $table->string('mime');
            $table->integer('tamanho');
            $table->unsignedInteger('idUsuarioCriacao');
            $table->timestamps();

            $table->foreign('idUsuarioCriacao')->references('id')->on('users');

            $table->unique(['disco', 'diretorio', 'nome']);
            $table->unique('caminho_absoluto');
        });

        DB::table(Permissao::TABLE_NAME)->insert([
            [
                'permissao' => Permissao::ARQUIVO_ARQUIVO_UPLOAD,
                'descricao' => 'Permite que o usuário faça upload de arquivos'
            ]
        ]);

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::table(Permissao::TABLE_NAME)->where("permissao", "=", Permissao::ARQUIVO_ARQUIVO_UPLOAD)->delete();
        Schema::dropIfExists(Arquivo::TABLE_NAME);
    }
}
