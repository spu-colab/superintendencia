<?php

return [
    'name' => 'Patrimonio',
    'menu' => [
        "rotulo" => 'Bens Patrimoniais',
        "icone" => 'menu',         
        "model" => true,
        "submenu" => [
            [
                "rotulo" => 'Itens',
                // "icone" => 'laptop',
                "rota" => '/patrimonio'
            ],
            [
                "rotulo" => 'Salas e Locais',
                // "icone" => 'domain', 
                "rota" => '/locais'
            ]
        ]
    ]
];
