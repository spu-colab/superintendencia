<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class PopulaSetorDivisaoOrganograma extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::table('spusc-admin.setordivisaoorganograma')->insert(
            [
                ['idSetor'=>'5','idDivisaoOrganograma'=>'1'],
                ['idSetor'=>'23','idDivisaoOrganograma'=>'13'],
                ['idSetor'=>'22','idDivisaoOrganograma'=>'16'],
                ['idSetor'=>'20','idDivisaoOrganograma'=>'4'],
                ['idSetor'=>'27','idDivisaoOrganograma'=>'9'],
                ['idSetor'=>'29','idDivisaoOrganograma'=>'11'],
                ['idSetor'=>'18','idDivisaoOrganograma'=>'2'],
                ['idSetor'=>'28','idDivisaoOrganograma'=>'17'],
                ['idSetor'=>'21','idDivisaoOrganograma'=>'14'],
                ['idSetor'=>'25','idDivisaoOrganograma'=>'15'],
                ['idSetor'=>'24','idDivisaoOrganograma'=>'7'],
                ['idSetor'=>'19','idDivisaoOrganograma'=>'6'],
                ['idSetor'=>'26','idDivisaoOrganograma'=>'12']               
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
