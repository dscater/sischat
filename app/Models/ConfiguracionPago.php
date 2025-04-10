<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ConfiguracionPago extends Model
{
    use HasFactory;

    protected $fillable = [
        "banco",
        "nro_cuenta",
        "qr",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t", "url_qr"];

    public function getUrlQrAttribute()
    {
        return asset("imgs/configuracion_pagos/" . $this->qr);
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }
}
