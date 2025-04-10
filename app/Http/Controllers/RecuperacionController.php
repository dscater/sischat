<?php

namespace App\Http\Controllers;

use App\Models\Recuperacion;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class RecuperacionController extends Controller
{
    public function olvide_mi_contrasenia()
    {
        return view("FormRecuperacion");
    }

    public function registrar_ci(Request $request)
    {
        $validacion = [
            "ci" => "required",
        ];

        $mensajes = [
            "ci.required" => "Debes ingresar tú número de C.I.",
        ];

        $request->validate($validacion, $mensajes);

        DB::beginTransaction();
        try {
            // buscar usuario
            $user = User::where("ci", $request->ci)->get()->first();
            if (!$user) {
                throw new Exception("No se encontró ningún registro con ese número de C.I., intenta nuevamente");
            }

            $recuperacion = Recuperacion::create([
                "user_id" => $user->id,
            ]);

            $mensaje = 'Haz click en este <a href="' . route('recuperacion', $recuperacion->id) . '">enlace</a> para poder restablecer tu contraseña';


            EnvioCorreoController::mensajeRecuperacion($user->correo, $mensaje);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'Te envíamos un correo para que puedas continuar con la recuperación de tu contraseña',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function recuperacion(Recuperacion $recuperacion)
    {
        return view("Recuperacion", compact("recuperacion"));
    }

    public function registro_recuperacion(Recuperacion $recuperacion, Request $request)
    {
        if ($recuperacion->recuperado != 0) {
            throw new Exception("Este link de recuperación ya fue usado. Vuelva a solicitar una nueva recuperación");
        }

        $request->validate(
            [
                'password' => 'required|string|min:8|confirmed'
            ],
            [
                "password.required" => "Este campo es obligatorio",
                "password.min" => "Debes ingresar como minimo 8 caracteres",
            ]
        );

        DB::beginTransaction();
        try {

            $recuperacion->user->password = Hash::make($request->password);
            $recuperacion->user->save();
            $recuperacion->recuperado = 1;
            $recuperacion->save();
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'Contraseña actualizada correctamente',
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
