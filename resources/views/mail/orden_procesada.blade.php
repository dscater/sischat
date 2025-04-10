<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Solicitud de Pedido</title>
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
    <h1>Orden de Pedido Procesada</h1>
    <p>Acabamos de procesar su pedido.</p>
    <p>Código Orden: {{ $orden_pedido->codigo }}</p>
    <p>Cliente: {{ $orden_pedido->user->cliente->nombre }}</p>
    <p>Celular: {{ $orden_pedido->celular }}</p>
    <table border="1">
        <thead>
            <tr>
                <th>N°</th>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Precio</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            @php
                $cont = 1;
            @endphp
            @foreach ($orden_detalles as $od)
                <tr>
                    <td>{{ $cont++ }}</td>
                    <td>{{ $od->producto->nombre }}</td>
                    <td>{{ $od->cantidad }}</td>
                    <td>{{ $od->precio }}</td>
                    <td>{{ $od->precio_total }}</td>
                </tr>
            @endforeach
            <tr class="bg-black text-md">
                <td colspan="4">TOTAL</td>
                <td>{{ $orden_pedido->total }}</td>
            </tr>
            <tr class="bg-black text-md">
                <td colspan="4">DESCUENTO</td>
                <td>{{ $orden_pedido->descuento }}%</td>
            </tr>
            <tr class="bg-black text-md">
                <td colspan="4">TOTAL FINAL</td>
                <td>{{ $orden_pedido->total_final }}</td>
            </tr>
        </tbody>
    </table>
    <p>Ver detalles del pedido <a href="{{ url('/administracion/orden_pedidos/show/' . $orden_pedido->id) }}">Aqui</a>
    </p>
</body>

</html>
