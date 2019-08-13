<?php

namespace App\Http\Controllers;

use App\GeoCamada;
use App\GeoReferencia;

use Illuminate\Http\Request;
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
             $tituloReferencia = DB::table($camada->tabelaReferencia)
                ->select($camada->colunaTituloReferencia)
                ->where($camada->colunaIdReferencia, '=', $referencia->idReferenciado)
                ->first();

            $referencias[$r]['titulo'] = $tituloReferencia->{$camada->colunaTituloReferencia};
        }
        

        return $referencias;
    }



}
