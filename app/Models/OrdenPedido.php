<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrdenPedido extends Model
{
    use HasFactory;

    protected $fillable = [
        "codigo",
        "nro",
        "configuracion_pago_id",
        "celular",
        "comprobante",
        "lat",
        "lng",
        "total",
        "entrega",
        "cupon",
        "descuento",
        "total_final",
        "estado",
        "user_id",
        "status",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t", "url_comprobante"];

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function getUrlComprobanteAttribute()
    {
        return asset("imgs/comprobantes/" . $this->comprobante);
    }

    public function configuracion_pago()
    {
        return $this->belongsTo(ConfiguracionPago::class, 'configuracion_pago_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function venta()
    {
        return $this->hasOne(Venta::class, 'orden_pedido_id');
    }

    public function comprobantes()
    {
        return $this->hasMany(OrdenDetalle::class, 'orden_pedido_id');
    }

    public function orden_detalles()
    {
        return $this->hasMany(OrdenDetalle::class, 'orden_pedido_id');
    }

    public static function getNuevoCodigo()
    {
        $ultimo = OrdenPedido::orderBy("id", "desc")->first();
        if ($ultimo) {
            $nuevo_nro = (int)$ultimo->nro + 1;
            return ["ORD." . $nuevo_nro, $nuevo_nro];
        }

        return ["ORD.1", 1];
    }
}
