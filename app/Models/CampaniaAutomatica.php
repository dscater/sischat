<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CampaniaAutomatica extends Model
{
    use HasFactory;

    protected $fillable = [
        "campania_id",
        "tipo",
        "fecha_registro",
        "fecha_ini",
        "fecha_fin",
        "frecuencia",
        "dias",
    ];

    protected $appends = ["fecha_registro_t", "fecha_ini_t", "fecha_fin_t", "array_dias"];

    public function getArrayDiasAttribute()
    {
        if ($this->dias) {
            return explode(",", $this->dias);
        }
        return [];
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_Registro));
    }


    public function getFechaIniTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_ini));
    }


    public function getFechaFinTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_fin));
    }

    public function campania()
    {
        return $this->belongsTo(Campania::class, 'campania_id');
    }
}
