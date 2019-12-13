<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriarTabelaAtendimentoTipo extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {

        // Atendimento Tipo
        Schema::create('atend_tipo', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->text('tipo');
            $table->timestamps();
        });
        DB::table('atend_tipo')->insert(
            [
                [
                    'id' => 1,
                    'tipo' => 'Presencial'
                ],
                [
                    'id' => 2,
                    'tipo' => 'Telefônico'
                ],                
                [
                    'id' => 3,
                    'tipo' => 'E-mail'
                ],
            ]
        );

        // Atendimento Atendimento
        Schema::create('atend_atendimento', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedInteger('idusuario');
            $table->unsignedBigInteger('idtipo');
            $table->text('atendido', 150);
            $table->text('cpf', 11)->nullable();
            $table->text('email', 150)->nullable();
            $table->dateTime('dataHoraInicio');
            $table->dateTime('dataHoraFim')->nullable();
            $table->timestamps();
            
            $table->foreign('idusuario')->references('id')->on('users');
            $table->foreign('idtipo')->references('id')->on('atend_tipo');
        });

        // Atendimento Comentário
        Schema::create('atend_comentario', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idatendimento');
            $table->unsignedInteger('idusuario');
            $table->text('comentario');
            $table->timestamp('dataHora');
            
            $table->foreign('idusuario')->references('id')->on('users');
            $table->foreign('idatendimento')->references('id')->on('atend_atendimento');

            //
        });

        // Atendimento Assunto
        Schema::create('atend_assunto', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->text('assunto');
            $table->timestamps();
        });
        DB::table('atend_assunto')->insert(
            [
                ['assunto' => 'Geral'],
                ['assunto' => 'Demarcação'],
                ['assunto' => 'Averbação de Transferência'],
                ['assunto' => 'Revisão'],
                ['assunto' => 'Aforamento'],
                ['assunto' => 'TAUS - Termo de Autorização de Uso Sustentável'],
                ['assunto' => 'Isenção de Pagamento das Taxas de Ocupação ou Foro'],
                ['assunto' => 'Unificação/ Desmembramento/ Fracionamento'],
                ['assunto' => 'Inscrição de Ocupação'],
                ['assunto' => 'Permissão de Uso'],
                ['assunto' => 'Reclamação'],
                ['assunto' => 'DARF'],
                ['assunto' => 'Certidão de Provimento'],
                ['assunto' => 'Certidão Negativa de Débito'],
                ['assunto' => 'Cessão de Espaço Aquático'],
                ['assunto' => 'Cópias']
            ]
        );

        // Atendimento AtendimentoAssunto
        Schema::create('atend_atendimento_atend_assunto', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idatendimento');
            $table->unsignedBigInteger('idassunto');
            $table->timestamps();

            $table->foreign('idatendimento')->references('id')->on('atend_atendimento');
            $table->foreign('idassunto')->references('id')->on('atend_assunto');

        });

        DB::table('permissao')->insert(
            [
                [
                    'permissao' => 'ATENDIMENTO_ATENDIMENTO_CRIAR_PRESENCIAL',
                    'descricao' => 'Permite iniciar/salvar/concluir um atendimento presencial'
                ],
                [
                    'permissao' => 'ATENDIMENTO_ATENDIMENTO_CRIAR_TELEFONICO',
                    'descricao' => 'Permite iniciar/salvar/concluir um atendimento telefônico'
                ],
                [
                    'permissao' => 'ATENDIMENTO_ATENDIMENTO_CRIAR_EMAIL',
                    'descricao' => 'Permite iniciar/salvar/concluir um atendimento por e-mail'
                ],
                [
                    'permissao' => 'ATENDIMENTO_COMENTARIO_CRIAR',
                    'descricao' => 'Permite criar um comentário em um atendimento'
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
        Schema::dropIfExists('atend_atendimento_atend_assunto');
        Schema::dropIfExists('atend_assunto');
        Schema::dropIfExists('atend_comentario');
        Schema::dropIfExists('atend_atendimento');
        Schema::dropIfExists('atend_tipo');
    }
}
