<?php

namespace App\Http\Controllers;

use App\Models\CampaniaAutomatica;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CampaniaAutomaticaController extends Controller
{
    public $validacion = [
        'campania_id' => 'required',
        'tipo' => 'required',
        'frecuencia' => 'required',
    ];

    public $mensajes = [
        "campania_id.required" => "Este campo es obligatorio",
        "tipo.required" => "Este campo es obligatorio",
        "frecuencia.required" => "Este campo es obligatorio",
        "fecha_ini.required" => "Este campo es obligatorio",
        "fecha_fin.required" => "Este campo es obligatorio",
        "array_dias.required" => "Este campo es obligatorio",
    ];

    public function index(Request $request)
    {
        $campania_automaticas = CampaniaAutomatica::with(["campania"])->get();
        return response()->JSON(['campania_automaticas' => $campania_automaticas, 'total' => count($campania_automaticas)], 200);
    }

    public function store(Request $request)
    {
        if ($request->frecuencia == 'RANGO DE FECHAS') {
            $this->validacion["fecha_ini"] = "required|date";
            $this->validacion["fecha_fin"] = "required|date";
        }

        if ($request->frecuencia == 'DÍAS') {
            $this->validacion["array_dias"] = "required|min:1";
        }

        $request->validate($this->validacion, $this->mensajes);
        $request["fecha_registro"] = date("Y-m-d");
        DB::beginTransaction();
        try {
            // crear CampaniaAutomatica
            $nueva_campania_automatica = CampaniaAutomatica::create(array_map('mb_strtoupper', $request->except("array_dias", "fecha_ini", "fecha_fin", "dias")));

            if ($request->frecuencia == 'RANGO DE FECHAS') {
                $nueva_campania_automatica->fecha_ini = $request->fecha_ini;
                $nueva_campania_automatica->fecha_fin = $request->fecha_fin;
            }

            if ($request->frecuencia == 'DÍAS') {
                $nueva_campania_automatica->dias = $request->dias;
            }
            $nueva_campania_automatica->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_campania_automatica, "campania_automaticas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN ENVIO DE CAMPAÑA AUTOMATICA',
                'datos_original' => $datos_original,
                'modulo' => 'ENVIO DE CAMPAÑAS AUTOMATICAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'campania_automatica' => $nueva_campania_automatica,
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

    public function update(Request $request, CampaniaAutomatica $campania_automatica)
    {
        if ($request->frecuencia == 'RANGO DE FECHAS') {
            $this->validacion["fecha_ini"] = "required|date";
            $this->validacion["fecha_fin"] = "required|date";
        }

        if ($request->frecuencia == 'DÍAS') {
            $this->validacion["array_dias"] = "required|min:1";
        }

        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($campania_automatica, "campania_automaticas");
            $campania_automatica->update(array_map('mb_strtoupper', $request->except("array_dias", "fecha_ini", "fecha_fin", "dias")));
            if ($request->frecuencia == 'RANGO DE FECHAS') {
                $campania_automatica->fecha_ini = $request->fecha_ini;
                $campania_automatica->fecha_fin = $request->fecha_fin;
            }

            if ($request->frecuencia == 'DÍAS') {
                $campania_automatica->dias = $request->dias;
            }
            $campania_automatica->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($campania_automatica, "campania_automaticas");

            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN ENVIO DE CAMPAÑA AUTOMATICA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'ENVIO DE CAMPAÑAS AUTOMATICAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'campania_automatica' => $campania_automatica,
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

    public function show(CampaniaAutomatica $campania_automatica)
    {
        return response()->JSON([
            'sw' => true,
            'campania_automatica' => $campania_automatica->load(["campania_automatica_detalles.cliente"])
        ], 200);
    }

    public function destroy(CampaniaAutomatica $campania_automatica)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($campania_automatica, "campania_automaticas");
            $campania_automatica->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN ENVIO DE CAMPAÑA AUTOMATICA',
                'datos_original' => $datos_original,
                'modulo' => 'ENVIO DE CAMPAÑAS AUTOMATICAS',
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
