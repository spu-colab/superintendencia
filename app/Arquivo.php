<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Arquivo extends Model
{
    public const TABLE_NAME = "arquivo";

    public const DISCO_PUBLIC = "public";
    public const DIRETORIO_GEO = "static/geo";

    public const DISCOS = [
        Arquivo::DISCO_PUBLIC => [
            Arquivo::DIRETORIO_GEO => [
                'mimes' => "text/plain,application/octet-stream,application/json",
                // 'extensoes' => ".geojson",
                'tamanhoMaximo' => "204800" //200MB
            ]
        ]
    ];

    /*
    public const DIRETORIOS = [
        Arquivo::DIRETORIO_GEO
    ];
    */

    protected $table = Arquivo::TABLE_NAME;

    
    protected $fillable = ['nome', 'arquivo', 'caminho_absoluto', 'caminho_relativo', 'mime', 'tamanho'];

    public static function getRegrasValidacao($disco, $diretorio) {
        $regras = [];
        if(@isset(Arquivo::DISCOS[$disco][$diretorio]['mimes'])) {
            array_push($regras, "mimetypes:" . Arquivo::DISCOS[$disco][$diretorio]['mimes']);
        }
        if(@isset(Arquivo::DISCOS[$disco][$diretorio]['extensoes'])) {
            array_push($regras, "mimes:" . Arquivo::DISCOS[$disco][$diretorio]['extensoes']);
        }
        if(@isset(Arquivo::DISCOS[$disco][$diretorio]['tamanhoMaximo'])) {
            array_push($regras, "max:" . Arquivo::DISCOS[$disco][$diretorio]['tamanhoMaximo']);
        }
        return implode("|", $regras);
    }
    
}
