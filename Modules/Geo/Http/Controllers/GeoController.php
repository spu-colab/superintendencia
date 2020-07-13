<?php

namespace Modules\Geo\Http\Controllers;

use App\Http\Controllers\Controller;
use Grimzy\LaravelMysqlSpatial\Types\GeometryCollection;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Modules\Geo\Entities\GeoCamada;
use Modules\Geo\Entities\GeoReferencia;
use Modules\Geo\Http\Requests\GeoCamadaRequest;
use Nwidart\Modules\Json;
use PHPUnit\Util\Json as UtilJson;

class GeoController extends Controller
{
    
    public function listarCamadas(Request $request) {

        $consulta = GeoCamada::selectRaw("id, titulo, rotulo, ativa, estatica, propriedadeTitulo, propriedadeSubTitulo, rotaFrontEnd, cor, idUsuarioCriacao, idUsuarioAlteracao, created_at, updated_at");

        if($request->search) {
            $consulta->where("titulo", "LIKE",  "%".strtolower($request->search)."%");
            // $consulta = GeoCamada::where("titulo", "LIKE",  "%".strtolower($request->search)."%");
        } 
        /*
        else {
            $consulta = GeoCamada::where("titulo", "!=",  'null');
        }
        */
    
        $consulta = $consulta->orderBy(
            $request->order ?? 'titulo', 
            $request->ascending === 'false' ? 'desc' : 'asc',
            SORT_NATURAL|SORT_FLAG_CASE
        );

        $request->per_page = $request->per_page ?? 10;

        $resultado = $request->per_page > 0 
            ? $consulta->paginate($request->per_page)
            : $consulta->get();

        return response()->json($resultado);
        // return GeoCamada::orderBy('titulo')->get();
    }

    public function salvarCamada(GeoCamadaRequest $request) {

        $request->validated();
        
        $usuario = Auth::user();
        if($request->id) {
            $geoCamada = GeoCamada::findOrFail($request->id);
            $geoCamada->idUsuarioAlteracao = $usuario->id;
            $this->authorize('update', $geoCamada);
        } else {
            $geoCamada = new GeoCamada;
            $geoCamada->idUsuarioCriacao = $usuario->id;
            $this->authorize('create', $geoCamada);
        }
        $geoCamada->titulo = $request->titulo;
        $geoCamada->rotulo = $request->rotulo;
        $geoCamada->ativa = $request->ativa;
        $geoCamada->estatica = $request->estatica;
        $geoCamada->tabelaReferencia = $request->tabelaReferencia;
        $geoCamada->colunaIdReferencia = $request->colunaIdReferencia;
        $geoCamada->colunaTituloReferencia = $request->colunaTituloReferencia;
        $geoCamada->colunaSubTituloReferencia = $request->colunaSubTituloReferencia;
        $geoCamada->cor = $request->cor;
        $geoCamada->rotaFrontEnd = $request->rotaFrontEnd;
        $geoCamada->geojson = json_decode(stripslashes($request->geojson));
        
        $geoCamada = $geoCamada->save();
        return response()->json($geoCamada);

    }

    public function obterCamada(GeoCamada $geoCamada) {
        if(!$geoCamada->estatica) {
            $geoCamada->geojson = $this->montarGeoJson($geoCamada);
        }
        $geoCamada["propriedadeTitulo"] = "titulo";
        return $geoCamada;
    }

    public function obterGeojson(GeoCamada $geoCamada) {
        if(!$geoCamada->estatica) {
            $geoCamada->geojson = $this->montarGeoJson($geoCamada);
        }
        return response()->json($geoCamada->geojson);
    }

    private function montarGeoJson(GeoCamada $geoCamada) {
        $geojson = ["type" => "FeatureCollection", "crs" => "EPSG:3857"];
        $referencias = $this->listarReferenciasPorCamada($geoCamada->id);

        $features = [];
        foreach ($referencias as $r => $geoReferencia) {
            
            $feature = array();
            $feature["idReferenciado"] = $geoReferencia->idReferenciado;
            $feature["type"] = "Feature";            
            
            $geometry = array();
            $geometry["type"] = "MultiPolygon";
            $geometry["coordinates"] = array();
            #/*
            foreach($geoReferencia->poligonais->getGeometries() as $geometry2) {
                $geometry["coordinates"][] = $geometry2->jsonSerialize()->getCoordinates();
            }
            # */
            $feature["properties"] = $this->montarPropriedades($geoCamada, $geoReferencia);
            $feature["geometry"] = $geometry;
            $features[] = $feature;
        }
        $geojson["features"] = $features;

        return $geojson;
    }

    private function montarPropriedades(GeoCamada $geoCamada, GeoReferencia $geoReferencia) {
        $propriedades = array(
            "rotulo" => $geoReferencia["rotulo"],
            "titulo" => $geoReferencia["titulo"],
            "subtitulo" => $geoReferencia["subtitulo"]);
        return $propriedades;
    }

    public function obterReferencia($tabelaReferenciada, $idReferenciado) {
        $camada = GeoCamada::where('tabelaReferencia', $tabelaReferenciada)->first();

        if($camada == null) {
            \abort(404, 'Geo camada não encontrada');
        }

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

        $camada = GeoCamada::findOrFail($idCamada);
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
