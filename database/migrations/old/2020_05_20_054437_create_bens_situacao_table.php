<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBensSituacaoTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
            Schema::create('bens_situacao', function (Blueprint $table) {
                $table->bigIncrements('id');
                $table->char('descricao',50);
                $table->timestamps();
            });
            DB::table('bens_situacao')->insert(
                [
                    [
                        'id' => 1,
                        'descricao' => 'Em uso',
                        'created_at' => date("Y-m-d H:i:s"),
                        'updated_at' => date("Y-m-d H:i:s")
                    ],
                    [
                        'id' => 2,
                        'descricao' => 'Desfazimento',
                        'created_at' => date("Y-m-d H:i:s"),
                        'updated_at' => date("Y-m-d H:i:s")
                    ],                
                    [
                        'id' => 3,
                        'descricao' => 'Uso geral',
                        'created_at' => date("Y-m-d H:i:s"),
                        'updated_at' => date("Y-m-d H:i:s")
                    ],
                    [
                        'id' => 4,
                        'descricao' => 'Disponível',
                        'created_at' => date("Y-m-d H:i:s"),
                        'updated_at' => date("Y-m-d H:i:s")
                    ],
                    [
                        'id' => 9,
                        'descricao' => 'Descartado',
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
        Schema::dropIfExists('bens_situacao');
    }
}
