<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Auth\Entities\DivisaoOrganograma;
class MigraSetorDivisaoorganogramaTable extends Migration
{
    public $setores = array (
        ['sigla'=>'DIGES'],
        ['sigla'=>'SPU-SC'],
        ['sigla'=>'COCAI'],
        ['sigla'=>'CODES'],
        ['sigla'=>'DIREP'],
        ['sigla'=>'PROTOCOLO'],
        ['sigla'=>'SEAPU'],
        ['sigla'=>'ARQUIVO'],
        ['sigla'=>'SEGES'],
        ['sigla'=>'DIRFH'],
        ['sigla'=>'DIINC'],
        ['sigla'=>'DIIUP'],
        ['sigla'=>'SEREP'],
        ['sigla'=>'DIGES/BV'],
        ['sigla'=>'SPU-SC-NUGES'],
        ['sigla'=>'SPU-SC-NUREP'],
        ['sigla'=>'SPU-SC-NUDEPU'],
        ['sigla'=>'SPU-SC-NUJUC'],
        ['sigla'=>'SPU-SC-NUDEM'],
        ['sigla'=>'SPU-SC-COORD'],
        ['sigla'=>'SPU-SC-NUREF'],
        ['sigla'=>'SPU-SC-NUPRIV'],
        ['sigla'=>'SPU-SC-NUSUC'],
        ['sigla'=>'SPU-SC-NUFIS'],
        ['sigla'=>'SPU-SC-NUINC'],
        ['sigla'=>'SPU-SC-NUGEO']
     );

     /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        foreach ($this->setores as $p) {
            
            $divisao = DivisaoOrganograma::where('sigla', $p['sigla'])->first();
            if (!$divisao){
                $deleted_at = date("Y-m-d H:i:s");
                DivisaoOrganograma::insert(
                    [
                        'nome'=> 'Migração da base SPUAdmin '.$p['sigla'],
                        'sigla'=>$p['sigla'],
                        'idDivisaoOrganogramaPai' => 1,
                        'origem'=>'spu-sc-admin',
                        'deleted_at'=>$deleted_at,
                    ]
                );
            }
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DivisaoOrganograma::where('origem', 'spu-sc-admin')->delete();
    }
}
