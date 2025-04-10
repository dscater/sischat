<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Recuperar contraseña</title>
    <style>
        html,
        body {
            color: black;
        }

        table {
            border-collapse: collapse;
        }

        table thead {
            background: black;

        }

        table thead tr th {
            color: white;
        }

        table thead tr th,
        table tbody tr td {
            padding: 5px;
            text-align: center;
        }

        .bg-black {
            background: black;
            color: white;
        }

        .text-md {
            font-size: 1.3em;
        }
    </style>
</head>

<body>
    <h1>Mensaje portal</h1>
    <p><strong>Asunto: </strong> {{ $datos['asunto'] }}</p>
    <p><strong>Nombre: </strong> {{ $datos['nombre'] }}</p>
    <p><strong>Correo: </strong> {{ $datos['correo'] }}</p>
    <p><strong>Teléfono/Celular: </strong> {{ $datos['fono'] }}</p>
    <p><strong>Mensaje: </strong> {{ $datos['mensaje'] }}</p>
</body>

</html>
