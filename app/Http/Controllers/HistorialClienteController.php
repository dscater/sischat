<?php

namespace App\Http\Controllers;

use App\Models\Chat;
use App\Models\DetalleVenta;
use App\Models\HistorialCliente;
use App\Models\Producto;
use App\Models\SugerenciaDiaria;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class HistorialClienteController extends Controller
{
    public function index() {}

    public function getRegistros(Request $request)
    {
        $this->genRegistros($request->comando ? $request->comando : '');
        $chats = Chat::where("user_id", Auth::user()->id)->get();

        return response()->JSON($chats);
    }

    private function genRegistros($comando = "")
    {
        $listProductos = [];
        $listRegistros = [];
        $message = "";
        $productos_id = HistorialCliente::where("user_id", Auth::id())
            ->distinct()
            ->pluck("producto_id")
            ->toArray();
        if ($comando == '') {
            if (count($productos_id) > 0) {
                $listProductos = $this->sugerencias($productos_id);
            } else {
                $listProductos = $this->masVendidos();
            }
            /**MENSAJE */

            if (count($listProductos) > 0) {
                $mensaje = 'Aquí tienes la sugerencia del día:<br/>';
                foreach ($listProductos as $item) {
                    $mensaje .= '<a href="" class="prod_sugerencia" data-producto="' . $item->producto->id . '">' . $item->producto->nombre . '</a><br/>';
                }
                $mensaje .= '<small>Haz click sobre el producto para agregarlo a tu carrito</small>';
                $fecha = date("Y-m-d");
                $hora = date("H:i");
                $existe = SugerenciaDiaria::where("user_id", Auth::user()->id)
                    ->where("fecha", $fecha)
                    ->get()->first();
                if (!$existe) {
                    SugerenciaDiaria::create([
                        "user_id" => Auth::user()->id,
                        "fecha" => date("Y-m-d"),
                        "hora" => date("H:i")
                    ]);
                    // crear chat
                    $this->registraChatUser($mensaje);
                }
            }
        } else {
            /**
             * COMANDOS
             */
            $this->registraChatUser($comando, "usuario");
            switch (trim(mb_strtolower($comando))) {
                case '/populares':
                    $listProductos = $this->masVendidos();
                    $mensaje = 'Aquí tienes las lista de los productos mas populares:<br/>';
                    foreach ($listProductos as $item) {
                        $mensaje .= '<a href="" class="prod_sugerencia" data-producto="' . $item->producto->id . '">' . $item->producto->nombre . '</a><br/>';
                    }

                    // crear chat
                    $this->registraChatUser($mensaje);
                    break;
                case '/sugerencia':
                    if (count($productos_id) > 0) {
                        $listProductos = $this->sugerencias($productos_id, 3);
                    } else {
                        $listProductos = $this->masVendidos(3);
                    }
                    $mensaje = 'Aquí tienes una lista de sugerencias:<br/>';
                    foreach ($listProductos as $item) {
                        $mensaje .= '<a href="" class="prod_sugerencia" data-producto="' . $item->producto->id . '">' . $item->producto->nombre . '</a><br/>';
                    }

                    // crear chat
                    $this->registraChatUser($mensaje);
                    break;
                default:
                    // intentar buscar un producto
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
                    $this->registraChatUser($mensaje);
                    break;
            }
        }

        $listRegistros = $this->getChatsUser();

        return [
            "listRegistros" => $listRegistros,
            "message" => $message
        ];
    }

    private function masVendidos($cantidad = 3)
    {
        return DetalleVenta::select('producto_id', DB::raw('SUM(cantidad) as total_vendido'))
            ->with('producto')
            ->groupBy('producto_id')
            ->orderByDesc('total_vendido')
            ->limit($cantidad)
            ->get();
    }
    private function sugerencias($array_productos, $cantidad = 3)
    {
        $categorias_id = Producto::whereIn("id", $array_productos)
            ->distinct()
            ->pluck("categoria_id")
            ->toArray();
        return $mas_vendidos = DetalleVenta::select('producto_id', DB::raw('SUM(cantidad) as total_vendido'))
            ->with('producto')
            ->whereHas('producto', function ($query) use ($categorias_id) {
                $query->whereIn('categoria_id', $categorias_id);
            })
            ->groupBy('producto_id')
            ->orderByDesc('total_vendido')
            ->limit($cantidad)
            ->get();
    }

    private function getChatsUser()
    {
        return Chat::where("user_id", Auth::user()->id)->get();
    }

    private function registraChatUser($mensaje = '', $tipo = "sistema")
    {
        Chat::create([
            "user_id" => Auth::user()->id,
            "mensaje" => $mensaje,
            "tipo" => $tipo
        ]);
    }
}
