<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrdenDetalle extends Model
{
    use HasFactory;

    protected $fillable = [
        "orden_pedido_id",
        "producto_id",
        "cantidad",
        "precio",
        "precio_total",
    ];

    public function orden_pedido()
    {
        return $this->belongsTo(OrdenPedido::class, 'orden_pedido_id');
    }

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'producto_id');
    }
}
