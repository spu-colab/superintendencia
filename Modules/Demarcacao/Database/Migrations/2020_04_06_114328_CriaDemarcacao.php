<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriaDemarcacao extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // Tipo Demarcação
        Schema::create('demar_tipodemarcacao', function (Blueprint $table) {
            $table->bigIncrements('id_tipodemarcacao');
            $table->text('tipodemarcacao');
            $table->timestamps();
        });

        // Situação Demarcação
        Schema::create('demar_situacaodemarcacao', function (Blueprint $table) {
            $table->bigIncrements('id_situacaodemarcacao');
            $table->text('situacaodemarcacao');
            $table->timestamps();
        });

        // Trecho Demarcação
        Schema::create('demar_trechodemarcacao', function (Blueprint $table) {
            $table->bigIncrements('id_trechodemarcacao');
            $table->text('trechodemarcacao');
            $table->timestamps();
        });

        // Demarcação
        Schema::create('demar_demarcacao', function (Blueprint $table) {
            $table->bigIncrements('id_demarcacao');
            $table->unsignedBigInteger('id_tipodemarcacao');
            $table->unsignedBigInteger('id_situacaodemarcacao');
            $table->unsignedBigInteger('id_trechodemarcacao');
            $table->text('processo');
            $table->text('subtrecho')->nullable();
            $table->text('lpm_ltm')->nullable();
            $table->text('fonte')->nullable();
            $table->text('edital')->nullable();
            $table->date('datahomologacao')->nullable();
            $table->timestamps();

            $table->foreign('id_tipodemarcacao')
                ->references('id_tipodemarcacao')
                ->on('demar_tipodemarcacao');

            $table->foreign('id_situacaodemarcacao')
                ->references('id_situacaodemarcacao')
                ->on('demar_situacaodemarcacao');

            $table->foreign('id_trechodemarcacao')
                ->references('id_trechodemarcacao')
                ->on('demar_trechodemarcacao');

        });

        //Registros de Tipo Demarcação
        DB::table('demar_tipodemarcacao')->insert(
            [
                [
                    'tipodemarcacao' => 'Área da União',
                ],
                [
                    'tipodemarcacao' => 'LPM - Linha do Preamar Média',
                ],
                [
                    'tipodemarcacao' => 'LLTM - Linha Limite de Terrenos de Marinha',
                ]
            ]);

        //Registros de Situação Demarcação
        DB::table('demar_situacaodemarcacao')->insert(
            [
                [
                    'situacaodemarcacao' => 'Demarcada',
                ],
                [
                    'situacaodemarcacao' => 'Homologada',
                ]
            ]);

        //Registros de Trecho Demarcação
        DB::table('demar_trechodemarcacao')->insert(
            [
                [
                    'trechodemarcacao' => 'Não se aplica',
                ],
                [
                    'trechodemarcacao' => 'A definir',
                ]
            ]);

        //Permissões
        DB::table('permissao')->insert(
            [
                [
                    'permissao' => 'DEMARCACAO_DEMARCACAO_CADASTRAR',
                    'descricao' => 'Permite ao usuário gerenciar demarcações no módulo Demarcação'
                ]
            ]);

        DB::table('geo_camada')->insert(
            [
                [
                    'titulo' => 'Demarcações',
                    'rotulo' => 'Demarcação',
                    'tabelaReferencia' => 'demar_demarcacao',
                    'colunaIdReferencia' => 'id_demarcacao',
                    'colunaTituloReferencia' => 'processo',
                    'colunaSubTituloReferencia' => 'subtrecho',
                    'cor' => 'blue',
                    'rotaFrontEnd' => '/demarcacao/[id]'
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
        Schema::dropIfExists('demar_demarcacao');
        Schema::dropIfExists('demar_trechodemarcacao');
        Schema::dropIfExists('demar_situacaodemarcacao');
        Schema::dropIfExists('demar_tipodemarcacao');

        // limpando as permissões...
        $permissao = DB::table('permissao')->where('permissao', 'DEMARCACAO_DEMARCACAO_CADASTRAR')->first();
        if(@$permissao->id) {
            DB::table('usuariopermissao')->where('idPermissao', '=', $permissao->id)->delete();
        }
        DB::table('permissao')->where('permissao', '=', 'DEMARCACAO_DEMARCACAO_CADASTRAR')->delete();

        // limpando as geo referencias
        $camada = DB::table('geo_camada')->where('titulo', 'Demarcações')->first();
        if(@$camada->id) {
            DB::table('geo_referencia')->where('idCamada', $camada->id)->delete();
            // excluindo a geo camada
            DB::table('geo_camada')->where('id', $camada->id)->delete();
        }




    }
}
