<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class CorreoOrdenProcesada extends Mailable
{
    use Queueable, SerializesModels;


    public $orden_pedido;
    public $orden_detalles;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($orden_pedido, $orden_detalles)
    {
        $this->orden_pedido = $orden_pedido;
        $this->orden_detalles = $orden_detalles;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('mail.orden_procesada')
            ->subject('Orden de Pedido Procesada');
    }
}
