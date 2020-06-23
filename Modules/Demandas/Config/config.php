<?php

use App\Permissao;

return [
    'name' => 'Demandas',

    'menu' => [
        "rotulo" => 'Judiciais e Controle',
        "icone" => 'gavel',
        "rota" => '/nujuc',
        "model" => true,
        "submenu" => [
            [
                "rotulo" => 'Demandas',
                // "icone" => 'assignment',
                "rota" => '/demanda',
            ],
            [
                "rotulo" => 'Procedimentos',
                // "icone" => 'account_balance',
                "rota" => '/procedimento',
            ],
            [
                "rotulo" => 'Demandantes',
                // "icone" => 'record_voice_over',
                "rota" => '/demandante',
            ],
            [
                "rotulo" => 'Órgãos',
                // "icone" => 'business',
                "rota" => '/orgao',
            ],
            [
                "rotulo" => 'Relatórios',
                // "icone" => 'menu',
                "rota" => '/nujuc',
            ]
        ]
    ],
];
