<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre",
        "apellidos",
        "ci",
        "ci_exp",
        "nit",
        "fono",
        "correo",
        "dir",
        "user_id",
        "tipo",
        "fecha_registro",
    ];

    protected $appends = ["full_name", "full_ci"];

    public function getFullNameAttribute()
    {
        return $this->nombre . ($this->apellidos ? ' ' . $this->apellidos : '');
    }

    public function getFullCiAttribute()
    {
        return $this->ci . ' ' . $this->ci_exp;
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
