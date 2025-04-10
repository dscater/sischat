<?php

namespace App\Http\Controllers;

use App\Models\EnvioWhatsapp;
use Illuminate\Http\Request;

class EnvioWhatsappController extends Controller
{
    public function url_phone()
    {
        $envio_whatsapp = EnvioWhatsapp::first();
        return response()->JSON($envio_whatsapp);
    }
}
