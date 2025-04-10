<?php

namespace App\Http\Controllers;

use App\Models\Campania;
use App\Models\Catalogo;
use App\Models\CatalogoDetalle;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CatalogoController extends Controller
{
    public $validacion = [
        'nombre' => 'required|min:2',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $catalogos = Catalogo::with(["catalogo_detalles"])->get();
        return response()->JSON(['catalogos' => $catalogos, 'total' => count($catalogos)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Catalogo
            $nuevo_catalogo = Catalogo::create(array_map('mb_strtoupper', $request->except("catalogo_detalles", "eliminados")));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_catalogo, "catalogos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN CATALOGO',
                'datos_original' => $datos_original,
                'modulo' => 'CATALOGOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            if (isset($request->catalogo_detalles)) {
                foreach ($request->catalogo_detalles as $value) {
                    $nuevo_catalogo->catalogo_detalles()->create([
                        "producto_id" => $value["producto_id"]
                    ]);
                }
            }

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'catalogo' => $nuevo_catalogo,
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

    public function update(Request $request, Catalogo $catalogo)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($catalogo, "catalogos");
            $catalogo->update(array_map('mb_strtoupper', $request->except("catalogo_detalles", "eliminados")));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($catalogo, "catalogos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN CATALOGO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'CATALOGOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            if (isset($request->eliminados)) {
                foreach ($request->eliminados as $value) {
                    $catalogo_detalle = CatalogoDetalle::find($value);
                    $catalogo_detalle->delete();
                }
            }


            if (isset($request->catalogo_detalles)) {
                foreach ($request->catalogo_detalles as $value) {
                    if ($value["id"] == 0) {
                        $catalogo->catalogo_detalles()->create([
                            "producto_id" => $value["producto_id"]
                        ]);
                    }
                }
            }

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'catalogo' => $catalogo,
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

    public function show(Catalogo $catalogo)
    {
        return response()->JSON([
            'sw' => true,
            'catalogo' => $catalogo->load(["catalogo_detalles.producto"])
        ], 200);
    }

    public function destroy(Catalogo $catalogo)
    {
        DB::beginTransaction();
        try {
            $existe = Campania::where("catalogo_id", $catalogo->id)->get();
            if (count($existe) > 0) {
                throw new Exception('No es posible eliminar el registro debido a que existen registros que lo utilizan');
            }

            $catalogo->catalogo_detalles()->delete();
            $datos_original = HistorialAccion::getDetalleRegistro($catalogo, "catalogos");
            $catalogo->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN CATALOGO',
                'datos_original' => $datos_original,
                'modulo' => 'CATALOGOS',
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
