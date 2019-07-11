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
            $colspan_total = 9;
            $colspan_1 = 7;
            $colspan_2 = 5;
        @endphp

        <table class="demanda">
            <tbody>
        @foreach ($demandas as $demanda)
                <tr>
                    <td class="demanda" colspan="{{ $colspan_total }}">Demanda: 
                    {{ $demanda->tipoDocumento->tipodocumento . " nº " . $demanda->documentoExterno . " (" . $demanda->autor->orgao->sigla . ")"}}
                     - {{ $demanda->nupSEI . " SEI-" . ($demanda->seiMP ? 'MP' : 'ME')}}
                    </td>
                </tr>
                <tr>
                    <td class="rotulo">Órgão:</td>
                    <td class="valor" colspan="{{ $colspan_1 }}">{{ $demanda->autor->orgao->orgao . " - " . $demanda->autor->orgao->sigla }}</td>
                </tr>
                <tr>
                    <td class="rotulo">Demandante: </td>
                    <td class="valor" colspan="{{ $colspan_1 }}">{{ $demanda->autor->nome . " - " . $demanda->autor->cargo->cargo }}</td>
                </tr>
                <tr>
                    <td class="rotulo">Procedimento Externo: </td>
                    <td class="valor" colspan="{{ $colspan_1 }}">{{ $demanda->procedimentoExterno->tipoProcedimentoExterno->tipoprocedimento }}
                    - {{ $demanda->procedimentoExterno->procedimento }}</td>
                </tr>
                <tr>
                    <td class="rotulo">&nbsp;</td>
                    <td class="valor" colspan="{{ $colspan_1 }}">{{ $demanda->procedimentoExterno->resumo }}</td>
                </tr>
                <tr>
                    <td class="rotulo">Data do documento:</td>
                    <td class="valor">{{ $demanda->dataDocumento ? date("d/m/Y", strtotime($demanda->dataDocumento)) : '' }}</td>
                    <td class="rotulo">Prazo:</td>
                    <td class="valor">{{ $demanda->dataPrazo ? date("d/m/Y", strtotime($demanda->dataPrazo)) : '' }}</td>
                    <td class="rotulo">Distribuição:</td>
                    <td class="valor">
                        @foreach ($demanda->distribuicoes as $distribuicao)
                            @if ($distribuicao->dataAtendimento == null)
                                @if($distribuicao->assignable_type == "App\\User")
                                    {{ $distribuicao->assignable->name }}
                                @else
                                    {{ $distribuicao->assignable->sigla }}
                                @endif
                                <br>
                            @endif
                        @endforeach
                    </td>
                    <td class="rotulo">Situação:</td>
                    <td class="valor">{{ $demanda->situacao->situacao }}</td>
                </tr>
                <tr>
                    <td class="rotulo">Resumo Gerencial:</td>
                    <td class="valor" colspan="{{ $colspan_1 }}">{!! html_entity_decode($demanda->resumoSituacao) !!}</td>
                </tr>
        @endforeach
            </tbody>
        </table>
        <hr>

        <!-- <script src="{{ asset('js/app.js') }}" defer></script> -->
    </body>
        <style>
        * {
            font-family: Arial, Helvetica, sanf-serif;
        }
        body {
            font-size: 8pt;
        },
        table.demanda td {
            padding:2pt;
        }
        table.demanda .demanda {
            padding-top: 10pt;
            border-bottom: 1px solid;
            font-size: 10pt;
            font-weight:600;
        }
        table.demanda .rotulo {
            vertical-align:top;
            font-weight:600;
            text-align:right;
            min-width:150pt;
        }
        table.demanda .valor {
            vertical-align:top;
        }
        </style>
</html>