<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset=utf-8>
        <meta name=viewport content="width=device-width,initial-scale=1">
        <title>SPU-SC</title>
    </head>
    <body>
        <h1>Demanda: {{ $demanda }}</h1>
        <pre>
        {{ $demanda['documentoExterno'] }}
        <!--
        {{ json_encode($demanda, JSON_PRETTY_PRINT) }}
        -->
        </pre>
    </body>
</html>