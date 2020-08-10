<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Modules\Geo\Entities\GeoCamada;

class GeoDropGeoJsonAddArquivoGeoJson extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table(GeoCamada::TABLE_NAME, function (Blueprint $table) {
            $table->unsignedBigInteger('idArquivoGeo')->after('estatica')->nullable();
            $table->foreign('idArquivoGeo')->references('id')->on('arquivo');

            $table->dropColumn('geojson');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table(GeoCamada::TABLE_NAME, function (Blueprint $table) {
            $table->json('geojson')->after('estatica')->nullable();

            $table->dropForeign('geo_camada_idarquivogeo_foreign');
            $table->dropColumn('idArquivoGeo');
        });
    }
}
