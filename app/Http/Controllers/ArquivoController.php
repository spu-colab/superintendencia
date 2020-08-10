<?php

namespace App\Http\Controllers;

use App\Arquivo;
use App\Http\Requests\ArquivoRequest;
use Tymon\JWTAuth\Facades\JWTAuth;

class ArquivoController extends Controller
{

    /**
     * TODO     - criar ArquivoPolicy com as regras de autorizacao
     *          - criar permissao para cada disco/diretorio
     */

    public function listar(ArquivoRequest $request) {
        $request->validated();

        $files = Arquivo::all();
        return response()->json($files);
    }
    
    public function upload(ArquivoRequest $request) {
        #$file = $request->file("arquivo");
        #return response()->json($file->getExtension());

        $rules = $request->rules();
        $rules['arquivo'] = "required|" . Arquivo::getRegrasValidacao($request->disco, $request->diretorio);
        $request->validate($rules);

        $parametros = [
            "disco" => $request->disco,
            "diretorio" => $request->diretorio
        ];

        $file = $request->file("arquivo");
        $path = $file->store($parametros["diretorio"]);
        #/*
        $arquivo = new Arquivo();
        
        $arquivo->disco = $parametros["disco"];
        $arquivo->diretorio = $parametros["diretorio"];
        $arquivo->nome = $file->getClientOriginalName();

        $path_exploded = explode(DIRECTORY_SEPARATOR, $path);
        $arquivo->nome_real = end($path_exploded);

        $arquivo->caminho_absoluto = $path;
        $arquivo->mime = $file->getMimeType();
        $arquivo->tamanho = $file->getSize();
        $arquivo->idUsuarioCriacao = JWTAuth::user()->id;
        $arquivo->save();
        return $arquivo;
        # */
    }

}
