<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateSetor extends Migration
{

    const ENV_DB_VAR = "DB_DATABASE_ADMIN";

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',23)->update(['descricao' =>'SPU-SC-COORD']);
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',5)->update(['descricao' =>'SPU-SC']);
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',22)->update(['descricao' =>'SPU-SC-NUDEM']);
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',20)->update(['descricao' =>'SPU-SC-NUDEPU']);
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',27)->update(['descricao' =>'SPU-SC-NUFIS']);
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',29)->update(['descricao' =>'SPU-SC-NUGEO']);
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',18)->update(['descricao' =>'SPU-SC-NUGES']);
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',28)->update(['descricao' =>'SPU-SC-NUINC']);
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',21)->update(['descricao' =>'SPU-SC-NUJUC']);
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',25)->update(['descricao' =>'SPU-SC-NUPRIV']);
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',24)->update(['descricao' =>'SPU-SC-NUREF']);
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',19)->update(['descricao' =>'SPU-SC-NUREP']);
        DB::table(\env($this::ENV_DB_VAR).'.setor')->where('codigo',26)->update(['descricao' =>'SPU-SC-NUSUC']);
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
