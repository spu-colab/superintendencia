<?php

use App\Permissao;

return [
    'name' => 'Atendimento',
    'menu' => [
        "rotulo" =>  'Atendimento',
        "icone" => 'how_to_reg', 
        "rota" => '/atendimento',
        "permissoes" => [
            Permissao::ATENDIMENTO_ATENDIMENTO_CRIAR_EMAIL,
            Permissao::ATENDIMENTO_ATENDIMENTO_CRIAR_PRESENCIAL,
            Permissao::ATENDIMENTO_ATENDIMENTO_CRIAR_TELEFONICO,
            Permissao::ATENDIMENTO_COMENTARIO_CRIAR
        ]
    ]
];
