<?php

return [
    'backup' => [
        'origem' => [
            
            'arquivos' => [

                'spu-sc' => [
                    'caminho_origem' => base_path(),
                    'ignorar' => [
                        '/node_modules',
                        '/vendor',
                        '/docs'
                    ]
                ],

                'wordpress' => [
                    'caminho_origem' => base_path() . '/../htdocs/wordpress',
                ],

                'htdocs' => [
                    'caminho_origem' => base_path() . '/../htdocs',
                    'ignorar' => [
                        '/wordpress'
                    ]
                ]
            ],

        ],

        'destino' => env('BACKUP_PATH'),
        
        'idadeMaximaDosArquivosEmDias' => 7
    ],
];

?>