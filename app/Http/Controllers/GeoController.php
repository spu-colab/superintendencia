<?php

namespace App\Http\Controllers;

use App\GeoCamada;
use App\GeoReferencia;

use Illuminate\Http\Request;

class GeoController extends Controller
{
    
    public function listarCamadas() {
        return GeoCamada::orderBy('titulo')->get();
    }

    public function listarReferenciasPorCamada($idCamada) {
        return GeoReferencia::where('idCamada', '=', $idCamada)->get();
    }



}
