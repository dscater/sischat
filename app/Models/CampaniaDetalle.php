<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CampaniaDetalle extends Model
{
    use HasFactory;

    protected $fillable = [
        "campania_id",
        "cliente_id",
    ];

    public function campania()
    {
        return $this->belongsTo(Campania::class, 'campania_id');
    }


    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }
}
