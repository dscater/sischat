<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Configuracion extends Model
{
    use HasFactory;

    protected $fillable = [
        'nombre_sistema', 'alias', 'razon_social', 'nit', 'ciudad', 'dir',
        'fono', 'web', 'actividad', 'correo', 'logo',
        "servicios", "servicios_img",
        "mision", "mision_img",
        "vision", "vision_img",
        "nosotros", "nosotros_img",
        "facebook",
        "instagram",
        "twitter",
        "youtube",
        "ubicacion",
        "captcha_local",
        "captcha_servidor"
    ];

    protected $appends = ['path_image', "url_servicios_img", "url_mision_img", "url_vision_img", "url_nosotros_img"];
    public function getPathImageAttribute()
    {
        return asset('imgs/' . $this->logo);
    }

    public function getUrlServiciosImgAttribute()
    {
        if ($this->servicios_img) {
            return asset("/imgs/" . $this->servicios_img);
        }
        return "";
    }

    public function getUrlMisionImgAttribute()
    {
        if ($this->mision_img) {
            return asset("/imgs/" . $this->mision_img);
        }
        return "";
    }

    public function getUrlVisionImgAttribute()
    {
        if ($this->vision_img) {
            return asset("/imgs/" . $this->vision_img);
        }
        return "";
    }

    public function getUrlNosotrosImgAttribute()
    {
        if ($this->nosotros_img) {
            return asset("/imgs/" . $this->nosotros_img);
        }
        return "";
    }
}
