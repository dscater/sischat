<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdenPedidosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orden_pedidos', function (Blueprint $table) {
            $table->id();
            $table->string("codigo", 255)->unique();
            $table->bigInteger("nro");
            $table->unsignedBigInteger("configuracion_pago_id");
            $table->string("celular");
            $table->string("comprobante", 255);
            $table->string("lat", 255);
            $table->string("lng", 255);
            $table->decimal("total", 24, 2);
            $table->string("estado", 155);
            $table->date("fecha_registro");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orden_pedidos');
    }
}
