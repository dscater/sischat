<?php

namespace App\Http\Controllers;

use App\Models\Campania;
use App\Models\CampaniaAutomatica;
use App\Models\Configuracion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Http;

class LoginController extends Controller
{
    public function login(Request $request)
    {

        $request->validate([
            "captcha" => "required",
            "usuario" => "required",
            "password" => "required"
        ]);

        $usuario = $request->usuario;
        $password = $request->password;
        $res = Auth::attempt(['usuario' => $usuario, 'password' => $password]);

        if ($res) {
            if (Auth::user()->acceso == 1) {

                if (Auth::user()->tipo == 'ADMINISTRADOR' || Auth::user()->tipo == 'GERENCIA' || Auth::user()->tipo == 'SUPERVISOR' || Auth::user()->tipo == 'VENDEDOR') {
                    self::envioMensajesAutomaticos();
                }
                return response()->JSON([
                    'user' => Auth::user(),
                ], 200);
            } else {
                Auth::logout();
                return response()->JSON([
                    "message" => "Acceso restringido"
                ], 401);
            }
        }
        return response()->JSON([], 401);
    }


    public function verifica_captcha(Request $request)
    {
        $configuracion = Configuracion::first();

        $response = Http::asForm()->post("https://www.google.com/recaptcha/api/siteverify", [
            // "secret" => '6LfLgEAkAAAAAEUx6mam_35HPbm5DUl0u4bfHKay',
            "secret" => $configuracion->captcha_servidor,
            "response" => $request->input("g-recaptcha-response")
        ])->object();
        return response()->JSON($response);
    }

    public function logout()
    {
        Auth::logout();
        return response()->JSON(['code' => 204], 204);
    }

    public function auth()
    {
        if (Auth::check()) {
            return response()->JSON(Auth::user());
        }

        return response()->JSON(null);
    }

    public static function envioMensajesAutomaticos()
    {
        $fecha_actual = date("Y-m-d");
        // con rango de fechas
        $automaticos_fechas = CampaniaAutomatica::where("frecuencia", "RANGO DE FECHAS")
            ->where("fecha_ini", "<=", $fecha_actual)
            ->where("fecha_fin", ">=", $fecha_actual)
            ->get();
        foreach ($automaticos_fechas  as $item) {
            $campania = $item->campania;
            $envio_correo = false;
            $envio_whatsapp = false;
            try {
                if ($item->tipo == 'TODOS') {
                    $envio_correo = true;
                    $envio_whatsapp = true;
                } else {
                    if ($item->tipo == 'CORREO') {
                        $envio_correo = true;
                    } else {
                        $envio_whatsapp = true;
                    }
                }

                Campania::realizaEnvioCampania($campania, $envio_correo, $envio_whatsapp);
            } catch (\Exception $e) {
                Log::debug("Error envio: " . $e->getMessage());
            }
        }

        // DIAS MES
        $automaticos_dias = CampaniaAutomatica::where("frecuencia", "DÍAS")
            ->get();
        foreach ($automaticos_dias as $item) {
            $campania = $item->campania;
            // validar fecha
            if ($fecha_actual >= $campania->fecha_ini && $fecha_actual <= $campania->fecha_fin) {
                // armar fechas
                $array_dias = $item->array_dias;
                $dia_actual = date("d", strtotime($fecha_actual));
                if (in_array($dia_actual, $array_dias)) {
                    try {
                        if ($item->tipo == 'TODOS') {
                            $envio_correo = true;
                            $envio_whatsapp = true;
                        } else {
                            if ($item->tipo == 'CORREO') {
                                $envio_correo = true;
                            } else {
                                $envio_whatsapp = true;
                            }
                        }

                        Campania::realizaEnvioCampania($campania, $envio_correo, $envio_whatsapp);
                    } catch (\Exception $e) {
                        Log::debug("Error envio: " . $e->getMessage());
                    }
                }
            }
        }
        return true;
    }
}
