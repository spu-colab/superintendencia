<?php

namespace App\Http\Controllers;

use App\GeoCamada;
use App\GeoReferencia;

use Grimzy\LaravelMysqlSpatial\Types\LineString;
// use Grimzy\LaravelMysqlSpatial\Types\MultiPolygon;
use Grimzy\LaravelMysqlSpatial\Types\Point;
use Grimzy\LaravelMysqlSpatial\Types\Polygon;
use Grimzy\LaravelMysqlSpatial\Types\GeometryCollection;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class GeoController extends Controller
{
    
    public function listarCamadas() {
        return GeoCamada::orderBy('titulo')->get();
    }

    public function obterCamada($id) {
        return GeoCamada::findOrFail($id);
    }

    public function obterReferencia($idCamada, $idReferenciado) {
        $camada = $this->obterCamada($idCamada);
        $retorno['camada'] = $camada;
        $referencia['rotulo'] = $camada->rotulo;

        $referencia = GeoReferencia::where([
            ['idCamada', '=', $camada->id],
            ['idReferenciado', '=', $idReferenciado]
        ])->first();
        $retorno['referencia'] = $referencia;

        if(@$referencia->idReferenciado) {
            $metaDadosReferencia = DB::table($camada->tabelaReferencia)
                ->select($camada->colunaTituloReferencia, $camada->colunaSubTituloReferencia)
                ->where($camada->colunaIdReferencia, '=', $referencia->idReferenciado)
                ->first();
    
            $referencia['titulo'] = $metaDadosReferencia->{$camada->colunaTituloReferencia};
            $referencia['subtitulo'] = $metaDadosReferencia->{$camada->colunaSubTituloReferencia};
        }

        return \response()->json($retorno);
    }

    public function listarReferenciasPorCamada($idCamada) {

        $camada = $this->obterCamada($idCamada);
        // $camada = $camada[0];

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
        // return response()->json($request);
        // $request_vars = $request['geo_referencia'];
        // extract($request_vars);
        $idCamada = $request['idCamada'];
        $idReferenciado = $request['idReferenciado'];
        $geoJson = $request['geoJson'];

        $geoReferencia = GeoReferencia::where([
            ['idCamada', '=', $idCamada],
            ['idReferenciado', '=', $idReferenciado],
        ])->first();

        if(@!$geoReferencia->id) {
            $geoReferencia = new GeoReferencia();
            $geoReferencia->idCamada = $idCamada;
            $geoReferencia->idReferenciado = $idReferenciado;
        }

        /*
        $poligonosDaGeometria = [];
        // return \response()->json($geometrias);
        $pontosFalhos = 0;
        foreach ($geometrias as $geometria) {
            $pontosDaGeometria = [];
            foreach($geometria as $ponto) {
                $ponto = explode(',', $ponto);
                if(!\is_array($ponto) || @\sizeof($ponto < 2)) {
                    $pontosFalhos++;
                    continue;
                }
                $lat = $ponto[1];
                $lng = $ponto[0];
                $ponto = new Point($lat, $lng);
                $pontosDaGeometria[] = $ponto;
            }
            $poligono = null; //new Polygon([new LineString($pontosDaGeometria)]);
            $poligonosDaGeometria[] = $poligono;
        }
        return \response()->json($pontosFalhos);
        // $multiPoligono = new MultiPolygon($poligonosDaGeometria);
        */
        $jsonEncoded = \json_encode($geoJson);
        // return response()->json($jsonEncoded);
        $geometrias = GeometryCollection::fromJson($jsonEncoded);
        // return response()->json($geometrias);
        $geoReferencia->poligonais = $geometrias;
        $geoReferencia->idUsuarioCriacao = Auth::id();
        $geoReferencia->idUsuarioAlteracao = Auth::id();

        // $return = $geoReferencia->poligonais;
        // $return = $request['geo_referencia']['geometrias'];
        $return = $geoReferencia->id ? $geoReferencia->update() : $geoReferencia->save();
        return response()->json($return);
        
    }

}
