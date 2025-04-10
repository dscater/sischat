<?php

namespace App\Http\Controllers;

use App\Models\EnvioWhatsapp;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Twilio\Rest\Client;

class EnviarWhatsappController extends Controller
{
    public static function enviarMensaje($mensaje, $numero)
    {
        $envio_whatsapp = EnvioWhatsapp::first();
        if ($envio_whatsapp) {
            // VONAGE-NEXMO
            $apiKey = $envio_whatsapp->sid;
            $apiSecret = $envio_whatsapp->token;
            $fromNumber = $envio_whatsapp->from;
            $toNumber = "591" . $numero;
            $data = array(
                'from' => $fromNumber,
                'to' => $toNumber,
                'message_type' => 'text',
                'text' => $mensaje,
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
            Log::debug("*******************************");
            Log::debug($response);
            return $response;
        }

        return false;
    }

    public static function enviarMensajeMultimedia($mensaje, $numero, $array_multimedia)
    {
        $envio_whatsapp = EnvioWhatsapp::first();
        if ($envio_whatsapp) {
            $res = self::enviarMensaje($mensaje, $numero);

            foreach ($array_multimedia as $am) {
                self::enviarImagenes($am, $numero);
                sleep(1);
            }

            return true;
        }

        return false;
    }

    public static function enviarImagenes($url_imagen, $numero)
    {

        $envio_whatsapp = EnvioWhatsapp::first();
        if ($envio_whatsapp) {
            $apiKey = $envio_whatsapp->sid;
            $apiSecret = $envio_whatsapp->token;
            $fromNumber = $envio_whatsapp->from;
            $toNumber = "591" . $numero;
            $data = array(
                'from' => $fromNumber,
                'to' => $toNumber,
                'message_type' => 'image',
                'image' => [
                    "url" => $url_imagen,
                    "caption" => $url_imagen,
                ],
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
            return true;
        }
        return false;
    }
}
