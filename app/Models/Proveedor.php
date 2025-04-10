<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Proveedor extends Model
{
    use HasFactory;
    protected $fillable = [
        "razon_social", "nit", "dir", "fono", "nombre_contacto", "paterno", "materno",
        "descripcion", "fecha_registro",
    ];

    protected $appends = ['full_name'];
    public function getFullNameAttribute()
    {
        return $this->nombre_contacto . ' ' . ($this->paterno != NULL && $this->paterno != '' ? ' ' . $this->paterno : '') . ($this->materno != NULL && $this->materno != '' ? ' ' . $this->materno : '');
    }
}
