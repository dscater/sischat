<?php

namespace App\Http\Controllers;

use App\Models\Cupon;
use App\Models\HistorialAccion;
use App\Models\KardexProducto;
use App\Models\OrdenPedido;
use App\Models\Producto;
use App\Models\Venta;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class OrdenPedidoController extends Controller
{
    public $validacion = [
        "productos" => "required|array|min:1",
        "configuracion_pago_id" => "required",
        "comprobante" => "required",
    ];

    public $mensajes = [
        "productos.required" => "Este campo es obligatorio",
        "productos.min" => "Debes seleccionar al menos :min producto",
        "configuracion_pago_id.required" => "Este campo es obligatorio",
        "celular.required" => "Este campo es obligatorio",
        "comprobante.required" => "Este campo es obligatorio",
    ];

    public function index()
    {

        $orden_pedidos = [];
        if (Auth::user()->tipo == 'CLIENTE') {
            $orden_pedidos = OrdenPedido::with(["user"])->where("user_id", Auth::user()->id)->orderby("created_at", "desc")->get();
        } else {
            $orden_pedidos = OrdenPedido::with(["user"])->orderby("created_at", "desc")->get();
        }

        return response()->JSON(['orden_pedidos' => $orden_pedidos, 'total' => count($orden_pedidos)], 200);
    }

    public function registraOrden(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear la OrdenPedido
            $array_codigo = OrdenPedido::getNuevoCodigo();
            $request["codigo"] = $array_codigo[0];
            $request["nro"] = $array_codigo[1];
            $request["user_id"] = Auth::user()->id;
            $request["estado"] = "PEDIDO PENDIENTE";

            // existe cupon
            $cupon = Cupon::where("texto", $request->cupon)->get()->first();
            $p_descuento = 0;
            $request["descuento"] = 0;
            $monto_descuento = 0;
            if ($cupon) {
                // calcular descuento
                $p_descuento = (float)$cupon->descuento / 100;
                $monto_descuento  = (float)$request["total"] * $p_descuento;
                $request["descuento"] = $cupon->descuento;
            }
            $total_con_descuento = (float)$request["total"] - ($monto_descuento);
            $request["total_final"] = $total_con_descuento;

            $nueva_orden_pedido = OrdenPedido::create(array_map('mb_strtoupper', $request->except("productos", "cantidades", "precios", "precio_total")));
            $datos_original = HistorialAccion::getDetalleRegistro($nueva_orden_pedido, "orden_pedidos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->orden_pedido . ' REGISTRO UNA ORDEN DE PEDIDO',
                'datos_original' => $datos_original,
                'modulo' => 'ORDEN DE PEDIDOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            $productos = $request->productos;
            $cantidades = $request->cantidades;
            $precios = $request->precios;
            $precio_total = $request->precio_total;

            foreach ($productos as $key => $producto) {
                $nueva_orden_pedido->orden_detalles()->create([
                    "producto_id" => $producto,
                    "cantidad" => $cantidades[$key],
                    "precio" => $precios[$key],
                    "precio_total" => $precio_total[$key],
                ]);
            }

            if ($request->hasFile('comprobante')) {
                $file = $request->comprobante;
                $nom_comprobante = time() . '_' . $nueva_orden_pedido->id . '.' . $file->getClientOriginalExtension();
                $nueva_orden_pedido->comprobante = $nom_comprobante;
                $file->move(public_path() . '/imgs/comprobantes/', $nom_comprobante);
            }
            $nueva_orden_pedido->save();

            DB::commit();

            return response()->JSON([
                "sw" => true,
                "message" => "Orden de Venta registrada con éxito",
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "sw" => false,
                "message" => "Ocurrió un error: " . $e->getMessage(),
            ], 500);
        }
    }

    public function store(Request $request)
    {
        $this->validacion["qr"] = "required";
        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear la OrdenPedido
            $array_codigo = OrdenPedido::getNuevoCodigo();
            $request["codigo"] = $array_codigo[0];
            $request["nro"] = $array_codigo[1];
            $nueva_orden_pedido = OrdenPedido::create(array_map('mb_strtoupper', $request->except("qr")));
            $datos_original = HistorialAccion::getDetalleRegistro($nueva_orden_pedido, "orden_pedidos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->orden_pedido . ' REGISTRO UNA ORDEN DE PEDIDO',
                'datos_original' => $datos_original,
                'modulo' => 'ORDEN DE PEDIDOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            if ($request->hasFile('qr')) {
                $file = $request->qr;
                $nom_qr = time() . '_' . $nueva_orden_pedido->id . '.' . $file->getClientOriginalExtension();
                $nueva_orden_pedido->qr = $nom_qr;
                $file->move(public_path() . '/imgs/qr/', $nom_qr);
            }
            $nueva_orden_pedido->save();

            DB::commit();
            return redirect()->route("orden_pedidos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(OrdenPedido $orden_pedido)
    {
        $orden_pedido  = $orden_pedido->load(["user.cliente", "orden_detalles.producto", "configuracion_pago"]);
        return response()->JSON([
            "orden_pedido" => $orden_pedido,
        ]);
    }

    public function actualiza_estado(OrdenPedido $orden_pedido, Request $request)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($orden_pedido, "orden_pedidos");
            $orden_pedido->estado = $request->estado;
            $orden_pedido->save();

            $descuento = $orden_pedido->descuento;
            $total_final = $orden_pedido->total_final;
            // REGISTRAR LA VENTA
            $venta = Venta::create([
                "user_id" => Auth::user()->id,
                "cliente_id" => $orden_pedido->user->cliente->id,
                "nit" => $orden_pedido->user->cliente->nit ? $orden_pedido->user->cliente->nit : $orden_pedido->user->cliente->ci,
                "total" => $orden_pedido->total,
                "descuento" => $descuento,
                "total_final" => $total_final,
                "estado" => "CANCELADO",
                "tipo" => "ECOMMERCE",
                "orden_pedido_id" => $orden_pedido->id,
                "fecha_registro" => date("Y-m-d")
            ]);

            foreach ($orden_pedido->orden_detalles as $od) {
                $dv = $venta->detalle_ventas()->create([
                    "producto_id" => $od->producto_id,
                    "cantidad" => $od->cantidad,
                    "precio" => $od->precio,
                    "subtotal" => $od->precio_total,
                ]);

                // registrar kardex
                KardexProducto::registroEgreso("VENTA", $dv->id, $dv->producto, $dv->cantidad, $dv->precio, "VENTA DE PRODUCTO");
            }

            EnvioCorreoController::mensajeOrdenProcesada($orden_pedido, $orden_pedido->orden_detalles);
            $mensaje = "Acabamos de procesar su pedido con código " . $orden_pedido->codigo . "
            
            Puedes ver tú pedido aquí:
            " . url('/administracion/orden_pedidos/show/' . $orden_pedido->id);
            EnviarWhatsappController::enviarMensaje($mensaje, $orden_pedido->celular);

            $datos_nuevo = HistorialAccion::getDetalleRegistro($orden_pedido, "orden_pedidos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->orden_pedido . ' MODIFICÓ UNA ORDEN DE PEDIDO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'ORDEN DE PEDIDOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                "sw" => true,
                "orden_pedido" => $orden_pedido,
                "message" => "La orden se actualizó correctamente",
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "sw" => false,
                "message" => "Ocurrió un error: " . $e->getMessage(),
            ], 500);
        }
    }

    public function update(OrdenPedido $orden_pedido, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($orden_pedido, "orden_pedidos");
            $orden_pedido->update(array_map('mb_strtoupper', $request->except("qr")));
            if ($request->hasFile('qr')) {
                $antiguo = $orden_pedido->qr;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/qr/' . $antiguo);
                }
                $file = $request->qr;
                $nom_qr = time() . '_' . $orden_pedido->id . '.' . $file->getClientOriginalExtension();
                $orden_pedido->qr = $nom_qr;
                $file->move(public_path() . '/imgs/qr/', $nom_qr);
            }
            $orden_pedido->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($orden_pedido, "orden_pedidos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->orden_pedido . ' MODIFICÓ UNA ORDEN DE PEDIDO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'ORDEN DE PEDIDOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'orden_pedido' => $orden_pedido,
                'msj' => 'El registro se realizó de forma correcta',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    public function destroy(OrdenPedido $orden_pedido)
    {
        DB::beginTransaction();
        try {
            // $antiguo = $orden_pedido->comprobante;
            // if ($antiguo != 'default.png') {
            //     \File::delete(public_path() . '/imgs/comprobantes/' . $antiguo);
            // }
            // $orden_pedido->orden_detalles()->delete();
            $datos_original = HistorialAccion::getDetalleRegistro($orden_pedido, "orden_pedidos");
            $orden_pedido->status = 0;
            $orden_pedido->save();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->orden_pedido . ' ANULÓ UNA ORDEN DE PEDIDO',
                'datos_original' => $datos_original,
                'modulo' => 'ORDEN DE PEDIDOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se anuló correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    public function habilitar(OrdenPedido $orden_pedido)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($orden_pedido, "orden_pedidos");
            $orden_pedido->status = 1;
            $orden_pedido->save();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->orden_pedido . ' HABILITO UNA ORDEN DE PEDIDO',
                'datos_original' => $datos_original,
                'modulo' => 'ORDEN DE PEDIDOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se habilito correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
