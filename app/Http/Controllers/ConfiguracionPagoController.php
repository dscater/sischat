<?php

namespace App\Http\Controllers;

use App\Models\ConfiguracionPago;
use App\Models\HistorialAccion;
use App\Models\OrdenPedido;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ConfiguracionPagoController extends Controller
{
    public $validacion = [
        'banco' => 'required|min:3',
        'nro_cuenta' => 'required|min:2|regex:/^[0-9-]+$/',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $configuracion_pagos = ConfiguracionPago::all();
        return response()->JSON(['configuracion_pagos' => $configuracion_pagos, 'total' => count($configuracion_pagos)], 200);
    }

    public function store(Request $request)
    {
        $this->validacion['qr'] = 'image|mimes:jpeg,jpg,png,webp,gif|max:2048';
        $request->validate($this->validacion, $this->mensajes);
        $request["fecha_registro"] = date("Y-m-d");
        DB::beginTransaction();
        try {
            // crear ConfiguracionPago
            $nueva_configuracion_pago = ConfiguracionPago::create(array_map('mb_strtoupper', $request->except("qr")));
            if ($request->hasFile('qr')) {
                $file = $request->qr;
                $nom_qr = time() . '_' . $nueva_configuracion_pago->id . '.' . $file->getClientOriginalExtension();
                $nueva_configuracion_pago->qr = $nom_qr;
                $file->move(public_path() . '/imgs/configuracion_pagos', $nom_qr);
                $nueva_configuracion_pago->save();
            }
            $datos_original = HistorialAccion::getDetalleRegistro($nueva_configuracion_pago, "configuracion_pagos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA CONFIGURACION DE PAGO',
                'datos_original' => $datos_original,
                'modulo' => 'CONFIGURACION DE PAGOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'configuracion_pago' => $nueva_configuracion_pago,
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

    public function update(Request $request, ConfiguracionPago $configuracion_pago)
    {
        if ($request->hasFile('qr')) {
            $this->validacion['qr'] = 'image|mimes:jpeg,jpg,png,webp,gif|max:2048';
        }

        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($configuracion_pago, "configuracion_pagos");
            $configuracion_pago->update(array_map('mb_strtoupper', $request->except("qr")));
            if ($request->hasFile('qr')) {
                $antiguo = $configuracion_pago->qr;
                if ($antiguo != 'default.png') {
                    \File::delete(public_path() . '/imgs/configuracion_pagos/' . $antiguo);
                }
                $file = $request->qr;
                $nom_qr = time() . '_' . $configuracion_pago->id . '.' . $file->getClientOriginalExtension();
                $configuracion_pago->qr = $nom_qr;
                $file->move(public_path() . '/imgs/configuracion_pagos', $nom_qr);
                $configuracion_pago->save();
            }
            $datos_nuevo = HistorialAccion::getDetalleRegistro($configuracion_pago, "configuracion_pagos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA CONFIGURACION DE PAGO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'CONFIGURACION DE PAGOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'configuracion_pago' => $configuracion_pago,
                'msj' => 'El registro se actualizó de forma correcta'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(ConfiguracionPago $configuracion_pago)
    {
        return response()->JSON([
            'sw' => true,
            'configuracion_pago' => $configuracion_pago
        ], 200);
    }

    public function destroy(ConfiguracionPago $configuracion_pago)
    {
        DB::beginTransaction();
        try {
            $existe = OrdenPedido::where("configuracion_pago_id", $configuracion_pago->id)->get();
            if (count($existe) > 0) {
                throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            }

            $antiguo = $configuracion_pago->qr;
            if ($antiguo != 'default.png') {
                \File::delete(public_path() . '/imgs/configuracion_pagos/' . $antiguo);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($configuracion_pago, "configuracion_pagos");
            $configuracion_pago->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA CONFIGURACION DE PAGO',
                'datos_original' => $datos_original,
                'modulo' => 'CONFIGURACION DE PAGOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'msj' => 'El registro se eliminó correctamente'
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
