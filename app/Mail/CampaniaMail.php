<?php

namespace App\Mail;

use App\Models\Configuracion;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class CampaniaMail extends Mailable
{
    use Queueable, SerializesModels;

    public $campania;
    public $mensaje;
    public $array_multimedias;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($campania, $mensaje, $array_multimedias)
    {
        $this->campania = $campania;
        $this->mensaje = $mensaje;
        $this->array_multimedias = $array_multimedias;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $configuracion = Configuracion::first();
        $razon_social = "SISCRM";
        if ($configuracion) {
            $razon_social = $configuracion->razon_social;
        }
        return $this->view('mail.campania')->subject($razon_social);
    }
}
