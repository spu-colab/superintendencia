<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class DivisaoOrganogramaCriaColunaSnSuperintendencia extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('divisaoorganograma', function (Blueprint $table) {
            $table->boolean('snSuperintendencia')->after('sigla')->default(false);
        });

        DB::table('distribuicaodemanda')
            ->where('assignable_type', 'App\DivisaoOrganograma')
            ->update(['assignable_type' => 'Modules\Auth\Entities\DivisaoOrganograma']);

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('divisaoorganograma', function (Blueprint $table) {
            $table->dropColumn('snSuperintendencia');
        });

        DB::table('distribuicaodemanda')
            ->where('assignable_type', 'Modules\Auth\Entities\DivisaoOrganograma')
            ->update(['assignable_type' => 'App\DivisaoOrganograma']);
    }
}
