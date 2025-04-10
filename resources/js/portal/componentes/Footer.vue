<template>
    <div>
        <footer class="main">
            <section class="section-padding footer-mid">
                <div class="container pt-15 pb-20">
                    <div class="row">
                        <div class="col-lg-4 col-md-6 offset-md-2">
                            <div class="widget-about font-md mb-md-5 mb-lg-0">
                                <div
                                    class="logo logo-width-1 wow fadeIn animated"
                                >
                                    <a href="index.html"
                                        ><img
                                            :src="oConfiguracion.path_image"
                                            alt="logo"
                                    /></a>
                                </div>
                                <h5
                                    class="mt-20 mb-10 fw-600 text-grey-4 wow fadeIn animated"
                                >
                                    Contactos
                                </h5>
                                <p class="wow fadeIn animated">
                                    <strong>Dirección: </strong
                                    >{{ oConfiguracion.dir }}
                                </p>
                                <p class="wow fadeIn animated">
                                    <strong>Teléfono: </strong
                                    >{{ oConfiguracion.fono }}
                                </p>
                                <h5
                                    class="mb-10 mt-30 fw-600 text-grey-4 wow fadeIn animated"
                                >
                                    Siguenos
                                </h5>
                                <div
                                    class="mobile-social-icon wow fadeIn animated mb-sm-5 mb-md-0"
                                >
                                    <a
                                        :href="oConfiguracion.facebook"
                                        target="_blank"
                                        ><img
                                            :src="
                                                url_assets +
                                                '/imgs/theme/icons/icon-facebook.svg'
                                            "
                                            alt=""
                                    /></a>
                                    <a
                                        :href="oConfiguracion.twitter"
                                        target="_blank"
                                        ><img
                                            :src="
                                                url_assets +
                                                '/imgs/theme/icons/icon-twitter.svg'
                                            "
                                            alt=""
                                    /></a>
                                    <a
                                        :href="oConfiguracion.instagram"
                                        target="_blank"
                                        ><img
                                            :src="
                                                url_assets +
                                                '/imgs/theme/icons/icon-instagram.svg'
                                            "
                                            alt=""
                                    /></a>
                                    <a
                                        :href="oConfiguracion.youtube"
                                        target="_blank"
                                        ><img
                                            :src="
                                                url_assets +
                                                '/imgs/theme/icons/icon-youtube.svg'
                                            "
                                            alt=""
                                    /></a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-3">
                            <h5 class="widget-title wow fadeIn animated">
                                Sobre Nosotros
                            </h5>
                            <ul
                                class="footer-list wow fadeIn animated mb-sm-5 mb-md-0"
                            >
                                <li><a href="#">Nosotros</a></li>
                                <li><a href="#">Productos</a></li>
                                <li><a href="#">Contactos</a></li>
                            </ul>
                        </div>
                        <div class="col-lg-2 col-md-3">
                            <h5 class="widget-title wow fadeIn animated">
                                Mi cuenta
                            </h5>
                            <ul class="footer-list wow fadeIn animated">
                                <li><a href="/administracion">Ingresar</a></li>
                                <li>
                                    <router-link
                                        :to="{ name: 'portal.carrito' }"
                                        >Mi carrito</router-link
                                    >
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </section>
            <div class="container pb-20 wow fadeIn animated">
                <div class="row">
                    <div class="col-12 mb-20">
                        <div class="footer-bottom"></div>
                    </div>
                    <div class="col-lg-6">
                        <p class="float-md-left font-sm text-muted mb-0">
                            &copy; {{ new Date().getFullYear() }},
                            <strong class="text-brand">{{
                                oConfiguracion.razon_social
                            }}</strong>
                        </p>
                    </div>
                    <div class="col-lg-6">
                        <p
                            class="text-lg-end text-start font-sm text-muted mb-0"
                        >
                            . Todos los derechos reservados
                        </p>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Preloader Start -->
        <div id="preloader-active">
            <div
                class="preloader d-flex align-items-center justify-content-center"
            >
                <div class="preloader-inner position-relative">
                    <div class="text-center">
                        <h5 class="mb-10">Cargando</h5>
                        <div class="loader">
                            <div class="bar bar1"></div>
                            <div class="bar bar2"></div>
                            <div class="bar bar3"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props: ["logo", "empresa"],
    data() {
        return {
            oRedSocial: null,
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
            url_assets: url_asset,
        };
    },
    mounted() {
        this.getInfoRedSocial();
        this.getConfiguracion();
        // Page loading
        $(window).on("load", function () {
            $("#preloader-active").delay(450).fadeOut("slow");
            $("body").delay(450).css({
                overflow: "visible",
            });
            $("#onloadModal").modal("show");
        });
    },
    methods: {
        getInfoRedSocial() {
            axios.get(main_url + "/portal/getRedSocial").then((response) => {
                this.oRedSocial = response.data.red_social;
            });
        },
        getConfiguracion() {
            axios
                .get(main_url + "/configuracion/getConfiguracion")
                .then((response) => {
                    this.oConfiguracion = response.data.configuracion;
                });
        },
    },
};
</script>
