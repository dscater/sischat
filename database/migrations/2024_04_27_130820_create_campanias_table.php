<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCampaniasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('campanias', function (Blueprint $table) {
            $table->id();
            $table->string("nombre", 255);
            $table->date("fecha_ini");
            $table->date("fecha_fin");
            $table->string("tipo", 255);
            $table->string("tipo_cliente", 255);
            $table->string("descripcion");
            $table->unsignedBigInteger("catalogo_id")->nullable();
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
        Schema::dropIfExists('campanias');
    }
}
