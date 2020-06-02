<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class PopulaBensTermoDesfazimentoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::table('bens_termo_desfazimento')->insert(
            [
                ['id'=>1,'idUser'=>15,'created_at'=> date("Y-m-d H:i:s"),'concluido_em'=> date("Y-m-d H:i:s"),'destino'=>'DNIT de Tubarão','processo'=>'DENIT TUBARÃO','oficio'=>'00319/17 DENIT 09/03/17','despacho'=>NULL,'observacoes'=>'Transferência de materiais para Unidade Ferroviária de Tubarão'],
                ['id'=>2,'idUser'=>15,'created_at'=> date("Y-m-d H:i:s"),'concluido_em'=> date("Y-m-d H:i:s"),'destino'=>'Diversos','processo'=>'PM Imaruí e outros','oficio'=>NULL,'despacho'=>NULL,'observacoes'=>'PM Imaruí 04972.200186/2015-53 e SANF'],
                ['id'=>3,'idUser'=>15,'created_at'=> date("Y-m-d H:i:s"),'concluido_em'=> date("Y-m-d H:i:s"),'destino'=>'PM Paulo Lopes','processo'=>'04972.000872/2017-98','oficio'=>'186/2017','despacho'=>'3790875','observacoes'=>NULL],
                ['id'=>4,'idUser'=>15,'created_at'=> date("Y-m-d H:i:s"),'concluido_em'=> date("Y-m-d H:i:s"),'destino'=>'PM São Joaquim','processo'=>'04972.000870/2017-07','oficio'=>'070/2017','despacho'=>'3791069','observacoes'=>NULL],
                ['id'=>5,'idUser'=>15,'created_at'=> date("Y-m-d H:i:s"),'concluido_em'=>NULL,'destino'=>NULL,'processo'=>NULL,'oficio'=>NULL,'despacho'=>NULL,'observacoes'=>NULL]
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
            //
    }
}
