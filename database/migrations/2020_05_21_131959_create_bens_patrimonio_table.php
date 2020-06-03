<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

use Modules\Patrimonio\Entities\PatrimonioLegado;
use Modules\Patrimonio\Entities\PatrimonioResponsavelLegado;
use Modules\Patrimonio\Entities\BensPatrimonio;
use App\User;

class CreateBensPatrimonioTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bens_patrimonio', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->integer('codigo')->unique();
            $table->text('descricao');
            $table->decimal('preco', 8, 2);
            $table->date('garantia')->nullable();
            $table->bigInteger('idSala')->unsigned();
            $table->bigInteger('idCategoria')->unsigned();
            $table->bigInteger('idSituacao')->unsigned()->default(4);
            $table->bigInteger('idDesfazimento')->unsigned()->nullable();
            $table->bigInteger('idConservacao')->unsigned()->default(1);
            $table->bigInteger('idLevantamento')->unsigned()->default(1);
            $table->unsignedInteger('idUser');
            $table->timestamps();
            $table->foreign('idUser')->references('id')->on('users');
            $table->foreign('idSala')->references('id')->on('bens_sala');
            $table->foreign('idCategoria')->references('id')->on('bens_categoria');
            $table->foreign('idSituacao')->references('id')->on('bens_situacao');
            $table->foreign('idDesfazimento')->references('id')->on('bens_termo_desfazimento');
        });

        Schema::create('bens_responsavel', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedInteger('idUserResp');
            $table->bigInteger('idPatrimonio')->unsigned();
            $table->unsignedInteger('idUser');
            $table->timestamps();
            $table->softDeletes();
            $table->foreign('idUserResp')->references('id')->on('users');
            $table->foreign('idUser')->references('id')->on('users');
            $table->foreign('idPatrimonio')->references('id')->on('bens_patrimonio');
        });

        $legado = PatrimonioLegado::get();

        foreach ($legado as $p) {
            // print_r($p->categoria . "\r\n");
            DB::table('bens_patrimonio')->insert(
                [
                    'codigo' => $p->codigo,
                    'descricao' => $p->descricao,
                    'preco' => $p->preco,
                    'idSala' => $p->local,
                    'idCategoria' => $p->categoria,
                    'idSituacao' => $p->situacao,
                    'idDesfazimento' => $p->coddesfaz,
                    'idUser' => 15,
                    'idConservacao' => $p->conserv,
                    'idLevantamento' => $p->levant,
                    'preco' => $p->preco,
                    'created_at' => date("Y-m-d H:i:s")
                ]
            );
        }

        $legado = PatrimonioResponsavelLegado::get();
        foreach ($legado as $p) {
            $deleted_at = $p->situacao == 1 ? null : date("Y-m-d H:i:s");
            $user = User::where('cpf', str_pad($p->tecnicoResp->CPF, 11, "0", STR_PAD_LEFT))->first();
            $patr = BensPatrimonio::where('codigo', $p->bem)->first();
            DB::table('bens_responsavel')->insert(
                [
                    'idUserResp' => $user->id,
                    'idPatrimonio' => $patr->id,
                    'idUser' => 15,
                    'created_at' => date("Y-m-d H:i:s"),
                    'deleted_at' => $deleted_at
                ]
            );
        }
    }
    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('bens_responsavel');
        Schema::dropIfExists('bens_patrimonio');
    }
}
