<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddColunasDivisaoorganogramaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('divisaoorganograma', function (Blueprint $table) {
            $table->softDeletes('deleted_at', 0)->after('updated_at')->default(null);
            $table->char('origem', 50)->after('deleted_at')->default('spu-sc');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('divisaoorganograma', function (Blueprint $table) {
            $table->dropColumn('deleted_at');
            $table->dropColumn('origem');
        });
    }
}
