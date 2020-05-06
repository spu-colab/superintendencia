<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset=utf-8>
        <meta name=viewport content="width=device-width,initial-scale=1">
        <!-- <link href="{{ asset('css/app.css') }}" rel="stylesheet"> -->
        <title>SPU-SC</title>
    </head>
    <body>
    $postagens->ano 

@php
print_r($postagens[0]->ano);
@endphp
<br>
<br>
<br>
<br>
{{$postagens[0]->ano}}
<br>

{{$postagens[0]->destPost[0]->documento->dsctipo->descricao}}
{{$postagens[0]->destPost[0]->documento->sequencia}}
{{$postagens[0]->destPost[0]->documento->ano}}
{{$postagens[0]->destPost[0]->destinatario->nome}}
{{$postagens[0]->destPost[0]->destinatario->enderecoDest->CEP}}

$postagem->enderecoDest->


</body>
</html>
