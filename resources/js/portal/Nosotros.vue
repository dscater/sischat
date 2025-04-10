<template>
    <div class="contenedor_inicio">
        <section class="section-padding">
            <div class="container pt-25">
                <div class="row">
                    <div class="col-lg-6 align-self-center mb-lg-0 mb-4">
                        <h6
                            class="mt-0 mb-15 text-uppercase font-sm text-brand wow fadeIn animated animated"
                            style="visibility: visible"
                        >
                            Nuestra Empresa
                        </h6>
                        <h2 class="font-heading mb-40">Nuestra misión</h2>
                        <p>
                            {{ oConfiguracion.mision }}
                        </p>
                    </div>
                    <div class="col-lg-6">
                        <img :src="oConfiguracion.url_mision_img" alt="" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <img :src="oConfiguracion.url_vision_img" alt="" />
                    </div>
                    <div class="col-lg-6 align-self-center mb-lg-0 mb-4">
                        <h2 class="font-heading mb-40">Nuestra visión</h2>
                        <p>
                            {{ oConfiguracion.vision }}
                        </p>
                    </div>
                </div>
            </div>
        </section>
        <section id="work" class="mt-40 pt-50 pb-50 section-border">
            <div class="container">
                <div class="row mb-50">
                    <div class="col-lg-12 col-md-12 text-center">
                        <h2
                            class="mt-0 mb-5 text-uppercase text-brand font-lg wow fadeIn animated animated"
                            style="visibility: visible"
                        >
                            NUESTROS SERVICIOS
                        </h2>
                        <!-- <h2
                            class="mb-15 text-grey-1 wow fadeIn animated animated"
                            style="visibility: visible"
                        >
                            Our main branches<br />
                            around the world
                        </h2> -->
                        <p
                            class="w-50 m-auto text-grey-3 wow fadeIn animated"
                            style="visibility: hidden; animation-name: none"
                        >
                            {{ oConfiguracion.servicios }}
                        </p>
                    </div>
                    <div class="col-md-6 offset-md-3">
                        <img :src="oConfiguracion.url_servicios_img" alt="" />
                    </div>
                </div>
                <div class="row mb-50">
                    <div class="col-lg-12 col-md-12 text-center">
                        <h2
                            class="mt-0 mb-5 text-uppercase text-brand font-lg wow fadeIn animated animated"
                            style="visibility: visible"
                        >
                            NOSOTROS
                        </h2>
                        <!-- <h2
                            class="mb-15 text-grey-1 wow fadeIn animated animated"
                            style="visibility: visible"
                        >
                            Our main branches<br />
                            around the world
                        </h2> -->
                        <p
                            class="w-50 m-auto text-grey-3 wow fadeIn animated"
                            style="visibility: hidden; animation-name: none"
                        >
                            {{ oConfiguracion.nosotros }}
                        </p>
                    </div>
                    <div class="col-md-6 offset-md-3">
                        <img :src="oConfiguracion.url_nosotros_img" alt="" />
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
