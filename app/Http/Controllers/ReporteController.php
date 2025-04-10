<?php

namespace App\Http\Controllers;

use App\Models\Almacen;
use App\Models\Campania;
use App\Models\CampaniaEnvio;
use App\Models\DetalleOrden;
use App\Models\DetalleVenta;
use App\Models\HistorialAccion;
use App\Models\IngresoProducto;
use App\Models\KardexProducto;
use App\Models\OrdenDetalle;
use App\Models\Producto;
use App\Models\User;
use App\Models\Venta;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use PDF;

class ReporteController extends Controller
{
    public function usuarios(Request $request)
    {
        $filtro =  $request->filtro;
        $usuarios = User::where('id', '!=', 1)->orderBy("paterno", "ASC")->get();

        if ($filtro == 'Tipo de usuario') {
            $request->validate([
                'tipo' => 'required',
            ]);
            $usuarios = User::where('id', '!=', 1)->where('tipo', $request->tipo)->orderBy("paterno", "ASC")->get();
        }

        $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('Usuarios.pdf');
    }

    public function kardex(Request $request)
    {
        $filtro = $request->filtro;
        $producto_id = $request->producto_id;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;

        if ($request->filtro == 'Producto') {
            $request->validate([
                'producto_id' => 'required',
            ]);
        }

        if ($request->filtro == 'Rango de fechas') {
            $request->validate([
                'fecha_ini' => 'required|date',
                'fecha_fin' => 'required|date',
            ]);
        }

        $productos = Producto::all();
        if ($filtro != 'todos') {
            if ($filtro == 'Producto') {
                $productos = Producto::where("id", $producto_id)->get();
            }
        }

        $array_kardex = [];
        $array_saldo_anterior = [];
        foreach ($productos as $registro) {
            $kardex = KardexProducto::where('producto_id', $registro->id)->get();
            $array_saldo_anterior[$registro->id] = [
                'sw' => false,
                'saldo_anterior' => []
            ];
            if ($filtro == 'Rango de fechas') {
                $kardex = KardexProducto::where('producto_id', $registro->id)
                    ->whereBetween('fecha', [$fecha_ini, $fecha_fin])->get();
                // buscar saldo anterior si existe
                $saldo_anterior = KardexProducto::where('producto_id', $registro->id)
                    ->where('fecha', '<', $fecha_ini)
                    ->orderBy('created_at', 'asc')->get()->last();
                if ($saldo_anterior) {
                    $cantidad_saldo = $saldo_anterior->cantidad_saldo;
                    $monto_saldo = $saldo_anterior->monto_saldo;
                    $array_saldo_anterior[$registro->id] = [
                        'sw' => true,
                        'saldo_anterior' => [
                            'cantidad_saldo' => $cantidad_saldo,
                            'monto_saldo' => $monto_saldo,
                        ]
                    ];
                }
            }
            $array_kardex[$registro->id] = $kardex;
        }

        $pdf = PDF::loadView('reportes.kardex', compact('productos', 'array_kardex', 'array_saldo_anterior'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('kardex.pdf');
    }

    public function ventas(Request $request)
    {
        $filtro = $request->filtro;
        $producto_id = $request->producto_id;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;

        if ($filtro == 'Producto') {
            $request->validate([
                'producto_id' => 'required',
            ]);
        }
        if ($filtro == 'Rango de fechas') {
            $request->validate([
                'fecha_ini' => 'required|date',
                'fecha_fin' => 'required|date',
            ]);
        }
        if ($filtro == 'Canal de ventas') {
            $request->validate([
                'canal' => 'required',
            ]);
        }

        $ventas = Venta::all();
        if ($filtro != 'todos') {
            if ($filtro == 'Producto') {
                $ventas = Venta::select("ventas.*")
                    ->join("detalle_ventas", "detalle_ventas.venta_id", "=", "ventas.id")
                    ->where("detalle_ventas.producto_id", $producto_id)
                    ->get();
            }
            if ($filtro == 'Rango de fechas') {
                $ventas = Venta::whereBetween("fecha_registro", [$fecha_ini, $fecha_fin])->get();
            }
            if ($filtro == 'Canal de ventas') {
                $ventas = Venta::where("tipo", [$request->canal])->get();
            }
        }
        $pdf = PDF::loadView('reportes.ventas', compact('ventas'))->setPaper('legal', 'portrait');

        // ENUMERAR LAS PÁGINAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('ventas.pdf');
    }

    public function stock_productos(Request $request)
    {
        $filtro =  $request->filtro;
        $producto =  $request->producto;

        if ($filtro != 'TODOS') {
            $request->validate(['producto' => 'required']);
        }

        $registros = Producto::orderBy("productos.nombre")->get();
        if ($filtro != 'TODOS') {
            $registros = Producto::where("id", $producto)->orderBy("productos.nombre")->get();
        }


        $pdf = PDF::loadView('reportes.stock_productos', compact('registros'))->setPaper('legal', 'portrait');

        // ENUMERAR LAS PÁGINAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));
        return $pdf->download('stock_productos.pdf');
    }

    public function historial_accion(Request $request)
    {
        $historial_accions = HistorialAccion::orderBy("created_at", "desc")->get();

        if (isset($request->fecha_ini) && isset($request->fecha_fin)) {
            $historial_accions = HistorialAccion::with("user")->whereBetween("fecha", [$request->fecha_ini, $request->fecha_fin])->orderBy("created_at", "desc")->get();
        }

        $pdf = PDF::loadView('reportes.historial_accion', compact('historial_accions'))->setPaper('legal', 'portrait');

        // ENUMERAR LAS PÁGINAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));
        return $pdf->download('historial_accions.pdf');
    }


    public function grafico_ingresos(Request $request)
    {
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $filtro =  $request->filtro;
        $producto_id =  $request->producto_id;

        if ($filtro == 'Producto') {
            $productos = Producto::select("productos.*")
                ->where("id", $producto_id)
                ->get();
        } else {
            $productos = Producto::select("productos.*")
                ->whereExists(function ($query) {
                    $query->select(DB::raw(1))
                        ->from('detalle_ventas')
                        ->whereRaw('productos.id = detalle_ventas.producto_id');
                })
                ->get();
        }
        $data = [];
        foreach ($productos as $producto) {
            $cantidad = 0;
            if ($filtro == 'Rango de fechas') {
                $cantidad = DetalleOrden::select("detalle_ventas")
                    ->join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                    ->where("ventas.estado", "CANCELADO")
                    ->where("detalle_ventas.producto_id", $producto->id)
                    ->whereBetween("fecha_registro", [$fecha_ini, $fecha_fin])
                    ->sum("detalle_ventas.subtotal");
            } else {
                $cantidad = DetalleOrden::where("producto_id", $producto->id)
                    ->join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                    ->where("ventas.estado", "CANCELADO")
                    ->sum("subtotal");
            }
            $data[] = [$producto->nombre, $cantidad ? (float)$cantidad : 0];
        }

        $fecha = date("d/m/Y");
        return response()->JSON([
            "sw" => true,
            "datos" => $data,
            "fecha" => $fecha
        ]);
    }

    public function grafico_orden(Request $request)
    {
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $filtro =  $request->filtro;
        $producto_id =  $request->producto_id;

        if ($filtro == 'Producto') {
            $productos = Producto::select("productos.*")
                ->where("id", $producto_id)
                ->get();
        } else {
            $productos = Producto::select("productos.*")
                ->whereExists(function ($query) {
                    $query->select(DB::raw(1))
                        ->from('detalle_ventas')
                        ->whereRaw('productos.id = detalle_ventas.producto_id');
                })
                ->get();
        }
        $data = [];
        foreach ($productos as $producto) {
            $cantidad = 0;
            if ($filtro == 'Rango de fechas') {
                $cantidad = count(OrdenDetalle::select("detalle_ventas")
                    ->join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                    ->where("detalle_ventas.producto_id", $producto->id)
                    ->whereBetween("fecha_registro", [$fecha_ini, $fecha_fin])
                    ->get());
            } else {
                $cantidad = count(OrdenDetalle::where("producto_id", $producto->id)->get());
            }
            $data[] = [$producto->nombre, $cantidad ? (float)$cantidad : 0];
        }

        $fecha = date("d/m/Y");
        return response()->JSON([
            "sw" => true,
            "datos" => $data,
            "fecha" => $fecha
        ]);
    }


    public function ventas_fecha(Request $request)
    {
        $producto_id = $request->producto_id;
        $canal = $request->canal;
        $filtro_fecha = $request->filtro_fecha;
        $gestion = $request->gestion;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;

        $categories = [];
        $series = [
            [
                "name" => "Ecommerce",
                "data" => [],
            ], [
                "name" => "Fisico/Presencial",
                "data" => [],
            ]
        ];

        if ($filtro_fecha == 'RANGO DE FECHAS') {
            $request->validate([
                "fecha_ini" => "required|date",
                "fecha_fin" => "required|date",
            ]);

            $aux_fecha_ini = $fecha_ini;
            while ($aux_fecha_ini <= $fecha_fin) {
                $categories[] = $aux_fecha_ini;

                $cantidad_ventas_ecommerce = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                    ->where("ventas.fecha_registro", $aux_fecha_ini)
                    ->where("ventas.tipo", "ECOMMERCE");
                if ($producto_id != 'TODOS') {
                    $cantidad_ventas_ecommerce->where("detalle_ventas.producto_id", $producto_id);
                }
                $cantidad_ventas_ecommerce = $cantidad_ventas_ecommerce->sum("detalle_ventas.cantidad");

                $cantidad_ventas_fisico = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                    ->where("ventas.fecha_registro", $aux_fecha_ini)
                    ->where("ventas.tipo", "FISICO");
                if ($producto_id != 'TODOS') {
                    $cantidad_ventas_fisico->where("detalle_ventas.producto_id", $producto_id);
                }
                $cantidad_ventas_fisico = $cantidad_ventas_fisico->sum("detalle_ventas.cantidad");

                $series[0]["data"][] = $cantidad_ventas_ecommerce;
                $series[1]["data"][] = $cantidad_ventas_fisico;

                $aux_fecha_ini = date("Y-m-d", strtotime($aux_fecha_ini . "+1 days"));
            }
        }

        if ($filtro_fecha == 'MES') {
            $meses = [
                "01" => "Enero",
                "02" => "Febrero",
                "03" => "Marzo",
                "04" => "Abril",
                "05" => "Mayo",
                "06" => "Junio",
                "07" => "Julio",
                "08" => "Agosto",
                "09" => "Septiembre",
                "10" => "Octubre",
                "11" => "Noviembre",
                "12" => "Diciembre"
            ];
            if ($gestion) {
                foreach ($meses as $key => $value) {
                    $categories[] = $value;
                    $fecha_busqueda = $gestion . "-" . $key;
                    $cantidad_ventas_ecommerce = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                        ->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                        ->where("ventas.tipo", "ECOMMERCE");
                    if ($producto_id != 'TODOS') {
                        $cantidad_ventas_ecommerce->where("detalle_ventas.producto_id", $producto_id);
                    }
                    $cantidad_ventas_ecommerce = $cantidad_ventas_ecommerce->sum("detalle_ventas.cantidad");

                    $cantidad_ventas_fisico = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                        ->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                        ->where("ventas.tipo", "FISICO");
                    if ($producto_id != 'TODOS') {
                        $cantidad_ventas_fisico->where("detalle_ventas.producto_id", $producto_id);
                    }
                    $cantidad_ventas_fisico = $cantidad_ventas_fisico->sum("detalle_ventas.cantidad");

                    $series[0]["data"][] = $cantidad_ventas_ecommerce;
                    $series[1]["data"][] = $cantidad_ventas_fisico;
                }
            }
        }

        if ($filtro_fecha == 'TRIMESTRE') {
            $trimestres = [
                "Trim. 1" => [
                    "01" => "Enero",
                    "02" => "Febrero",
                    "03" => "Marzo",
                ],
                "Trim. 2" => [
                    "04" => "Abril",
                    "05" => "Mayo",
                    "06" => "Junio",
                ],
                "Trim. 3" => [
                    "07" => "Julio",
                    "08" => "Agosto",
                    "09" => "Septiembre",
                ],
                "Trim. 4" => [
                    "10" => "Octubre",
                    "11" => "Noviembre",
                    "12" => "Diciembre"
                ],
            ];
            if ($gestion) {
                foreach ($trimestres as $key => $value) {
                    $categories[] = $key;
                    $suma_trimestres_ecommerce = 0;
                    $suma_trimestres_fisico = 0;
                    foreach ($value as $key_m => $m) {
                        $fecha_busqueda = $gestion . "-" . $key_m;
                        $cantidad_ventas_ecommerce = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                            ->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                            ->where("ventas.tipo", "ECOMMERCE");
                        if ($producto_id != 'TODOS') {
                            $cantidad_ventas_ecommerce->where("detalle_ventas.producto_id", $producto_id);
                        }
                        $cantidad_ventas_ecommerce = $cantidad_ventas_ecommerce->sum("detalle_ventas.cantidad");

                        $cantidad_ventas_fisico = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                            ->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                            ->where("ventas.tipo", "FISICO");
                        if ($producto_id != 'TODOS') {
                            $cantidad_ventas_fisico->where("detalle_ventas.producto_id", $producto_id);
                        }
                        $cantidad_ventas_fisico = $cantidad_ventas_fisico->sum("detalle_ventas.cantidad");

                        $suma_trimestres_ecommerce += (float)$cantidad_ventas_ecommerce;
                        $suma_trimestres_fisico += (float)$cantidad_ventas_fisico;
                    }
                    $series[0]["data"][] = $suma_trimestres_ecommerce;
                    $series[1]["data"][] = $suma_trimestres_fisico;
                }
            }
        }

        if ($filtro_fecha == 'SEMESTRE') {
            $semestres = [
                "Sem. 1" => [
                    "01" => "Enero",
                    "02" => "Febrero",
                    "03" => "Marzo",
                    "04" => "Abril",
                    "05" => "Mayo",
                    "06" => "Junio",
                ],
                "Sem. 2" => [
                    "07" => "Julio",
                    "08" => "Agosto",
                    "09" => "Septiembre",
                    "10" => "Octubre",
                    "11" => "Noviembre",
                    "12" => "Diciembre"
                ]
            ];
            if ($gestion) {
                foreach ($semestres as $key => $value) {
                    $categories[] = $key;
                    $suma_semestres_ecommerce = 0;
                    $suma_semestres_fisico = 0;
                    foreach ($value as $key_m => $m) {
                        $fecha_busqueda = $gestion . "-" . $key_m;
                        $cantidad_ventas_ecommerce = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                            ->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                            ->where("ventas.tipo", "ECOMMERCE");
                        if ($producto_id != 'TODOS') {
                            $cantidad_ventas_ecommerce->where("detalle_ventas.producto_id", $producto_id);
                        }
                        $cantidad_ventas_ecommerce = $cantidad_ventas_ecommerce->sum("detalle_ventas.cantidad");

                        $cantidad_ventas_fisico = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                            ->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                            ->where("ventas.tipo", "FISICO");
                        if ($producto_id != 'TODOS') {
                            $cantidad_ventas_fisico->where("detalle_ventas.producto_id", $producto_id);
                        }
                        $cantidad_ventas_fisico = $cantidad_ventas_fisico->sum("detalle_ventas.cantidad");
                        $suma_semestres_ecommerce += (float)$cantidad_ventas_ecommerce;
                        $suma_semestres_fisico += (float)$cantidad_ventas_fisico;
                    }
                    $series[0]["data"][] = $suma_semestres_ecommerce;
                    $series[1]["data"][] = $suma_semestres_fisico;
                }
            }
        }

        if ($filtro_fecha == 'ANUAL') {
            $primera_venta = Venta::first();
            $ultima_venta = Venta::get()->last();
            $anio_uv = date("Y", strtotime($ultima_venta->fecha_venta));
            $anio_inicial = date("Y", strtotime($primera_venta->fecha_registro));
            $anio_actual = date("Y");
            $ultimo_anio = $anio_actual;
            if ($anio_uv  >=  $anio_actual) {
                $ultimo_anio = $anio_uv;
            }

            for ($i = $anio_inicial; $i <= $ultimo_anio; $i++) {
                $categories[] = $i;
                $fecha_busqueda = $i . "-";
                $cantidad_ventas_ecommerce = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                    ->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                    ->where("ventas.tipo", "ECOMMERCE");
                if ($producto_id != 'TODOS') {
                    $cantidad_ventas_ecommerce->where("detalle_ventas.producto_id", $producto_id);
                }
                $cantidad_ventas_ecommerce = $cantidad_ventas_ecommerce->sum("detalle_ventas.cantidad");

                $cantidad_ventas_fisico = DetalleVenta::join("ventas", "ventas.id", "=", "detalle_ventas.venta_id")
                    ->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                    ->where("ventas.tipo", "FISICO");
                if ($producto_id != 'TODOS') {
                    $cantidad_ventas_fisico->where("detalle_ventas.producto_id", $producto_id);
                }
                $cantidad_ventas_fisico = $cantidad_ventas_fisico->sum("detalle_ventas.cantidad");

                $series[0]["data"][] = $cantidad_ventas_ecommerce;
                $series[1]["data"][] = $cantidad_ventas_fisico;
            }
        }

        if ($canal != 'TODOS') {
            if ($canal == 'ECOMMERCE') {
                unset($series[1]);
                $series = array_values($series);
            }
            if ($canal == 'FISICO') {
                unset($series[0]);
                $series = array_values($series);
            }
        }
        $fecha = date("d/m/Y");
        return response()->JSON([
            "sw" => true,
            "categories" => $categories,
            "series" => $series,
            "fecha" => $fecha,
        ]);
    }

    public function compras_fecha(Request $request)
    {
        $producto_id = $request->producto_id;
        $filtro_fecha = $request->filtro_fecha;
        $gestion = $request->gestion;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;

        $categories = [];
        $series = [
            [
                "name" => "Cantidad",
                "data" => [],
            ]
        ];

        if ($filtro_fecha == 'RANGO DE FECHAS') {
            $aux_fecha_ini = $fecha_ini;
            $request->validate([
                "fecha_ini" => "required|date",
                "fecha_fin" => "required|date",
            ]);
            Log::debug($aux_fecha_ini);
            Log::debug($fecha_ini);
            while ($aux_fecha_ini <= $fecha_fin) {
                $categories[] = $aux_fecha_ini;

                $cantidad_ingreso_productos = IngresoProducto::where("ingreso_productos.fecha_compra", $aux_fecha_ini);
                if ($producto_id != 'TODOS') {
                    $cantidad_ingreso_productos->where("ingreso_productos.producto_id", $producto_id);
                }
                $cantidad_ingreso_productos = $cantidad_ingreso_productos->sum("ingreso_productos.cantidad");

                $series[0]["data"][] = $cantidad_ingreso_productos;

                $aux_fecha_ini = date("Y-m-d", strtotime($aux_fecha_ini . "+1 days"));
            }
            Log::debug($categories);
        }

        if ($filtro_fecha == 'MES') {
            $meses = [
                "01" => "Enero",
                "02" => "Febrero",
                "03" => "Marzo",
                "04" => "Abril",
                "05" => "Mayo",
                "06" => "Junio",
                "07" => "Julio",
                "08" => "Agosto",
                "09" => "Septiembre",
                "10" => "Octubre",
                "11" => "Noviembre",
                "12" => "Diciembre"
            ];
            if ($gestion) {
                foreach ($meses as $key => $value) {
                    $categories[] = $value;
                    $fecha_busqueda = $gestion . "-" . $key;
                    $cantidad_ingreso_productos = IngresoProducto::where("ingreso_productos.fecha_compra", "LIKE", "$fecha_busqueda%");
                    if ($producto_id != 'TODOS') {
                        $cantidad_ingreso_productos->where("ingreso_productos.producto_id", $producto_id);
                    }
                    $cantidad_ingreso_productos = $cantidad_ingreso_productos->sum("ingreso_productos.cantidad");

                    $series[0]["data"][] = $cantidad_ingreso_productos;
                }
            }
        }

        if ($filtro_fecha == 'TRIMESTRE') {
            $trimestres = [
                "Trim. 1" => [
                    "01" => "Enero",
                    "02" => "Febrero",
                    "03" => "Marzo",
                ],
                "Trim. 2" => [
                    "04" => "Abril",
                    "05" => "Mayo",
                    "06" => "Junio",
                ],
                "Trim. 3" => [
                    "07" => "Julio",
                    "08" => "Agosto",
                    "09" => "Septiembre",
                ],
                "Trim. 4" => [
                    "10" => "Octubre",
                    "11" => "Noviembre",
                    "12" => "Diciembre"
                ],
            ];
            if ($gestion) {
                foreach ($trimestres as $key => $value) {
                    $categories[] = $key;
                    $suma_trimestres = 0;
                    foreach ($value as $key_m => $m) {
                        $fecha_busqueda = $gestion . "-" . $key_m;
                        $cantidad_ingreso_productos = IngresoProducto::where("ingreso_productos.fecha_compra", "LIKE", "$fecha_busqueda%");
                        if ($producto_id != 'TODOS') {
                            $cantidad_ingreso_productos->where("ingreso_productos.producto_id", $producto_id);
                        }
                        $cantidad_ingreso_productos = $cantidad_ingreso_productos->sum("ingreso_productos.cantidad");
                        $suma_trimestres += (float)$cantidad_ingreso_productos;
                    }
                    $series[0]["data"][] = $suma_trimestres;
                }
            }
        }

        if ($filtro_fecha == 'SEMESTRE') {
            $semestres = [
                "Sem. 1" => [
                    "01" => "Enero",
                    "02" => "Febrero",
                    "03" => "Marzo",
                    "04" => "Abril",
                    "05" => "Mayo",
                    "06" => "Junio",
                ],
                "Sem. 2" => [
                    "07" => "Julio",
                    "08" => "Agosto",
                    "09" => "Septiembre",
                    "10" => "Octubre",
                    "11" => "Noviembre",
                    "12" => "Diciembre"
                ]
            ];
            if ($gestion) {
                foreach ($semestres as $key => $value) {
                    $categories[] = $key;
                    $suma_semestres = 0;
                    foreach ($value as $key_m => $m) {
                        $fecha_busqueda = $gestion . "-" . $key_m;
                        $cantidad_ingreso_productos = IngresoProducto::where("ingreso_productos.fecha_compra", "LIKE", "$fecha_busqueda%");
                        if ($producto_id != 'TODOS') {
                            $cantidad_ingreso_productos->where("ingreso_productos.producto_id", $producto_id);
                        }
                        $cantidad_ingreso_productos = $cantidad_ingreso_productos->sum("ingreso_productos.cantidad");
                        $suma_semestres += (float)$cantidad_ingreso_productos;
                    }
                    $series[0]["data"][] = $suma_semestres;
                }
            }
        }

        if ($filtro_fecha == 'ANUAL') {
            $primera_venta = Venta::first();
            $ultima_venta = Venta::get()->last();
            $anio_uv = date("Y", strtotime($ultima_venta->fecha_venta));
            $anio_inicial = date("Y", strtotime($primera_venta->fecha_registro));
            $anio_actual = date("Y");
            $ultimo_anio = $anio_actual;
            if ($anio_uv  >=  $anio_actual) {
                $ultimo_anio = $anio_uv;
            }

            for ($i = $anio_inicial; $i <= $ultimo_anio; $i++) {
                $categories[] = $i;
                $fecha_busqueda = $i . "-";
                $cantidad_ingreso_productos = IngresoProducto::where("ingreso_productos.fecha_compra", "LIKE", "$fecha_busqueda%");
                if ($producto_id != 'TODOS') {
                    $cantidad_ingreso_productos->where("ingreso_productos.producto_id", $producto_id);
                }
                $cantidad_ingreso_productos = $cantidad_ingreso_productos->sum("ingreso_productos.cantidad");

                $series[0]["data"][] = $cantidad_ingreso_productos;
            }
        }

        $fecha = date("d/m/Y");
        return response()->JSON([
            "sw" => true,
            "categories" => $categories,
            "series" => $series,
            "fecha" => $fecha,
        ]);
    }


    public function ventas_promedio(Request $request)
    {
        $producto_id = $request->producto_id;
        $canal = $request->canal;
        $filtro_fecha = $request->filtro_fecha;
        $gestion = $request->gestion;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;

        $categories = [];
        $series = [
            [
                "name" => "Ecommerce",
                "data" => [],
            ], [
                "name" => "Fisico/Presencial",
                "data" => [],
            ]
        ];
        $total_ventas = 0;
        if ($filtro_fecha == 'RANGO DE FECHAS') {
            $request->validate([
                "fecha_ini" => "required|date",
                "fecha_fin" => "required|date",
            ]);

            $aux_fecha_ini = $fecha_ini;

            $cantidad_ventas_ecommerce = Venta::whereBetween("ventas.fecha_registro", [$aux_fecha_ini, $fecha_fin]);
            $total_ventas = $cantidad_ventas_ecommerce->count();

            while ($aux_fecha_ini <= $fecha_fin) {
                $categories[] = $aux_fecha_ini;

                $cantidad_ventas_ecommerce = Venta::join("detalle_ventas", "detalle_ventas.venta_id", "=", "ventas.id")
                    ->where("ventas.fecha_registro", $aux_fecha_ini)
                    ->where("ventas.tipo", "ECOMMERCE");
                if ($producto_id != 'TODOS') {
                    $cantidad_ventas_ecommerce->where("detalle_ventas.producto_id", $producto_id);
                }
                $cantidad_ventas_ecommerce = $cantidad_ventas_ecommerce->count();

                $cantidad_ventas_fisico = Venta::join("detalle_ventas", "detalle_ventas.venta_id", "=", "ventas.id")
                    ->where("ventas.fecha_registro", $aux_fecha_ini)
                    ->where("ventas.tipo", "FISICO");
                if ($producto_id != 'TODOS') {
                    $cantidad_ventas_fisico->where("detalle_ventas.producto_id", $producto_id);
                }
                $cantidad_ventas_fisico = $cantidad_ventas_fisico->count();

                if ($total_ventas > 0) {
                    $series[0]["data"][] = (float)round($cantidad_ventas_ecommerce / $total_ventas, 2);
                    $series[1]["data"][] = (float)round($cantidad_ventas_fisico / $total_ventas, 2);
                } else {
                    $series[0]["data"][] = 0;
                    $series[1]["data"][] = 0;
                }

                $aux_fecha_ini = date("Y-m-d", strtotime($aux_fecha_ini . "+1 days"));
            }
        }

        if ($filtro_fecha == 'MES') {
            $meses = [
                "01" => "Enero",
                "02" => "Febrero",
                "03" => "Marzo",
                "04" => "Abril",
                "05" => "Mayo",
                "06" => "Junio",
                "07" => "Julio",
                "08" => "Agosto",
                "09" => "Septiembre",
                "10" => "Octubre",
                "11" => "Noviembre",
                "12" => "Diciembre"
            ];
            if ($gestion) {
                $aux_ini = $gestion . "-01-31";
                $aux_fin = $gestion . "-12-31";
                $cantidad_ventas_ecommerce = Venta::whereBetween("ventas.fecha_registro", [$aux_ini, $aux_fin]);
                $total_ventas = $cantidad_ventas_ecommerce->count();

                foreach ($meses as $key => $value) {
                    $categories[] = $value;
                    $fecha_busqueda = $gestion . "-" . $key;
                    $cantidad_ventas_ecommerce = Venta::join("detalle_ventas", "detalle_ventas.venta_id", "=", "ventas.id")->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                        ->where("ventas.tipo", "ECOMMERCE");
                    if ($producto_id != 'TODOS') {
                        $cantidad_ventas_ecommerce->where("detalle_ventas.producto_id", $producto_id);
                    }
                    $cantidad_ventas_ecommerce = $cantidad_ventas_ecommerce->count();

                    $cantidad_ventas_fisico = Venta::join("detalle_ventas", "detalle_ventas.venta_id", "=", "ventas.id")->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                        ->where("ventas.tipo", "FISICO");
                    if ($producto_id != 'TODOS') {
                        $cantidad_ventas_fisico->where("detalle_ventas.producto_id", $producto_id);
                    }
                    $cantidad_ventas_fisico = $cantidad_ventas_fisico->count();

                    if ($total_ventas > 0) {
                        $series[0]["data"][] = (float)round($cantidad_ventas_ecommerce / $total_ventas, 2);
                        $series[1]["data"][] = (float)round($cantidad_ventas_fisico / $total_ventas, 2);
                    } else {
                        $series[0]["data"][] = 0;
                        $series[1]["data"][] = 0;
                    }
                }
            }
        }

        if ($filtro_fecha == 'TRIMESTRE') {
            $trimestres = [
                "Trim. 1" => [
                    "01" => "Enero",
                    "02" => "Febrero",
                    "03" => "Marzo",
                ],
                "Trim. 2" => [
                    "04" => "Abril",
                    "05" => "Mayo",
                    "06" => "Junio",
                ],
                "Trim. 3" => [
                    "07" => "Julio",
                    "08" => "Agosto",
                    "09" => "Septiembre",
                ],
                "Trim. 4" => [
                    "10" => "Octubre",
                    "11" => "Noviembre",
                    "12" => "Diciembre"
                ],
            ];
            if ($gestion) {
                $aux_ini = $gestion . "-01-31";
                $aux_fin = $gestion . "-12-31";
                $cantidad_ventas_ecommerce = Venta::whereBetween("ventas.fecha_registro", [$aux_ini, $aux_fin]);
                $total_ventas = $cantidad_ventas_ecommerce->count();

                foreach ($trimestres as $key => $value) {
                    $categories[] = $key;
                    $suma_trimestres_ecommerce = 0;
                    $suma_trimestres_fisico = 0;
                    foreach ($value as $key_m => $m) {
                        $fecha_busqueda = $gestion . "-" . $key_m;
                        $cantidad_ventas_ecommerce = Venta::join("detalle_ventas", "detalle_ventas.venta_id", "=", "ventas.id")->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                            ->where("ventas.tipo", "ECOMMERCE");
                        if ($producto_id != 'TODOS') {
                            $cantidad_ventas_ecommerce->where("detalle_ventas.producto_id", $producto_id);
                        }
                        $cantidad_ventas_ecommerce = $cantidad_ventas_ecommerce->count();

                        $cantidad_ventas_fisico = Venta::join("detalle_ventas", "detalle_ventas.venta_id", "=", "ventas.id")->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                            ->where("ventas.tipo", "FISICO");
                        if ($producto_id != 'TODOS') {
                            $cantidad_ventas_fisico->where("detalle_ventas.producto_id", $producto_id);
                        }
                        $cantidad_ventas_fisico = $cantidad_ventas_fisico->count();

                        $suma_trimestres_ecommerce += (float)$cantidad_ventas_ecommerce;
                        $suma_trimestres_fisico += (float)$cantidad_ventas_fisico;
                    }
                    if ($total_ventas > 0) {
                        $series[0]["data"][] = (float)round($suma_trimestres_ecommerce / $total_ventas, 2);
                        $series[1]["data"][] = (float)round($suma_trimestres_fisico / $total_ventas, 2);
                    } else {
                        $series[0]["data"][] = 0;
                        $series[1]["data"][] = 0;
                    }
                }
            }
        }

        if ($filtro_fecha == 'SEMESTRE') {
            $semestres = [
                "Sem. 1" => [
                    "01" => "Enero",
                    "02" => "Febrero",
                    "03" => "Marzo",
                    "04" => "Abril",
                    "05" => "Mayo",
                    "06" => "Junio",
                ],
                "Sem. 2" => [
                    "07" => "Julio",
                    "08" => "Agosto",
                    "09" => "Septiembre",
                    "10" => "Octubre",
                    "11" => "Noviembre",
                    "12" => "Diciembre"
                ]
            ];
            if ($gestion) {
                $aux_ini = $gestion . "-01-31";
                $aux_fin = $gestion . "-12-31";
                $cantidad_ventas_ecommerce = Venta::whereBetween("ventas.fecha_registro", [$aux_ini, $aux_fin]);
                $total_ventas = $cantidad_ventas_ecommerce->count();

                foreach ($semestres as $key => $value) {
                    $categories[] = $key;
                    $suma_semestres_ecommerce = 0;
                    $suma_semestres_fisico = 0;
                    foreach ($value as $key_m => $m) {
                        $fecha_busqueda = $gestion . "-" . $key_m;
                        $cantidad_ventas_ecommerce = Venta::join("detalle_ventas", "detalle_ventas.venta_id", "=", "ventas.id")->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                            ->where("ventas.tipo", "ECOMMERCE");
                        if ($producto_id != 'TODOS') {
                            $cantidad_ventas_ecommerce->where("detalle_ventas.producto_id", $producto_id);
                        }
                        $cantidad_ventas_ecommerce = $cantidad_ventas_ecommerce->count();

                        $cantidad_ventas_fisico = Venta::join("detalle_ventas", "detalle_ventas.venta_id", "=", "ventas.id")->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                            ->where("ventas.tipo", "FISICO");
                        if ($producto_id != 'TODOS') {
                            $cantidad_ventas_fisico->where("detalle_ventas.producto_id", $producto_id);
                        }
                        $cantidad_ventas_fisico = $cantidad_ventas_fisico->count();
                        $suma_semestres_ecommerce += (float)$cantidad_ventas_ecommerce;
                        $suma_semestres_fisico += (float)$cantidad_ventas_fisico;
                    }
                    if ($total_ventas > 0) {
                        $series[0]["data"][] = (float)round($suma_semestres_ecommerce / $total_ventas, 2);
                        $series[1]["data"][] = (float)round($suma_semestres_fisico / $total_ventas, 2);
                    } else {
                        $series[0]["data"][] = 0;
                        $series[1]["data"][] = 0;
                    }
                }
            }
        }

        if ($filtro_fecha == 'ANUAL') {
            $primera_venta = Venta::first();
            $ultima_venta = Venta::get()->last();
            $anio_uv = date("Y", strtotime($ultima_venta->fecha_venta));
            $anio_inicial = date("Y", strtotime($primera_venta->fecha_registro));
            $anio_actual = date("Y");
            $ultimo_anio = $anio_actual;
            if ($anio_uv  >=  $anio_actual) {
                $ultimo_anio = $anio_uv;
            }

            $aux_ini = $anio_inicial . "-01-31";
            $aux_fin = $ultimo_anio . "-12-31";
            $cantidad_ventas_ecommerce = Venta::whereBetween("ventas.fecha_registro", [$aux_ini, $aux_fin]);
            $total_ventas = $cantidad_ventas_ecommerce->count();


            for ($i = $anio_inicial; $i <= $ultimo_anio; $i++) {
                $categories[] = $i;
                $fecha_busqueda = $i . "-";
                $cantidad_ventas_ecommerce = Venta::join("detalle_ventas", "detalle_ventas.venta_id", "=", "ventas.id")->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                    ->where("ventas.tipo", "ECOMMERCE");
                if ($producto_id != 'TODOS') {
                    $cantidad_ventas_ecommerce->where("detalle_ventas.producto_id", $producto_id);
                }
                $cantidad_ventas_ecommerce = $cantidad_ventas_ecommerce->count();

                $cantidad_ventas_fisico = Venta::join("detalle_ventas", "detalle_ventas.venta_id", "=", "ventas.id")->where("ventas.fecha_registro", "LIKE", "$fecha_busqueda%")
                    ->where("ventas.tipo", "FISICO");
                if ($producto_id != 'TODOS') {
                    $cantidad_ventas_fisico->where("detalle_ventas.producto_id", $producto_id);
                }
                $cantidad_ventas_fisico = $cantidad_ventas_fisico->count();

                if ($total_ventas > 0) {
                    $series[0]["data"][] = (float)round($cantidad_ventas_ecommerce / $total_ventas, 2);
                    $series[1]["data"][] = (float)round($cantidad_ventas_fisico / $total_ventas, 2);
                } else {
                    $series[0]["data"][] = 0;
                    $series[1]["data"][] = 0;
                }
            }
        }

        if ($canal != 'TODOS') {
            if ($canal == 'ECOMMERCE') {
                unset($series[1]);
                $series = array_values($series);
            }
            if ($canal == 'FISICO') {
                unset($series[0]);
                $series = array_values($series);
            }
        }
        $fecha = date("d/m/Y");
        return response()->JSON([
            "sw" => true,
            "categories" => $categories,
            "series" => $series,
            "fecha" => $fecha,
        ]);
    }

    public function envios_campania(Request $request)
    {
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $campania_id =  $request->campania_id;

        $campanias = Campania::select("campanias.*")->get();
        if ($campania_id != 'TODOS') {
            $campanias = Campania::select("campanias.*")->where("id", $campania_id)->get();
        }
        $data = [];
        foreach ($campanias as $campania) {
            $total_fisicos = CampaniaEnvio::where("campania_id", $campania->id)
                ->whereBetween("fecha_envio", [$fecha_ini, $fecha_fin])->sum("total_fisicos");
            $total_ecommerce = CampaniaEnvio::where("campania_id", $campania->id)
                ->whereBetween("fecha_envio", [$fecha_ini, $fecha_fin])->sum("total_ecommerce");
            $cantidad = $total_fisicos + $total_ecommerce;
            $data[] = [$campania->nombre, $cantidad ? (float)$cantidad : 0];
        }

        $fecha = date("d/m/Y");
        return response()->JSON([
            "sw" => true,
            "datos" => $data,
            "fecha" => $fecha
        ]);
    }
    public function envios_campania_pdf(Request $request)
    {
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $campania_id =  $request->campania_id;

        $campanias = Campania::select("campanias.*")->get();
        if ($campania_id != 'TODOS') {
            $campanias = Campania::select("campanias.*")->where("id", $campania_id)->get();
        }

        $pdf = PDF::loadView('reportes.envio_camapanias', compact('campanias'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('envio_camapanias.pdf');
    }
}
