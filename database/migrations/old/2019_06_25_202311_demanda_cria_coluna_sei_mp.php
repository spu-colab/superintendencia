<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class DemandaCriaColunaSeiMp extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('demanda', function (Blueprint $table) {
            $table->boolean('seiMP')->after('nupSEI')->nullable()->default(false);
        });

        DB::table('demanda')->update(['seiMP' => true]);

        Schema::table('demanda', function (Blueprint $table) {
            $table->boolean('seiMP')->nullable(false)->change();
        });

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('demanda', function (Blueprint $table) {
            $table->dropColumn('seiMP');
        });
    }
}
