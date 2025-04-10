<?php

namespace App\Http\Controllers;

use App\Models\Campania;
use App\Models\CampaniaAutomatica;
use App\Models\HistorialAccion;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class CampaniaController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:2',
        'fecha_ini' => 'required|date',
        'fecha_fin' => 'required|date',
        'tipo' => 'required',
        'tipo_cliente' => 'required',
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracteres",
        "fecha_ini.required" => "Este campo es obligatorio",
        "fecha_fin.required" => "Este campo es obligatorio",
        "tipo.required" => "Este campo es obligatorio",
        "tipo_cliente.required" => "Este campo es obligatorio",
        "catalogo_id.required" => "Este campo es obligatorio",
        "producto_id.required" => "Este campo es obligatorio",
        "cantidad_compra.required" => "Este campo es obligatorio",
        "cantidad_compra.min" => "El valor minimo es de :min",
        "campania_clientes.required" => "Este campo es obligatorio",
        "campania_clientes.min" => "Debes seleccionar al menos :min cliente",
    ];

    public function index(Request $request)
    {
        $campanias = Campania::with(["campania_detalles"])->get();
        return response()->JSON(['campanias' => $campanias, 'total' => count($campanias)], 200);
    }

    public function store(Request $request)
    {
        if ($request->tipo == 'CATÁLOGO') {
            $this->validacion["catalogo_id"] = "required";
        }

        if ($request->tipo_cliente == 'PERSONALIZADO') {
            if ($request->filtro_cliente == 'PRODUCTO COMPRADO') {
                $this->validacion["producto_id"] = "required";
            }
            if ($request->filtro_cliente == 'CANTIDAD COMPRA') {
                $this->validacion["cantidad_compra"] = "required|numeric|min:1";
            }
            if ($request->filtro_cliente == 'CLIENTES ESPECIFICOS') {
                $this->validacion["campania_clientes"] = "required|min:1";
            }
        }

        $request->validate($this->validacion, $this->mensajes);
        $request["fecha_registro"] = date("Y-m-d");
        DB::beginTransaction();
        try {
            // crear Campania
            $nueva_campania = Campania::create(array_map('mb_strtoupper', $request->except("campania_detalles", "campania_clientes", "eliminados", "catalogo_id", "producto_id", "producto", "cantidad_compra")));
            if ($request->tipo == 'CATÁLOGO') {
                $nueva_campania->catalogo_id = $request->catalogo_id;
            }

            if ($request->tipo_cliente == 'PERSONALIZADO') {
                if ($request->filtro_cliente == 'PRODUCTO COMPRADO') {
                    $nueva_campania->producto_id = $request->producto_id;
                }
                if ($request->filtro_cliente == 'CANTIDAD COMPRA') {
                    $nueva_campania->cantidad_compra = $request->cantidad_compra;
                }
                if ($request->filtro_cliente == 'CLIENTES ESPECIFICOS') {
                    foreach ($request->campania_clientes as $value) {
                        $nueva_campania->campania_detalles()->create([
                            "cliente_id" => $value,
                        ]);
                    }
                }
            }

            $nueva_campania->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_campania, "campanias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN CAMPAÑA',
                'datos_original' => $datos_original,
                'modulo' => 'CAMPAÑAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'campania' => $nueva_campania,
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

    public function update(Request $request, Campania $campania)
    {
        if ($request->tipo == 'CATÁLOGO') {
            $this->validacion["catalogo_id"] = "required";
        }

        if ($request->tipo_cliente == 'PERSONALIZADO') {
            if ($request->filtro_cliente == 'PRODUCTO COMPRADO') {
                $this->validacion["producto_id"] = "required";
            }
            if ($request->filtro_cliente == 'CANTIDAD COMPRA') {
                $this->validacion["cantidad_compra"] = "required|numeric|min:1";
            }
            if ($request->filtro_cliente == 'CLIENTES ESPECIFICOS') {
                $this->validacion["campania_clientes"] = "required|min:1";
            }
        }

        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($campania, "campanias");
            $campania->update(array_map('mb_strtoupper', $request->except("campania_detalles", "campania_clientes", "eliminados", "catalogo_id", "producto", "producto_id", "cantidad_compra")));
            if ($request->tipo == 'CATÁLOGO') {
                $campania->catalogo_id = $request->catalogo_id;
            }

            if ($request->tipo_cliente == 'PERSONALIZADO') {
                if ($request->filtro_cliente == 'PRODUCTO COMPRADO') {
                    $campania->producto_id = $request->producto_id;
                }
                if ($request->filtro_cliente == 'CANTIDAD COMPRA') {
                    $campania->cantidad_compra = $request->cantidad_compra;
                }
                if ($request->filtro_cliente == 'CLIENTES ESPECIFICOS') {
                    $campania->campania_detalles()->delete();
                    foreach ($request->campania_clientes as $value) {
                        $campania->campania_detalles()->create([
                            "cliente_id" => $value,
                        ]);
                    }
                }
            }
            $campania->save();
            $datos_nuevo = HistorialAccion::getDetalleRegistro($campania, "campanias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN CAMPAÑA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'CAMPAÑAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'campania' => $campania,
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

    public function show(Campania $campania)
    {
        return response()->JSON([
            'sw' => true,
            'campania' => $campania->load(["producto", "campania_detalles.cliente"])
        ], 200);
    }

    public function destroy(Campania $campania)
    {
        DB::beginTransaction();
        try {
            $existe = CampaniaAutomatica::where("campania_id", $campania->id)->get();
            if (count($existe) > 0) {
                throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            }

            $campania->campania_detalles()->delete();
            $datos_original = HistorialAccion::getDetalleRegistro($campania, "campanias");
            $campania->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN CAMPAÑA',
                'datos_original' => $datos_original,
                'modulo' => 'CAMPAÑAS',
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

    public function enviarCampania(Campania $campania)
    {
        DB::beginTransaction();
        try {
            Campania::realizaEnvioCampania($campania, true, true);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'La campaña se envío correctamente'
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
