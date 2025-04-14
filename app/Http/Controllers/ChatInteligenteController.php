<?php

namespace App\Http\Controllers;

use App\Models\Chat;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Phpml\Classification\KNearestNeighbors;
use App\Models\HistorialCliente;
use App\Models\DetalleVenta;
use App\Models\Producto;

class ChatInteligenteController extends Controller
{

    public function sugerir(Request $request)
    {
        $user = Auth::user();
        $inputProducto = $request->input('producto');
        $listProductos = [];

        if ($inputProducto) {
            $listProductos = Producto::where('nombre', 'like', "%$inputProducto%")->get();
            if (count($listProductos) > 0) {
                $mensaje = '¿Estas buscando algo de esto?<br/>';
                foreach ($listProductos as $item) {
                    $mensaje .= '<a href="" class="prod_sugerencia" data-producto="' . $item->id . '">' . $item->nombre . '</a><br/>';
                }
                // crear chat
                Chat::create([
                    "user_id" => Auth::user()->id,
                    "mensaje" => $mensaje
                ]);
            }
        }

        // Buscar historial del usuario
        $historial = HistorialCliente::where('user_id', $user->id)->pluck('producto_id')->unique();

        if ($historial->isNotEmpty()) {
            // Preparar datos de entrenamiento
            $samples = [];
            $labels = [];

            // Obtener combinaciones de productos que el usuario compró juntos
            $compras = HistorialCliente::where('user_id', $user->id)
                ->pluck('producto_id')
                ->unique()
                ->values();

            foreach ($compras as $productoA) {
                foreach ($compras as $productoB) {
                    if ($productoA != $productoB) {
                        $samples[] = [$productoA];
                        $labels[] = $productoB;
                    }
                }
            }

            // Entrenar modelo en memoria
            $knn = new KNearestNeighbors();
            $knn->train($samples, $labels);

            // Realizar predicciones
            $predicciones = [];
            $ultimo_producto = $compras[count($compras) - 1];
            for ($i = 0; $i < 5; $i++) {
                $pred = $knn->predict([$ultimo_producto]);
                if ($pred != $ultimo_producto && !in_array($pred, $predicciones)) {
                    $predicciones[] = $pred;
                }
            }

            $listProductos = Producto::whereIn('id', $predicciones)
                ->get();
        } else {
            // Si no hay historial o no hay suficientes datos, sugerir más vendidos
            $productosMasVendidos = DetalleVenta::selectRaw('producto_id, SUM(cantidad) as total')
                ->groupBy('producto_id')
                ->orderByDesc('total')
                ->limit(3)
                ->pluck('producto_id');

            $listProductos = Producto::whereIn('id', $productosMasVendidos)->get();
        }

        $mensaje = 'Aquí tienes la sugerencia del día:<br/>';
        foreach ($listProductos as $item) {
            $mensaje .= '<a href="" class="prod_sugerencia" data-producto="' . $item->id . '">' . $item->nombre . '</a><br/>';
        }
        $mensaje .= '<small>Haz click sobre el producto para agregarlo a tu carrito</small>';
        // crear chat
        Chat::create([
            "user_id" => Auth::user()->id,
            "mensaje" => $mensaje
        ]);

        // responder el chat
        $listChat = Chat::where("user_id", Auth::user()->id)->get();
        return response()->json([
            "listRegistros" => $listChat,
        ]);
    }

    public function responderMensajeComando(Request $request)
    {
        $user = Auth::user();
        $comando = $request->input('comando');
        $listProductos = [];

        switch ($comando) {
            case '/populares':
                $productosMasVendidos = DetalleVenta::selectRaw('producto_id, SUM(cantidad) as total')
                    ->groupBy('producto_id')
                    ->orderByDesc('total')
                    ->limit(3)
                    ->pluck('producto_id');

                $listProductos = Producto::whereIn('id', $productosMasVendidos)->get();
                $mensaje = 'Aquí tienes las lista de los productos mas populares:<br/>';
                foreach ($listProductos as $item) {
                    $mensaje .= '<a href="" class="prod_sugerencia" data-producto="' . $item->id . '">' . $item->nombre . '</a><br/>';
                }

                // crear chat
                Chat::create([
                    "user_id" => Auth::user()->id,
                    "mensaje" => $mensaje
                ]);
                break;
            case '/sugerencia':
                // Buscar historial del usuario
                $historial = HistorialCliente::where('user_id', $user->id)->pluck('producto_id')->unique();

                if ($historial->isNotEmpty()) {
                    // Preparar datos de entrenamiento
                    $samples = [];
                    $labels = [];

                    // Obtener combinaciones de productos que el usuario compró juntos
                    $compras = HistorialCliente::where('user_id', $user->id)
                        ->pluck('producto_id')
                        ->unique()
                        ->values();

                    foreach ($compras as $productoA) {
                        foreach ($compras as $productoB) {
                            if ($productoA != $productoB) {
                                $samples[] = [$productoA];
                                $labels[] = $productoB;
                            }
                        }
                    }

                    // Entrenar modelo en memoria
                    $knn = new KNearestNeighbors();
                    $knn->train($samples, $labels);

                    // Realizar predicciones
                    $predicciones = [];
                    $ultimo_producto = $compras[count($compras) - 1];
                    for ($i = 0; $i < 5; $i++) {
                        $pred = $knn->predict([$ultimo_producto]);
                        if ($pred != $ultimo_producto && !in_array($pred, $predicciones)) {
                            $predicciones[] = $pred;
                        }
                    }

                    $listProductos = Producto::whereIn('id', $predicciones)->get();
                } else {
                    $productosMasVendidos = DetalleVenta::selectRaw('producto_id, SUM(cantidad) as total')
                        ->groupBy('producto_id')
                        ->orderByDesc('total')
                        ->limit(3)
                        ->pluck('producto_id');

                    $listProductos = Producto::whereIn('id', $productosMasVendidos)->get();
                }
                $mensaje = 'Aquí tienes una lista de sugerencias:<br/>';
                foreach ($listProductos as $item) {
                    $mensaje .= '<a href="" class="prod_sugerencia" data-producto="' . $item->producto->id . '">' . $item->producto->nombre . '</a><br/>';
                }

                // crear chat
                Chat::create([
                    "user_id" => Auth::user()->id,
                    "mensaje" => $mensaje
                ]);
                break;
            default:
                // Buscar el producto ingresado
                $listProductos = Producto::where('nombre', 'like', "%$comando%")->get();
                if (count($listProductos) > 0) {
                    $mensaje = '¿Estó es lo que buscabas?<br/>';
                    foreach ($listProductos as $item) {
                        $mensaje .= '<a href="" class="prod_sugerencia" data-producto="' . $item->id . '">' . $item->nombre . '</a><br/>';
                    }
                } else {
                    $mensaje = "No encontré el producto que buscas";
                }

                // crear chat
                Chat::create([
                    "user_id" => Auth::user()->id,
                    "mensaje" => $mensaje
                ]);
                break;
        }
    }
}
