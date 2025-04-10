<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EnvioWhatsapp extends Model
{
    use HasFactory;
    protected $fillable = [
        "sid",
        "token",
        "from",
        "url_phone"
    ];
}
