<?php

namespace App\Http\Controllers;

use App\GeoCamada;

use Illuminate\Http\Request;

class GeoController extends Controller
{
    
    public function listarCamadas() {
        return GeoCamada::orderBy('titulo')->get();
    }



}
