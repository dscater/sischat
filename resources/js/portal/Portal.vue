<template>
    <div>
        <HeaderDos :configuracion="oConfiguracion"></HeaderDos>
        <transition name="fade" mode="out-in">
            <router-view></router-view>
        </transition>

        <Footer
            :logo="logo"
            :empresa="oConfiguracion.alias ? oConfiguracion.alias : 'Empresa'"
        ></Footer>

        <!-- Back to top -->
        <div class="btn-back-to-top" id="myBtn">
            <span class="symbol-btn-back-to-top">
                <i class="zmdi zmdi-chevron-up"></i>
            </span>
        </div>
    </div>
</template>

<script>
import HeaderDos from "./componentes/HeaderDos.vue";
import Sidebar from "./componentes/Sidebar.vue";
import ModalProducto from "./componentes/ModalProducto.vue";
import CarritoLateral from "./componentes/CarritoLateral.vue";
import Footer from "./componentes/Footer.vue";

export default {
    components: {
        HeaderDos,
        Sidebar,
        CarritoLateral,
        Footer,
    },
    props: {
        logo: {
            String,
            default:
                "https://www.logodesign.net/logo/eye-and-house-5806ld.png?size=2&industry=All",
        },
        ruta: {
            String,
            default: "",
        },
        ruta_asset: {
            String,
            default: "",
        },
        configuracion: {
            Object,
            default: {
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
            },
        },
    },
    data() {
        return {
            oConfiguracion:
                typeof this.configuracion == "string"
                    ? JSON.parse(this.configuracion)
                    : this.configuracion,
        };
    },
    mounted() {
        this.funcionesPortal();
    },
    methods: {
        funcionesPortal() {
            /*[ Back to top ]
    ===========================================================*/
            var windowH = $(window).height() / 2;

            $(window).on("scroll", function () {
                if ($(this).scrollTop() > windowH) {
                    $("#myBtn").css("display", "flex");
                } else {
                    $("#myBtn").css("display", "none");
                }
            });

            $("#myBtn").on("click", function () {
                $("html, body").animate({ scrollTop: 0 }, 300);
            });
            // Initiate the wowjs
            new WOW().init();
        },
    },
};
</script>

<style></style>
