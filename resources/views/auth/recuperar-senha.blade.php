<html>
    <head>
        <link href="{{ asset('css/app.css') }}" rel="stylesheet">
        <style>
        body {
            padding: 5%;
        }
        </style>
    </head>
    <body>
        <h3>Olá, {{  $user->name }}!</h3>

        <p>&nbsp;</p>

        <p>Você está recebendo este e-mail porque nós recebemos uma solicitação de recuperação de senha para a sua conta.</p>

        <p>Clique no link abaixo para prosseguir com a redefinição da sua senha:<br>
        <a href="{{ $link }}" target="_blank">{{ $link }}</a>
        </p>

        <p>Este link tem validade de 60 minutos.</p>

        <p>Se você não fez esta solicitação, apenas ignore este e-mail.</p>

        <p>Atenciosamente,</br>
        SPU-SC</p>

    </body>
</html>