<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ApiMap extends Model
{
    use HasFactory;

    protected $fillable = [
        "google_maps",
        "map_id",
    ];
}
