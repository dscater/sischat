<?php

namespace App\Models;

use App\Http\Controllers\EnviarWhatsappController;
use App\Http\Controllers\EnvioCorreoController;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;

class Campania extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre",
        "fecha_ini",
        "fecha_fin",
        "tipo",
        "tipo_cliente",
        "filtro_cliente",
        "producto_id",
        "cantidad_compra",
        "descripcion",
        "catalogo_id",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t", "fecha_ini_t", "fecha_fin_t", "campania_clientes", "enviable", "enviando"];

    public function getEnviandoAttribute()
    {
        return false;
    }

    public function getEnviableAttribute()
    {
        $fecha_actual = date("Y-m-d");
        if ($fecha_actual >= date("Y-m-d", strtotime($this->fecha_ini)) &&  $fecha_actual <= date("Y-m-d", strtotime($this->fecha_fin))) {
            return true;
        }
        return false;
    }

    public function getFechaIniTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_ini));
    }

    public function getFechaFinTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_fin));
    }


    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }


    public function getCampaniaClientesAttribute()
    {
        $campania_detalles = CampaniaDetalle::where("campania_id", $this->id)->pluck("cliente_id");

        return $campania_detalles;
    }

    public function catalogo()
    {
        return $this->belongsTo(Catalogo::class, 'catalogo_id');
    }

    public function campania_detalles()
    {
        return $this->hasMany(CampaniaDetalle::class, 'campania_id');
    }

    public function campania_envios()
    {
        return $this->hasMany(CampaniaEnvio::class, 'campania_id');
    }

    public function producto()
    {
        return $this->belongsTo(Producto::class, 'producto_id');
    }

    // ENVIOS
    public static function realizaEnvioCampania(Campania $campania, $sw_whatsapp, $sw_correo)
    {
        $clientes_enviar = [];
        $array_multimedias = [];
        if ($campania->tipo == 'CATÁLOGO') {
            $catalogo = $campania->catalogo;
            $array_multimedias = [];

            $imgs_prueba = [
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCCV18NN1R_hI6tRjrv3i_88CkUZ-Uv8ODWKw56KE68saS-jfV4ccIswtFr73hIZUElYU&usqp=CAU",
                "https://idegrafico.com/wp-content/uploads/2017/03/Las-imagenes-raw-son-los-negativos-digitales.jpg",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCCV18NN1R_hI6tRjrv3i_88CkUZ-Uv8ODWKw56KE68saS-jfV4ccIswtFr73hIZUElYU&usqp=CAU",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVu4co9FEDyLSjRECZDpXym6Rw8FsERldC-8I9iwYkJujP2oifzsxCgtsZG8HASdzVCPA&usqp=CAU",
            ];
            foreach ($catalogo->catalogo_detalles as $key => $cd) {
                if ($key < 4) {
                    $array_multimedias[] = $imgs_prueba[$key];
                }
                // $array_multimedias[] = $cd->producto->url_imagen;
            }
        }
        if ($campania->tipo_cliente != 'TODOS') {
            if ($campania->tipo_cliente == 'ECOMMERCE') {
                $clientes_enviar = Cliente::where("tipo", "ECOMMERCE")->get();
            } elseif ($campania->tipo_cliente == 'FISICO') {
                $clientes_enviar = Cliente::where("tipo", "FISICO")->get();
            } elseif ($campania->tipo_cliente == 'PERSONALIZADO') {
                Log::debug($campania->filtro_cliente);
                if ($campania->filtro_cliente == 'PRODUCTO COMPRADO') {
                    $ventas = Venta::select("ventas.id", "ventas.cliente_id")
                        ->join("detalle_ventas", "detalle_ventas.venta_id", "ventas.id")
                        ->where("producto_id", $campania->producto_id)
                        ->get();
                    $agregados = [];
                    foreach ($ventas as $item_v) {
                        if (!in_array($item_v->cliente_id, $agregados)) {
                            $agregados[] = $item_v->cliente_id;
                            $clientes_enviar[] = $item_v->cliente;
                        }
                    }
                } elseif ($campania->filtro_cliente == 'CANTIDAD COMPRA') {
                    $clientes = Cliente::all();
                    foreach ($clientes as $c) {
                        $cantidad_comprada =  Venta::join("detalle_ventas", "detalle_ventas.venta_id", "ventas.id")
                            ->where("ventas.cliente_id", $c->id)
                            ->sum("detalle_ventas.cantidad");
                        if ($cantidad_comprada == $campania->cantidad_compra) {
                            $clientes_enviar[] = $c;
                        }
                    }
                } elseif ($campania->filtro_cliente == 'CLIENTES ESPECIFICOS') {
                    $id_clientes = CampaniaDetalle::where("campania_id", $campania->id)->pluck("cliente_id");
                    $clientes_enviar = Cliente::whereIn("id", $id_clientes)->get();
                }
            }
        } else {
            $clientes_enviar = Cliente::all();
        }

        $fecha_actual = date("Y-m-d");

        if (count($array_multimedias) > 0) {
            foreach ($clientes_enviar as $ce) {
                $mensaje = "Hola " . $ce->nombre;
                $mensaje = "\nEsto te podría interesar";
                $mensaje .= "\n" . $campania->nombre;
                if ($campania->descripcion) {
                    $mensaje .= "\n" . $campania->descripcion;
                }
                $fonos = [];
                if ($ce->fono) {
                    $fonos = explode(";", $ce->fono);
                }

                $mensajehtml = "Hola " . $ce->nombre;
                $mensajehtml = "<br/>Esto te podría interesar";
                $mensajehtml .= "<br/>" . $campania->nombre;
                if ($campania->descripcion) {
                    $mensajehtml .= "<br/>" . $campania->descripcion;
                }

                if ($sw_correo) {
                    // ENVIO CORREO
                    EnvioCorreoController::mensajeCampania($ce->correo, $campania, $mensajehtml, $array_multimedias);
                }

                if ($sw_whatsapp) {
                    // ENVIO WHATSAPP
                    foreach ($fonos as $value) {
                        EnviarWhatsappController::enviarMensajeMultimedia($mensaje, trim($value), $array_multimedias);
                        // registrar envio
                        $existe_envio = CampaniaEnvio::where("fecha_envio", $fecha_actual)
                            ->where("campania_id", $campania->id)
                            ->get()->first();
                        if (!$existe_envio) {
                            $existe_envio = CampaniaEnvio::create([
                                "campania_id" => $campania->id,
                                "fecha_envio" => $fecha_actual,
                                "total_fisicos" => 0,
                                "total_ecommerce" => 0,
                            ]);
                        }

                        if ($ce->tipo == 'FISICO') {
                            $existe_envio->total_fisicos = (int)$existe_envio->total_fisicos + 1;
                        } else {
                            $existe_envio->total_ecommerce = (int)$existe_envio->total_ecommerce + 1;
                        }
                        $existe_envio->save();
                    }
                }
            }
        } else {
            foreach ($clientes_enviar as $ce) {
                $mensaje = "Hola " . $ce->nombre;
                $mensaje .= "\n" . $campania->nombre;
                if ($campania->descripcion) {
                    $mensaje .= "\n" . $campania->descripcion;
                }
                $fonos = [];
                if ($ce->fono) {
                    $fonos = explode(";", $ce->fono);
                }


                $mensajehtml = "Hola " . $ce->nombre;
                $mensajehtml = "<br/>Esto te podría interesar";
                $mensajehtml .= "<br/>" . $campania->nombre;
                if ($campania->descripcion) {
                    $mensajehtml .= "<br/>" . $campania->descripcion;
                }
                if ($sw_correo) {
                    // ENVIO CORREO
                    EnvioCorreoController::mensajeCampania($ce->correo, $campania, $mensajehtml, $array_multimedias);
                }

                if ($sw_whatsapp) {
                    // ENVIO WHATSAPP
                    foreach ($fonos as $value) {
                        EnviarWhatsappController::enviarMensaje($mensaje, trim($value));
                        // registrar envio
                        $existe_envio = CampaniaEnvio::where("fecha_envio", $fecha_actual)
                            ->where("campania_id", $campania->id)
                            ->get()->first();
                        if (!$existe_envio) {
                            $existe_envio = CampaniaEnvio::create([
                                "campania_id" => $campania->id,
                                "fecha_envio" => $fecha_actual,
                                "total_fisicos" => 0,
                                "total_ecommerce" => 0,
                            ]);
                        }

                        if ($ce->tipo == 'FISICO') {
                            $existe_envio->total_fisicos = (int)$existe_envio->total_fisicos + 1;
                        } else {
                            $existe_envio->total_ecommerce = (int)$existe_envio->total_ecommerce + 1;
                        }
                        $existe_envio->save();
                    }
                }
            }
        }

        return true;
    }
}
