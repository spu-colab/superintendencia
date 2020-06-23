<?php

use App\Permissao;

return [
    'name' => 'Demarcacao',
    'menu' => [
        "rotulo" => 'Demarcação',
        "icone" => 'linear_scale', 
        "rota" => '/demarcacao',
        "permissoes" => [
            Permissao::DEMARCACAO_DEMARCACAO_CADASTRAR
        ],
    ]
];
