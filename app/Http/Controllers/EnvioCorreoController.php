<?php

namespace App\Http\Controllers;

use App\Mail\CampaniaMail;
use App\Mail\CorreoOrdenProcesada;
use App\Mail\CorreoRecuperacion;
use App\Mail\MensajePortal;
use App\Models\Configuracion;
use App\Models\EnvioCorreo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Config;

class EnvioCorreoController extends Controller
{
    public static function mensajeOrdenProcesada($orden_pedido)
    {
        $envio_correo = EnvioCorreo::first();
        if ($envio_correo) {
            // Configurar el servicio de correo con la configuración de Gmail dinámicamente
            Config::set([
                'mail.mailers.smtp.host' => $envio_correo->host,
                'mail.mailers.smtp.port' => $envio_correo->puerto,
                'mail.mailers.smtp.encryption' => $envio_correo->encriptado,
                'mail.mailers.smtp.username' => $envio_correo->email,
                'mail.mailers.smtp.password' => $envio_correo->password,
                'mail.from.address' => $envio_correo->email,
                'mail.from.name' => $envio_correo->nombre,
            ]);

            Mail::to($orden_pedido->user->cliente->correo)
                ->send(new CorreoOrdenProcesada($orden_pedido, $orden_pedido->orden_detalles));

            return true;
        }
        return false;
    }

    public static function mensajeRecuperacion($correo, $mensaje)
    {
        $envio_correo = EnvioCorreo::first();
        if ($envio_correo) {
            // Configurar el servicio de correo con la configuración de Gmail dinámicamente
            Config::set([
                'mail.mailers.smtp.host' => $envio_correo->host,
                'mail.mailers.smtp.port' => $envio_correo->puerto,
                'mail.mailers.smtp.encryption' => $envio_correo->encriptado,
                'mail.mailers.smtp.username' => $envio_correo->email,
                'mail.mailers.smtp.password' => $envio_correo->password,
                'mail.from.address' => $envio_correo->email,
                'mail.from.name' => $envio_correo->nombre,
            ]);

            Mail::to($correo)
                ->send(new CorreoRecuperacion($mensaje));

            return true;
        }
        return false;
    }

    public static function mensajeCampania($correo, $campania, $mensaje, $array_multimedias)
    {
        $envio_correo = EnvioCorreo::first();
        if ($envio_correo) {
            // Configurar el servicio de correo con la configuración de Gmail dinámicamente
            Config::set([
                'mail.mailers.smtp.host' => $envio_correo->host,
                'mail.mailers.smtp.port' => $envio_correo->puerto,
                'mail.mailers.smtp.encryption' => $envio_correo->encriptado,
                'mail.mailers.smtp.username' => $envio_correo->email,
                'mail.mailers.smtp.password' => $envio_correo->password,
                'mail.from.address' => $envio_correo->email,
                'mail.from.name' => $envio_correo->nombre,
            ]);

            Mail::to($correo)
                ->send(new CampaniaMail($campania, $mensaje, $array_multimedias));

            return true;
        }
        return false;
    }

    public function correo_portal(Request $request)
    {

        $request->validate([
            "nombre" => "required|min:2",
            "asunto" => "required|min:2",
            "correo" => "required|min:2|email",
            "mensaje" => "required|min:2",
        ], [
            "nombre.required" => "Este campo es obligatorio",
            "nombre.min" => "Debes ingresar al menos :min caracteres",

            "asunto.required" => "Este campo es obligatorio",
            "asunto.min" => "Debes ingresar al menos :min caracteres",

            "correo.required" => "Este campo es obligatorio",
            "correo.email" => "Debes ingresar un correo valido",
            "correo.min" => "Debes ingresar al menos :min caracteres",

            "mensaje.required" => "Este campo es obligatorio",
            "mensaje.min" => "Debes ingresar al menos :min caracteres",
        ]);

        try {
            $envio_correo = EnvioCorreo::first();
            $configuracion = Configuracion::first();
            Config::set([
                'mail.mailers.smtp.host' => $envio_correo->host,
                'mail.mailers.smtp.port' => $envio_correo->puerto,
                'mail.mailers.smtp.encryption' => $envio_correo->encriptado,
                'mail.mailers.smtp.username' => $envio_correo->email,
                'mail.mailers.smtp.password' => $envio_correo->password,
                'mail.from.address' => $envio_correo->email,
                'mail.from.name' => $envio_correo->nombre,
            ]);


            $datos = [
                "nombre" => $request->nombre,
                "asunto" => $request->asunto,
                "correo" => $request->correo,
                "fono" => $request->fono,
                "mensaje" => $request->mensaje,
            ];

            Mail::to($configuracion->correo)
                ->send(new MensajePortal($datos));


            return response()->JSON([
                "message" => "Tu mensaje se envío con éxito"
            ], 200);
        } catch (\Exception $e) {
            return response()->JSON([
                "message" => $e->getMessage()
            ], 500);
        }
    }

    public function pruebas()
    {
        // VONAGE - NEXMO
        $apiKey = 'cc391a2f';
        $apiSecret = 'X3YWsIkHDjFs4gxR';
        $fromNumber = '14157386102';
        $toNumber = '59173594451'; // Reemplaza $TO_NUMBER con el número de destino
        $message = 'Mensaje de prueba';

        $data = array(
            'from' => $fromNumber,
            'to' => $toNumber,
            'message_type' => 'text',
            'text' => $message,
            'channel' => 'whatsapp'
        );

        $ch = curl_init('https://messages-sandbox.nexmo.com/v1/messages');
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-Type: application/json',
            'Accept: application/json'
        ));
        curl_setopt($ch, CURLOPT_USERPWD, $apiKey . ':' . $apiSecret);

        $response = curl_exec($ch);
        curl_close($ch);

        echo $response;
    }



    // public function pruebas()
    // {
    //     // Datos de la solicitud
    //     $url = 'https://graph.facebook.com/v19.0/285515087983710/messages';
    //     $accessToken = 'EAAGRiodRKZCoBO9idqZCqHJXI2wrKeonB8pNM6XVu2c9WKoZCudV0wZAG29QSfhPpkuP1jQCWn9kUkNjzZA4FaEGsd7rU7sQJvTBXkHm2UPt5qO2TiSWgPIUbWM2isW5Uhft9LrFPt2r5hpYk3ly0qwcEZCkvq0mT3saxqtvGmsQRE8pSBwxYoZAZCHO76ASWumtds1ECOdkg1WLEYDQPYZB6Gn1d2tEZD';
    //     $headers = array(
    //         'Authorization: Bearer ' . $accessToken,
    //         'Content-Type: application/json'
    //     );

    //     // Datos del mensaje
    //     $data = array(
    //         'messaging_product' => 'whatsapp',
    //         'to' => '59173594451',
    //         'type' => 'template',
    //         'template' => array(
    //             'name' => 'hello_world',
    //             'language' => array(
    //                 'code' => 'en_US'
    //             )
    //         )
    //     );

    //     // Convertir los datos a formato JSON
    //     $postData = json_encode($data);

    //     // Inicializar cURL
    //     $ch = curl_init();

    //     // Configurar la solicitud cURL
    //     curl_setopt($ch, CURLOPT_URL, $url);
    //     curl_setopt($ch, CURLOPT_POST, true);
    //     curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
    //     curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    //     curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    //     // Ejecutar la solicitud y obtener la respuesta
    //     $response = curl_exec($ch);

    //     // Comprobar si hay errores
    //     if (curl_errno($ch)) {
    //         echo 'Error: ' . curl_error($ch);
    //     }

    //     // Cerrar cURL
    //     curl_close($ch);

    //     // Imprimir la respuesta
    //     echo $response;
    // }
}
