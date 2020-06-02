<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Patrimonio\Entities\PatrimonioLegado;

class PopulaBensPatrimonioTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {

        $legado = PatrimonioLegado::get();

        foreach($legado as $p){
            DB::table('bens_patrimonio')->insert(
                    [
                        'codigo'=>$p->codigo,
                        'descricao'=>$p->descricao,
                        'preco'=>$p->preco,
                        'idSala'=>$p->local,
                        'idCategoria'=>$p->categoria,
                        'idSituacao'=>$p->situacao,
                        'idDesfazimento'=>$p->coddesfaz,
                        'idUser'=> 15,
                        'conservacao'=>$p->conserv,
                        'levantamento'=>$p->levant,
                        'preco'=>$p->preco,
                        'created_at'=> date("Y-m-d H:i:s")
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
        Schema::table('bens_patrimonio', function (Blueprint $table) {
            //
        });
    }
}
