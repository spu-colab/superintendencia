<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBensLevantamentoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bens_levantamento', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->char('descricao',50);
            $table->timestamps();
        });
        DB::table('bens_levantamento')->insert(
            [
                [
                    'id' => 1,
                    'descricao' => 'OK',
                    'created_at' => date("Y-m-d H:i:s"),
                    'updated_at' => date("Y-m-d H:i:s")
                ],
                [
                    'id' => 2,
                    'descricao' => 'N.Localizado',
                    'created_at' => date("Y-m-d H:i:s"),
                    'updated_at' => date("Y-m-d H:i:s")
                ],
                [
                    'id' => 3,
                    'descricao' => 'Furtado',
                    'created_at' => date("Y-m-d H:i:s"),
                    'updated_at' => date("Y-m-d H:i:s")
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
        Schema::dropIfExists('bens_levantamento');
    }
}
