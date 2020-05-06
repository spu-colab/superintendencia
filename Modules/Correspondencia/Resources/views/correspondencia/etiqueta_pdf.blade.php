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
/**
        @foreach ($correspondencia[destinatarios] as $dest)
            @php
                $CEP = str_pad($dest->destinatario->endereco->CEP,8,"0",STR_PAD_LEFT);
                $strCEP = substr($CEP,0,5)."-".substr($CEP,5,3);
                $cb = substr($correspondencia->ano,2,2) . str_pad($dest->destinatario->codigo,6,"0",STR_PAD_LEFT);
            @endphp
            <table class="correspondencia" cellspacing="0">
                <tbody>
                <tr class="correspondencia">
                    <td>
                        {{$correspondencia->tipo->descricao. ' '.$correspondencia->setor->descricao. ' '. 
                        $correspondencia->sequencia.'/'.$correspondencia->ano}}
                    </td>
                    <td style="text-align:right;">
                        {{'Ref. '. $correspondencia->referencia}}
                    </td>
                </tr>
                <tr class="destinatario">
                    <td colspan="2">
                        <b>{{$dest->destinatario.nome}}<b>
                        @if=($dest->destinatario.orgao !== null")
                            {{$dest->destinatario.orgao."<br>"}}
                        @if=($dest->destinatario.setor !== null")
                            {{$dest->destinatario.setor."<br>"}}
                        {{$dest->destinatario->endereco->tipo_logradouro->descricao." ".$dest->destinatario->endereco->logradouro}}
                        @if=($dest->destinatario->endereco->numero !== null)
                            {{", ".$dest->destinatario->endereco->numero}}
                        @if=($dest->destinatario->endereco->complemento !== null)
                            {{" - ".$dest->destinatario->endereco->complemento}}
                        {{"<br>"}}
                        {{$dest->destinatario->endereco->bairro}}
                    </td>
                </tr>
                <tr>
                    <td>
                        {{"<b>".$strCEP . "</b> - ".$dest->destinatario->endereco->municipio->cidade . " /".
                        $dest->destinatario->endereco->municipio->estado->descricao}}
                    </td>
                    <td style="text-align:right;">
                        {{$cb}}
                    </td>
                </tr>
                </tbody>
            </table>
        @endforeach
*/        
    </body>
</html>