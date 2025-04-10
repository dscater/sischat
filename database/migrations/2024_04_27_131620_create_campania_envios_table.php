<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCampaniaEnviosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('campania_envios', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("campania_id");
            $table->unsignedBigInteger("campania_automatico_id")->nullable();
            $table->date("fecha_envio");
            $table->integer("total_fisicos");
            $table->integer("total_ecommerce");
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
        Schema::dropIfExists('campania_envios');
    }
}
