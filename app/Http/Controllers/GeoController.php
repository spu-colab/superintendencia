<?php

namespace App\Http\Controllers;

use App\GeoCamada;
use App\GeoReferencia;

use Grimzy\LaravelMysqlSpatial\Types\LineString;
use Grimzy\LaravelMysqlSpatial\Types\MultiPolygon;
use Grimzy\LaravelMysqlSpatial\Types\Point;
use Grimzy\LaravelMysqlSpatial\Types\Polygon;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class GeoController extends Controller
{
    
    public function listarCamadas() {
        return GeoCamada::orderBy('titulo')->get();
    }

    public function obterCamada($id) {
        return GeoCamada::findOrFail($id)->get();
    }

    public function listarReferenciasPorCamada($idCamada) {

        $camada = $this->obterCamada($idCamada);
        $camada = $camada[0];

        $referencias = GeoReferencia::where('idCamada', '=', $idCamada)->get();

        
        foreach ($referencias as $r => $referencia) {
             $metaDadosReferencia = DB::table($camada->tabelaReferencia)
                ->select($camada->colunaTituloReferencia, $camada->colunaSubTituloReferencia)
                ->where($camada->colunaIdReferencia, '=', $referencia->idReferenciado)
                ->first();

            $referencias[$r]['rotulo'] = $camada->rotulo;
            $referencias[$r]['titulo'] = $metaDadosReferencia->{$camada->colunaTituloReferencia};
            $referencias[$r]['subtitulo'] = $metaDadosReferencia->{$camada->colunaSubTituloReferencia};
        }
        

        return $referencias;
    }

    public function salvarReferencia(Request $request) {
        // return $request;
        $request_vars = $request['geo_referencia'];
        extract($request_vars);

        $geoReferencia = GeoReferencia::where([
            ['idCamada', '=', $idCamada],
            ['idReferenciado', '=', $idReferenciado],
        ])->first();

        if(@!$geoReferencia->id) {
            $geoReferencia = new GeoReferencia();
            $geoReferencia->idCamada = $idCamada;
            $geoReferencia->idReferenciado = $idReferenciado;
        }
        $poligonosDaGeometria = [];
        foreach ($geometrias as $geometria) {
            $pontosDaGeometria = [];
            foreach($geometria as $ponto) {
                $ponto = explode(',', $ponto);
                $lat = $ponto[1];
                $lng = $ponto[0];
                $ponto = new Point($lat, $lng);
                $pontosDaGeometria[] = $ponto;
            }
            $poligono = new Polygon([new LineString($pontosDaGeometria)]);
            $poligonosDaGeometria[] = $poligono;
        }
        $multiPoligono = new MultiPolygon($poligonosDaGeometria);
        $geoReferencia->poligonais = $multiPoligono;
        $geoReferencia->idUsuarioCriacao = Auth::id();
        $geoReferencia->idUsuarioAlteracao = Auth::id();

        // $return = $geoReferencia->poligonais;
        // $return = $request['geo_referencia']['geometrias'];
        $return = $geoReferencia->id ? $geoReferencia->update() : $geoReferencia->save();
        return response()->json($return);
        
    }

}
