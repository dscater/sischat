<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEnvioCorreosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('envio_correos', function (Blueprint $table) {
            $table->id();
            $table->string("host", 255);
            $table->string("puerto", 100);
            $table->string("encriptado", 100);
            $table->string("email", 255);
            $table->string("nombre", 255);
            $table->string("password", 255);
            $table->string("driver", 255);
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
        Schema::dropIfExists('envio_correos');
    }
}
