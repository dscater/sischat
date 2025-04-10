<template>
    <div class="contenedor_inicio">
        <section class="mt-50 mb-50" style="transform: none">
            <div class="container custom" style="transform: none">
                <div class="row" style="transform: none">
                    <div class="col-md-9 offset-md-3">
                        <div class="single-page pr-30 mb-lg-0 mb-sm-5">
                            <div class="single-header style-2">
                                <h2>Guiía de compra</h2>
                                <!-- <div
                                    class="entry-meta meta-1 font-xs mt-15 mb-15"
                                >
                                    <span class="post-by"
                                        >By <a href="#">Jonh</a></span
                                    >
                                    <span class="post-on has-dot"
                                        >9 April 2020</span
                                    >
                                    <span class="time-reading has-dot"
                                        >8 mins read</span
                                    >
                                    <span class="hit-count has-dot"
                                        >29k Views</span
                                    >
                                </div> -->
                            </div>
                            <!-- <figure class="single-thumbnail">
                                <img src="assets/imgs/page/img-1.jpg" alt="" />
                            </figure> -->
                            <div class="single-content">
                                <h4>1. Registrarse</h4>
                                <p>
                                    Acceder a este
                                    <a href="/administracion/registro">link</a>,
                                    llenar el formulario:
                                </p>
                                <ul class="mb-30">
                                    <li>Nombre(s) (requerido)</li>
                                    <li>Apellidos (requerido)</li>
                                    <li>Número de C.I. (requerido)</li>
                                    <li>Expedido (requerido)</li>
                                    <li>NIT (opcional)</li>
                                    <li>Teléfono/Celular (opcional)</li>
                                    <li>Dirección (requerido)</li>
                                    <li>Correo electrónico (requerido)</li>
                                    <li>Contraseña (requerido)</li>
                                    <li>Confirmar Contraseña (requerido)</li>
                                    <li>Verificación captcha (requerido)</li>
                                </ul>
                                <h4>2. Seleccionar producto</h4>
                                <p>
                                    Hacer click en el icono
                                    <span class="product-action-1">
                                        <a
                                            aria-label="Añadir al carrito"
                                            class="action-btn hover-up"
                                            href="#"
                                        >
                                            <i
                                                class="fi-rs-shopping-bag-add"
                                            ></i>
                                        </a>
                                    </span>
                                </p>
                                <h4>3. Confirmar el pedido</h4>
                                <p>
                                    Previamente debe iniciar sesión o
                                    registrarse (Paso 1.). Verificar los
                                    productos y la candidad. Ademas debe llenar
                                    el formulario para procesar el pedido:
                                </p>
                                <ul class="mb-30">
                                    <li>Ingresar cupón (opcional)</li>
                                    <li>
                                        Seleccionar forma de pago (requerido)
                                    </li>
                                    <li>Entrega (requerido)</li>
                                    <li>Comprobante de pago (requerido)</li>
                                    <li>Verificación captcha (requerido)</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>
<script>
export default {
    data() {
        return {
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            url_asset: "",
            oConfiguracion: {
                nombre_sistema: "",
                alias: "",
                razon_social: "",
                nit: "",
                ciudad: "",
                dir: "",
                fono: "",
                web: "",
                actividad: "",
                correo: "",
                logo: "",
                servicios: "",
                servicios_img: "",
                mision: "",
                mision_img: "",
                vision: "",
                vision_img: "",
                nosotros: "",
                nosotros_img: "",
                facebook: "",
                instagram: "",
                twitter: "",
                youtube: "",
                ubicacion: "",
            },
            listPopulares: [],
            listNuevos: [],
            id_seleccionado: 0,
            muestra_modal_producto: false,
        };
    },
    mounted() {
        let self = this;
        setTimeout(function () {
            self.loadingWindow.close();
        }, 500);
        this.getConfiguracion();
        this.getUrlAsset();
        this.getProductosPopulares();
        this.getNuevosProductos();
    },
    methods: {
        getProductosPopulares() {
            axios
                .get(main_url + "/portal/productosPopulares")
                .then((response) => {
                    this.listPopulares = response.data.productos;
                });
        },
        getNuevosProductos() {
            axios.get(main_url + "/portal/nuevosProductos").then((response) => {
                this.listNuevos = response.data.productos;
            });
        },
        getConfiguracion() {
            axios
                .get(main_url + "/configuracion/getConfiguracion")
                .then((response) => {
                    this.oConfiguracion = response.data.configuracion;
                });
        },
        getUrlAsset() {
            axios.get(main_url + "/url_asset").then((response) => {
                this.url_asset = response.data;
            });
        },
    },
};
</script>
<style></style>
