<?php

use App\Http\Controllers\AnalisisBiController;
use App\Http\Controllers\CampaniaAutomaticaController;
use App\Http\Controllers\CampaniaController;
use App\Http\Controllers\CatalogoController;
use App\Http\Controllers\CategoriaController;
use App\Http\Controllers\ClienteController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\ConfiguracionPagoController;
use App\Http\Controllers\CuponController;
use App\Http\Controllers\EnviarWhatsappController;
use App\Http\Controllers\EnvioCorreoController;
use App\Http\Controllers\EnvioWhatsappController;
use App\Http\Controllers\HistorialAccionController;
use App\Http\Controllers\IngresoProductoController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\OrdenPedidoController;
use App\Http\Controllers\OtraConfiguracionController;
use App\Http\Controllers\VentaController;
use App\Http\Controllers\ProductoController;
use App\Http\Controllers\ProveedorController;
use App\Http\Controllers\RecuperacionController;
use App\Http\Controllers\RegistroController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\SalidaProductoController;
use App\Http\Controllers\TipoIngresoController;
use App\Http\Controllers\TipoSalidaController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

// PORTAL
Route::get('/url_asset', [ConfiguracionController::class, 'url_asset'])->name("url_asset");

Route::get('/pruebas', [EnvioCorreoController::class, 'pruebas'])->name("pruebas");

// productos
Route::get('portal/listaProductos', [ProductoController::class, 'listaProductos']);
Route::get('portal/productosPopulares', [ProductoController::class, 'productosPopulares']);
Route::get('portal/nuevosProductos', [ProductoController::class, 'nuevosProductos']);
Route::get('portal/getProducto/{producto}', [ProductoController::class, 'show']);

// catalogos
Route::get('portal/getCategorias', [CategoriaController::class, 'index']);

// 
Route::get("veririca_cupon", [CuponController::class, 'veririca_cupon'])->name("veririca_cupon");


// VACIAR CACHE
Route::get('/cache_clear', function () {
    Artisan::call("route:clear");
    Artisan::call("route:cache");
    Artisan::call("view:clear");
    Artisan::call("config:cache");
    Artisan::call("optimize");

    return 'Cache borrada correctamente<br/><a href="' . url("/") . '">Volver al inicio<a>';
});

Route::get('/auth', [LoginController::class, 'auth']);

Route::post("correo_portal", [EnvioCorreoController::class, 'correo_portal'])->name("correo_portal");

// LOGIN
Route::post('/login', [LoginController::class, 'login']);
Route::post('/logout', [LoginController::class, 'logout']);


Route::post('/verifica_captcha', [LoginController::class, 'verifica_captcha']);

// REGISTRO
Route::get('/administracion/registro', [RegistroController::class, 'registro'])->name("registro");
Route::post('/administracion/registro', [RegistroController::class, 'store']);

// LISTAS PORTAL
Route::get("configuracion_pagos_portal", [ConfiguracionPagoController::class, 'index'])->name("configuracion_pagos.portal");

Route::get("olvide_mi_contrasenia", [RecuperacionController::class, 'olvide_mi_contrasenia'])->name("olvide_mi_contrasenia");
Route::post("registrar_ci", [RecuperacionController::class, 'registrar_ci'])->name("registrar_ci");
Route::get("recuperacion/{recuperacion}", [RecuperacionController::class, 'recuperacion'])->name("recuperacion");
Route::post("recuperacion/{recuperacion}", [RecuperacionController::class, 'registro_recuperacion'])->name("registro_recuperacion");


Route::get("url_phone", [EnvioWhatsappController::class, 'url_phone'])->name("url_phone");

// CONFIGURACIÓN
Route::get('/configuracion/getConfiguracion', [ConfiguracionController::class, 'getConfiguracion']);
Route::middleware(['auth'])->group(function () {
    Route::post('/configuracion/update', [ConfiguracionController::class, 'update']);

    Route::prefix('admin')->group(function () {
        // Usuarios
        Route::get('usuarios/getUsuario/{usuario}', [UserController::class, 'getUsuario']);
        Route::get('usuarios/userActual', [UserController::class, 'userActual']);
        Route::get('usuarios/getInfoBox', [UserController::class, 'getInfoBox']);
        Route::get('usuarios/getPermisos/{usuario}', [UserController::class, 'getPermisos']);
        Route::get('usuarios/getEncargadosRepresentantes', [UserController::class, 'getEncargadosRepresentantes']);
        Route::post('usuarios/actualizaContrasenia/{usuario}', [UserController::class, 'actualizaContrasenia']);
        Route::post('usuarios/actualizaFoto/{usuario}', [UserController::class, 'actualizaFoto']);
        Route::resource('usuarios', UserController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // Proveedores
        Route::resource('proveedors', ProveedorController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // Productos
        Route::post("productos/excel", [ProductoController::class, 'excel']);
        Route::get("productos/paginado", [ProductoController::class, 'paginado']);
        Route::get("productos/verifica_ventas", [ProductoController::class, 'verifica_ventas']);
        Route::get("productos/valida_stock", [ProductoController::class, 'valida_stock']);
        Route::get("productos/productos_sucursal", [ProductoController::class, 'productos_sucursal']);
        Route::get("productos/getStock", [ProductoController::class, 'getStock']);
        Route::get("productos/buscar_producto", [ProductoController::class, 'buscar_producto']);
        Route::resource('productos', ProductoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // Categorias
        Route::resource('categorias', CategoriaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // Tipo Ingresos
        Route::resource('tipo_ingresos', TipoIngresoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // Ingreso productos
        Route::resource('ingreso_productos', IngresoProductoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // Tipo Salidas
        Route::resource('tipo_salidas', TipoSalidaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // Salida productos
        Route::resource('salida_productos', SalidaProductoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // Clientes
        Route::resource('clientes', ClienteController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // Catalogos
        Route::resource('catalogos', CatalogoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // Campaña Whatsapp
        Route::post('campanias/enviarCampania/{campania}', [CampaniaController::class, 'enviarCampania']);
        Route::resource('campanias', CampaniaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // Campaña automaticas
        Route::resource('campania_automaticas', CampaniaAutomaticaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // CONFIGURACION PAGOS
        Route::resource("configuracion_pagos", ConfiguracionPagoController::class)->only(
            ["index", "store", "update", "show", "destroy"]
        );

        // CONFIGURACION PAGOS
        Route::resource("cupons", CuponController::class)->only(
            ["index", "store", "update", "show", "destroy"]
        );

        // OTRAS CONFIGURACIONES
        Route::resource("otra_configuracion", OtraConfiguracionController::class)->only(
            ["index", "store"]
        );

        // ORDEN PEDIDOS
        Route::patch("orden_pedidos/actualiza_estado/{orden_pedido}", [OrdenPedidoController::class, 'actualiza_estado'])->name("orden_pedidos.actualiza_estado");
        Route::patch("orden_pedidos/habilitar/{orden_pedido}", [OrdenPedidoController::class, 'habilitar'])->name("orden_pedidos.habilitar");
        Route::post("registraOrden", [OrdenPedidoController::class, 'registraOrden'])->name("orden_pedidos.registraOrden");
        Route::resource("orden_pedidos", OrdenPedidoController::class)->only(
            ["index", "store", "update", "show", "destroy"]
        );

        // Ventas
        Route::post("ventas/pdf/{venta}", [VentaController::class, 'pdf']);
        Route::get("ventas/info/getLiteral", [VentaController::class, 'getLiteral']);
        Route::get("ventas/info/devolucions", [VentaController::class, 'getDevolucions']);
        Route::resource('ventas', VentaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // historial acciones
        Route::resource('historial_accions', HistorialAccionController::class)->only([
            'index', 'show'
        ]);

        // Analisis BI
        Route::get("analisis_bi/stock_productos1", [AnalisisBiController::class, 'stock_productos1']);
        Route::get("analisis_bi/stock_productos2", [AnalisisBiController::class, 'stock_productos2']);
        Route::get("analisis_bi/stock_productos3", [AnalisisBiController::class, 'stock_productos3']);

        Route::get("analisis_bi/proveedors1", [AnalisisBiController::class, 'proveedors1']);
        Route::get("analisis_bi/proveedors2", [AnalisisBiController::class, 'proveedors2']);
        Route::get("analisis_bi/proveedors3", [AnalisisBiController::class, 'proveedors3']);

        Route::get("analisis_bi/ventas1", [AnalisisBiController::class, 'ventas1']);
        Route::get("analisis_bi/ventas2", [AnalisisBiController::class, 'ventas2']);
        Route::get("analisis_bi/ventas3", [AnalisisBiController::class, 'ventas3']);
        Route::get("analisis_bi/ventas4", [AnalisisBiController::class, 'ventas4']);
        Route::get("analisis_bi/ventas5", [AnalisisBiController::class, 'ventas5']);
        Route::get("analisis_bi/ventas6", [AnalisisBiController::class, 'ventas6']);

        Route::get("analisis_bi/clientes1", [AnalisisBiController::class, 'clientes1']);
        Route::get("analisis_bi/clientes2", [AnalisisBiController::class, 'clientes2']);
        Route::get("analisis_bi/clientes3", [AnalisisBiController::class, 'clientes3']);
        Route::get("analisis_bi/clientes4", [AnalisisBiController::class, 'clientes4']);
        Route::get("analisis_bi/clientes5", [AnalisisBiController::class, 'clientes5']);
        Route::get("analisis_bi/clientes6", [AnalisisBiController::class, 'clientes6']);

        // REPORTES
        Route::post('reportes/usuarios', [ReporteController::class, 'usuarios']);
        Route::post('reportes/kardex', [ReporteController::class, 'kardex']);
        Route::post('reportes/ventas', [ReporteController::class, 'ventas']);
        Route::post('reportes/stock_productos', [ReporteController::class, 'stock_productos']);
        Route::post('reportes/historial_accion', [ReporteController::class, 'historial_accion']);
        Route::post('reportes/grafico_ingresos', [ReporteController::class, 'grafico_ingresos']);
        Route::post('reportes/grafico_orden', [ReporteController::class, 'grafico_orden']);

        Route::post('reportes/ventas_fecha', [ReporteController::class, 'ventas_fecha']);
        Route::post('reportes/compras_fecha', [ReporteController::class, 'compras_fecha']);
        Route::post('reportes/ventas_promedio', [ReporteController::class, 'ventas_promedio']);
        Route::post('reportes/envios_campania', [ReporteController::class, 'envios_campania']);
        Route::post('reportes/envios_campania_pdf', [ReporteController::class, 'envios_campania_pdf']);
    });
});


// ADMINISTRACIÓN
Route::get('/administracion/{optional?}', function () {
    return view('app');
})->name('base_path')->where('optional', '.*');


// PORTAL
Route::get('/{optional?}', function () {
    return view('portal');
})->name('portal.inicio')->where('optional', '.*');
