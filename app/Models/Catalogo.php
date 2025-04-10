<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Catalogo extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre"
    ];

    public function catalogo_detalles()
    {
        return $this->hasMany(CatalogoDetalle::class, 'catalogo_id');
    }
}
