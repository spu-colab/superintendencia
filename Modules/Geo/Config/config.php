<?php

use App\Permissao;

return [
    'name' => 'Geo',
    'menu' => [
        "rotulo" => 'Geo Informação',
        "icone" => 'map', 
        'submenu' => [
            [
                'rotulo' => "Visualizador",
                "rota" => '/geo/visualizador',
            ],
            [
                'rotulo' => "Camadas",
                "rota" => '/geo/camadas',
                'permissoes' => [
                    Permissao::GEO_CAMADA_CADASTRAR
                ],
            ],
        ]
    ]
];
