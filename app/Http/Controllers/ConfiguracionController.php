<?php

namespace App\Http\Controllers;

use App\Models\Configuracion;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ConfiguracionController extends Controller
{
    public function getConfiguracion()
    {
        $configuracion = Configuracion::first();
        if ($configuracion) {
            return response()->JSON([
                'sw' => true,
                'configuracion' => $configuracion
            ]);
        }
        return response()->JSON([
            'sw' => false,
            'msj' => 'No se encontró ninguna configuración'
        ], 200);
    }

    public function update(Request $request)
    {
        $validacion = [
            'nombre_sistema' => 'required|min:4',
            'alias' => 'required|min:1',
            'razon_social' => 'required|min:4',
            'ciudad' => 'required|min:4',
            'dir' => 'required|min:4',
            'fono' => 'required|min:4',
            'correo' => 'nullable|email',
            'actividad' => 'required|min:4',
        ];
        $mensajes =  [
            'nombre_sistema.required' => 'Este campo es obligatorio',
            'nombre_sistema.min' => 'Debes ingresar al menos 4 carácteres',
            'razon_social.required' => 'Este campo es obligatorio',
            'razon_social.min' => 'Debes ingresar al menos 4 carácteres',
            'nit.required' => 'Este campo es obligatorio',
            'ciudad.required' => 'Este campo es obligatorio',
            'ciudad.min' => 'Debes ingresar al menos 4 carácteres',
            'dir.required' => 'Este campo es obligatorio',
            'dir.min' => 'Debes ingresar al menos 4 carácteres',
            'fono.required' => 'Este campo es obligatorio',
            'fono.min' => 'Debes ingresar al menos 4 carácteres',
            'actividad.required' => 'Este campo es obligatorio',
            'actividad.min' => 'Debes ingresar al menos 4 carácteres',
        ];

        if ($request->hasFile('logo')) {
            $validacion['logo'] = 'image|mimes:jpeg,jpg,png,webp|max:4096';
        }

        if ($request->hasFile('servicios_img')) {
            $validacion['servicios_img'] = 'image|mimes:jpeg,jpg,png,webp|max:4096';
        }

        if ($request->hasFile('mision_img')) {
            $validacion['mision_img'] = 'image|mimes:jpeg,jpg,png,webp|max:4096';
        }

        if ($request->hasFile('vision_img')) {
            $validacion['vision_img'] = 'image|mimes:jpeg,jpg,png,webp|max:4096';
        }

        if ($request->hasFile('nosotros_img')) {
            $validacion['nosotros_img'] = 'image|mimes:jpeg,jpg,png,webp|max:4096';
        }
        $request->validate($validacion, $mensajes);

        $configuracion = Configuracion::first();
        if ($configuracion) {
            DB::beginTransaction();
            try {

                $datos_original = HistorialAccion::getDetalleRegistro($configuracion, "configuracions");

                $configuracion->update(array_map('mb_strtoupper', $request->except('logo', 'servicios_img', 'mision_img', 'vision_img', 'nosotros_img')));
                if ($request->hasFile('logo')) {
                    $antiguo = $configuracion->logo;
                    \File::delete(public_path() . '/imgs/' . $antiguo);
                    $file = $request->logo;
                    $nombre = time() . '_logo.' . $file->getClientOriginalExtension();
                    $file->move(public_path() . '/imgs/', $nombre);
                    $configuracion->logo = $nombre;
                }

                if ($request->hasFile('servicios_img')) {
                    $antiguo = $configuracion->servicios_img;
                    \File::delete(public_path() . '/imgs/' . $antiguo);
                    $file = $request->servicios_img;
                    $nombre = time() . '_servicios_img.' . $file->getClientOriginalExtension();
                    $file->move(public_path() . '/imgs/', $nombre);
                    $configuracion->servicios_img = $nombre;
                }

                if ($request->hasFile('mision_img')) {
                    $antiguo = $configuracion->mision_img;
                    \File::delete(public_path() . '/imgs/' . $antiguo);
                    $file = $request->mision_img;
                    $nombre = time() . '_mision_img.' . $file->getClientOriginalExtension();
                    $file->move(public_path() . '/imgs/', $nombre);
                    $configuracion->mision_img = $nombre;
                }

                if ($request->hasFile('vision_img')) {
                    $antiguo = $configuracion->vision_img;
                    \File::delete(public_path() . '/imgs/' . $antiguo);
                    $file = $request->vision_img;
                    $nombre = time() . '_vision_img.' . $file->getClientOriginalExtension();
                    $file->move(public_path() . '/imgs/', $nombre);
                    $configuracion->vision_img = $nombre;
                }

                if ($request->hasFile('nosotros_img')) {
                    $antiguo = $configuracion->nosotros_img;
                    \File::delete(public_path() . '/imgs/' . $antiguo);
                    $file = $request->nosotros_img;
                    $nombre = time() . '_nosotros_img.' . $file->getClientOriginalExtension();
                    $file->move(public_path() . '/imgs/', $nombre);
                    $configuracion->nosotros_img = $nombre;
                }
                $configuracion->facebook = $request->facebook;
                $configuracion->instagram = $request->instagram;
                $configuracion->twitter = $request->twitter;
                $configuracion->youtube = $request->youtube;
                $configuracion->ubicacion = $request->ubicacion;
                $configuracion->save();

                $datos_nuevo = HistorialAccion::getDetalleRegistro($configuracion, "configuracions");
                HistorialAccion::create([
                    'user_id' => Auth::user()->id,
                    'accion' => 'MODIFICACIÓN',
                    'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA',
                    'datos_original' => $datos_original,
                    'datos_nuevo' => $datos_nuevo,
                    'modulo' => 'CONFIGURACIÓN',
                    'fecha' => date('Y-m-d'),
                    'hora' => date('H:i:s')
                ]);

                DB::commit();
                return response()->JSON([
                    'sw' => true,
                    'msj' => 'Los datos se actualizarón de forma correcta',
                    'configuracion' => $configuracion
                ], 200);
            } catch (\Exception $e) {
                DB::rollBack();
                return response()->JSON([
                    'sw' => false,
                    'message' => $e->getMessage(),
                ], 500);
            }
        }
        return response()->JSON([
            'sw' => false,
            'msj' => 'No se encontró ninguna configuración'
        ], 200);
    }


    public function url_asset()
    {
        return asset("");
    }
}
