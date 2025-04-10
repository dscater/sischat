<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CampaniaEnvio extends Model
{
    use HasFactory;

    protected $fillable = [
        "campania_id",
        "campania_automatica_id",
        "fecha_envio",
        "total_fisicos",
        "total_ecommerce",
    ];

    public function campania()
    {
        return $this->belongsTo(Campania::class, 'campania_id');
    }

    public function campania_automatica()
    {
        return $this->belongsTo(CampaniaAutomatica::class, 'campania_automatica_id');
    }
}
