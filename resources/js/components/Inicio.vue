<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row" v-if="configuracion">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h2
                                    style="
                                        font-weight: bold;
                                        text-align: center;
                                    "
                                >
                                    SISTEMA {{ configuracion.nombre_sistema }}
                                </h2>
                                <h3 style="text-align: center">
                                    ¡BIENVENID@ {{ user.full_name }}!
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div
                        class="col-12 col-sm-6 col-md-3"
                        v-for="(item, index) in listInfoBox"
                        :key="index"
                    >
                        <div class="info-box">
                            <span
                                class="info-box-icon elevation-1"
                                :class="item.color"
                                ><i :class="item.icon"></i
                            ></span>
                            <div class="info-box-content">
                                <span class="info-box-text">{{
                                    item.label
                                }}</span>
                                <span class="info-box-number">{{
                                    item.cantidad
                                }}</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div
                    class="row"
                    v-if="user && user.id && (user.tipo == 'ADMINISTRADOR' || user.tipo == 'SUPERVISOR')"
                >grafico</div>
                <div
                    class="row"
                    v-if="user && user.id && user.tipo == 'CLIENTE'"
                >
                    <div class="col-12" v-if="oEnvioWhatsapp">
                        <p class="w-100 text-center">
                            Recibe notificaciones sobre
                            campañas,promociones,etc. en tu whatsapp envíando el
                            texto
                            <strong>"{{ oEnvioWhatsapp.url_phone }}" </strong>,
                            al número {{ oEnvioWhatsapp.from }}. Solo debes
                            hacer click
                            <a
                                :href="
                                    'http://wa.me/' +
                                    oEnvioWhatsapp.from +
                                    '?text=' +
                                    oEnvioWhatsapp.url_phone
                                "
                                >aquí</a
                            >
                        </p>
                    </div>
                    <div class="col-12 text-center">
                        <a :href="url_asset + '/productos'" class="text-md mr-3"
                            >Seguir comprando</a
                        >
                        <a :href="url_asset + '/carrito'" class="text-md ml-3"
                            >Ver mi carrito</a
                        >
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
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
            usuarios: 10,
            configuracion: JSON.parse(localStorage.getItem("configuracion")),
            user: JSON.parse(localStorage.getItem("user")),
            listInfoBox: [],
            htmlMision: "",
            htmlVision: "",
            htmlObjetivos: "",
            url_asset: "/",
            oEnvioWhatsapp: null,
            texto_whatsapp: "",
            texto_numero: "",
        };
    },
    mounted() {
        this.url_asset = main_url;
        this.loadingWindow.close();
        this.getInfoBox();
        this.getEnvioWhatsapp();
    },
    methods: {
        getEnvioWhatsapp() {
            axios.get(main_url + "/url_phone").then((response) => {
                this.oEnvioWhatsapp = response.data;
            });
        },
        getInfoBox() {
            axios.get("/admin/usuarios/getInfoBox").then((res) => {
                this.listInfoBox = res.data;
            });
        },
    },
};
</script>

<style></style>
