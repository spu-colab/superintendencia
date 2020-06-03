<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBensConservacaoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bens_conservacao', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->char('descricao',50);
            $table->timestamps();
        });
        DB::table('bens_conservacao')->insert(
            [
                [
                    'id' => 1,
                    'descricao' => 'Em bom estado',
                    'created_at' => date("Y-m-d H:i:s"),
                    'updated_at' => date("Y-m-d H:i:s")
                ],
                [
                    'id' => 2,
                    'descricao' => 'Em mau estado',
                    'created_at' => date("Y-m-d H:i:s"),
                    'updated_at' => date("Y-m-d H:i:s")
                ]
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
        Schema::dropIfExists('bens_conservacao');  
    }
}
