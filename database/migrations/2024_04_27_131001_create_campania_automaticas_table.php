<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCampaniaAutomaticasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('campania_automaticas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("campania_id");
            $table->string("tipo");
            $table->date("fecha_registro");
            $table->date("fecha_ini")->nullable();
            $table->date("fecha_fin")->nullable();
            $table->integer("frecuencia")->nullable();
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
        Schema::dropIfExists('campania_automaticas');
    }
}
