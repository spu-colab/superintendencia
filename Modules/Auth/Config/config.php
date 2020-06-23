<?php

use App\Permissao;

return [
    'name' => 'Auth',
    'menu' => [
        "rotulo" => 'Controle de Acesso',
        "icone" => "build",
        'submenu' => [
            [
                'rotulo' => "Usuários",
                "rota" => '/permissao',
                'permissoes' => [
                    Permissao::AUTH_USUARIO_CADASTRAR
                ],
            ],
            [
                'rotulo' => "Permissões",
                "rota" => '/perfil',
                'permissoes' => [
                    Permissao::AUTH_PERMISSAO_CADASTRAR
                ],
            ],
            [
                'rotulo' => "Organograma",
                "rota" => '/organograma',
                'permissoes' => [
                    Permissao::AUTH_ORGANOGRAMA_CADASTRAR
                ],
            ]
        ]
    ]
];
