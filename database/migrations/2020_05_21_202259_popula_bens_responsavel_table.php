<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Modules\Patrimonio\Entities\PatrimonioResponsavelLegado;
use Modules\Patrimonio\Entities\BensPatrimonio;
use App\User;

class PopulaBensResponsavelTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $legado = PatrimonioResponsavelLegado::get();
        foreach($legado as $p){
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
        //
    }
}
