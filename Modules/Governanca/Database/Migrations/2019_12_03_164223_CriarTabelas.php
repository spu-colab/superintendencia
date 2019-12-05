<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CriarTabelas extends Migration
{

    private $prefixo = "govern_";

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {

        $prefixo = $this->prefixo;

        // Planejamento Estratégico
        Schema::create($prefixo . "planejamentoestrategico", function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->char('titulo', 100);
            $table->date('dataInicio');
            $table->date('dataFim');
            $table->timestamps();
        });

        // Meta (Grande Meta SPU)
        Schema::create($prefixo . "meta", function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idplanejamentoestrategico');
            $table->char('titulo', 100);
            $table->timestamps();
        });
        Schema::table($prefixo . "meta", function (Blueprint $table) {
            $table->foreign('idplanejamentoestrategico')->references('id')->on($this->prefixo . 'planejamentoestrategico');
        });


        // Unidade de Medida
        Schema::create($prefixo . "unidademedida", function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->char('titulo', 100);
            $table->timestamps();
        });

        // Indicador
        Schema::create($prefixo . "indicador", function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idunidademedida');
            $table->char('titulo', 100);
            $table->timestamps();
        });
        Schema::table($prefixo . "indicador", function (Blueprint $table) {
            $table->foreign('idunidademedida')->references('id')->on($this->prefixo . 'unidademedida');
        });

        // Meta Específica (Dicionário de Metas)
        Schema::create($prefixo . "metaespecifica", function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idmeta');
            $table->unsignedBigInteger('idindicador');
            $table->char('titulo', 100);
            $table->timestamps();
        });
        Schema::table($prefixo . "metaespecifica", function (Blueprint $table) {
            $table->foreign('idmeta')->references('id')->on($this->prefixo . 'meta');
            $table->foreign('idindicador')->references('id')->on($this->prefixo . 'indicador');
        });

        // Meta Específica Unidade
        Schema::create($prefixo . "metaespecificaunidade", function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idmetaespecifica');
            $table->unsignedInteger('iddivisaoorganograma');
            $table->unsignedInteger('idusuarioresponsavel');
            $table->timestamps();
        });
        Schema::table($prefixo . "metaespecificaunidade", function (Blueprint $table) {
            $table->foreign('idmetaespecifica')->references('id')->on($this->prefixo . 'metaespecifica');
            $table->foreign('iddivisaoorganograma')->references('id')->on('divisaoorganograma');
            $table->foreign('idusuarioresponsavel')->references('id')->on('users');
        });

        // Período Avaliação
        Schema::create($prefixo . "periodoavaliacao", function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idplanejamentoestrategico');
            $table->char('titulo', 100);
            $table->date('dataInicio');
            $table->date('dataFim');
            $table->date('dataInicioCaptacao');
            $table->date('dataFimCaptacao');
            $table->timestamps();
        });
        Schema::table($prefixo . "periodoavaliacao", function (Blueprint $table) {
            $table->foreign('idplanejamentoestrategico')->references('id')->on($this->prefixo . 'planejamentoestrategico');
        });

        // Avaliação
        Schema::create($prefixo . "avaliacao", function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('idperiodoavaliacao');
            $table->unsignedBigInteger('idmetaespecificaunidade');
            $table->decimal('previsto', 14, 2);
            $table->decimal('realizado', 14, 2);            
            $table->timestamps();
        });
        Schema::table($prefixo . "avaliacao", function (Blueprint $table) {
            $table->foreign('idperiodoavaliacao')->references('id')->on($this->prefixo . 'periodoavaliacao');
            $table->foreign('idmetaespecificaunidade')->references('id')->on($this->prefixo . 'metaespecificaunidade');
        });


    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        $prefixo = $this->prefixo;
        Schema::dropIfExists($this->prefixo . "avaliacao");
        Schema::dropIfExists($this->prefixo . "periodoavaliacao");
        Schema::dropIfExists($this->prefixo . "metaespecificaunidade");
        Schema::dropIfExists($this->prefixo . "metaespecifica");
        Schema::dropIfExists($this->prefixo . "indicador");
        Schema::dropIfExists($this->prefixo . "unidademedida");
        Schema::dropIfExists($this->prefixo . "meta");
        Schema::dropIfExists($this->prefixo . "planejamentoestrategico");
    }
}
