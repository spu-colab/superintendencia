<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset=utf-8>
        <meta name=viewport content="width=device-width,initial-scale=1">
        <!-- <link href="{{ asset('css/app.css') }}" rel="stylesheet"> -->
        <title>SPU-SC</title>
    </head>
    <body>

        @php
            $colspan_total = 5;
            $colspan_1 = 7;
            $colspan_2 = 5;
        @endphp

        <table class="demanda" cellspacing="0">
            <tbody>
        
        @foreach ($demandas['divisoesOrganogramas'] as $divisaoOrganograma)
            @if(!empty($divisaoOrganograma['demandas']) && sizeof($divisaoOrganograma['demandas']) > 0)
                <tr class="grupo_distribuicao">
                    <td colspan="{{ $colspan_total }}"><h2>{{ $divisaoOrganograma->sigla . " - " . $divisaoOrganograma->nome }}</h2></td>
                </tr>

                <tr class="cabecalho">
                    <td>NUP SEI / Documento Externo</td>
                    <td>Procedimento Externo</td>
                    <td>Demandante</td>
                    <td>Resumo / Situação</td>
                    <td>Prazo</td>
                </tr>

                @foreach($divisaoOrganograma['demandas'] as $demanda)
                <tr class="demanda">
                    <td>
                        {{ $demanda->nupSEI }}</br>
                        {{ $demanda->documentoExterno }}
                    </td>
                    <td>
                        {{ $demanda->procedimentoExterno->procedimento }}</br>
                        {{ $demanda->procedimentoExterno->tipoProcedimentoExterno->tipoprocedimento }}</br>
                        {{ $demanda->procedimentoExterno->resumo }}
                    </td>
                    <td>
                        {{ $demanda->autor->nome }}</br>
                        {{ $demanda->autor->orgao->sigla }}
                    </td>
                    <td>
                        {{ $demanda->resumoSituacao }}
                    </td>
                    <td>
                    {{ $demanda->dataPrazo ? date("d/m/Y", strtotime($demanda->dataPrazo)) : '' }}
                    </td>
                </tr>
                @endforeach
                <tr class="espaco">
                    <td colspan="{{ $colspan_total }}"></td>
                </tr>
            @endif
        @endforeach
            </tbody>
        </table>
        <hr>

        <!-- <script src="{{ asset('js/app.js') }}" defer></script> -->
    </body>
        <style scoped>
        * {
            font-family: Arial, Helvetica, sanf-serif;
        }
        body {
            font-size: 8pt;
        }       

        table.demanda td {
            padding: 5px;
        }

        table.demanda tr.grupo_distribuicao td {
            padding-left: 20px;
            background-color: #CCC;
        }

        table.demanda tr.cabecalho td {
            font-weight: 600;
            background-color: #DFDFDF;
            border-top: 1px solid #CCC;
        }

        table.demanda tr.demanda td {
            border-top: 1px solid #DFDFDF;
        }

        table.demanda tr.demanda:nth-child(even) {
            background-color: #F0F0F0;
        }

        table.demanda tr.espaco td {
            height: 10px;
        }

        </style>
</html>