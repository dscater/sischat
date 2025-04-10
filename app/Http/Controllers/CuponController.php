<?php

namespace App\Http\Controllers;

use App\Models\Cupon;
use App\Models\HistorialAccion;
use App\Models\OrdenPedido;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CuponController extends Controller
{
    public $validacion = [
        'texto' => 'required|min:2',
        'descuento' => 'required|numeric|min:0|max:100',
    ];

    public $mensajes = [
        "texto.required" => "Este campo es obligatorio",
        "texto.min" => "Debes ingresar por lo menos :min caracteres",
        "descuento.required" => "Este campo es obligatorio",
        "descuento.numeric" => "Este campo debe ser númerico",
        "texto.required" => "Este campo es obligatorio",
    ];

    public function index(Request $request)
    {
        $cupons = Cupon::all();
        return response()->JSON(['cupons' => $cupons, 'total' => count($cupons)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Cupon
            $nuevo_cupon = Cupon::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_cupon, "cupons");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN CUPON',
                'datos_original' => $datos_original,
                'modulo' => 'CUPONES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'cupon' => $nuevo_cupon,
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

    public function update(Request $request, Cupon $cupon)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($cupon, "cupons");
            $cupon->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($cupon, "cupons");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN CUPON',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'CUPONES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'cupon' => $cupon,
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

    public function veririca_cupon(Request $request)
    {
        $cupon = Cupon::where("texto", $request->texto_cupon)->get()->first();

        if ($cupon) {
            return response()->JSON([
                "sw" => true,
                "cupon" => $cupon,
            ]);
        }

        return response()->JSON([
            "cupon" => null,
            "sw" => false
        ]);
    }

    public function show(Cupon $cupon)
    {
        return response()->JSON([
            'sw' => true,
            'cupon' => $cupon
        ], 200);
    }

    public function destroy(Cupon $cupon)
    {
        DB::beginTransaction();
        try {
            // $existe = OrdenPedido::where("cupon_id", $cupon->id)->get();
            // if (count($existe) > 0) {
            //     throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            // }

            $datos_original = HistorialAccion::getDetalleRegistro($cupon, "cupons");
            $cupon->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN CUPON',
                'datos_original' => $datos_original,
                'modulo' => 'CUPONES',
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
