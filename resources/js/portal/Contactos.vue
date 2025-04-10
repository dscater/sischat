<template>
    <div class="contenedor_inicio">
        <section class="section-border pt-50 pb-50">
            <div class="container">
                <div
                    v-html="oConfiguracion.ubicacion"
                    class="ubicacion_portal"
                ></div>
                <div class="row">
                    <div class="col-md-4 mb-4 mb-md-0 offset-md-4">
                        <h4 class="mb-15 text-brand">Nuestros contactos</h4>
                        {{ oConfiguracion.dir }}<br />
                        <abbr title="Teléfono">Teléfono:</abbr> {{ oConfiguracion.fono }}<br />
                        <abbr title="Correo">Correo: </abbr>{{ oConfiguracion.correo }}<br />
                    </div>
                </div>
            </div>
        </section>

        <section class="pt-50 pb-50">
            <div class="container">
                <div class="row">
                    <div class="col-xl-8 col-lg-10 m-auto">
                        <div
                            class="contact-from-area padding-20-row-col wow FadeInUp animated"
                            style="visibility: visible"
                        >
                            <h3 class="mb-10 text-center">Escribenos</h3>
                            <p class="text-muted mb-30 text-center font-sm">
                                Haznos saber tus dudas y sugerencias
                            </p>
                            <form
                                class="contact-form-style text-center"
                                id="contact-form"
                                action="#"
                                method="post"
                            >
                                <div class="row">
                                    <div class="col-lg-6 col-md-6">
                                        <div class="input-style mb-20">
                                            <input
                                                placeholder="Tú nombre"
                                                :class="{
                                                    'is-invalid': errors.nombre,
                                                }"
                                                v-model="oForm.nombre"
                                                type="text"
                                            />

                                            <span
                                                class="error invalid-feedback"
                                                v-if="errors.nombre"
                                                v-text="errors.nombre[0]"
                                            ></span>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="input-style mb-20">
                                            <input
                                                placeholder="Asunto"
                                                :class="{
                                                    'is-invalid': errors.asunto,
                                                }"
                                                v-model="oForm.asunto"
                                                type="text"
                                            />

                                            <span
                                                class="error invalid-feedback"
                                                v-if="errors.asunto"
                                                v-text="errors.asunto[0]"
                                            ></span>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="input-style mb-20">
                                            <input
                                                placeholder="Tú correo"
                                                :class="{
                                                    'is-invalid': errors.correo,
                                                }"
                                                type="email"
                                                v-model="oForm.correo"
                                            />
                                            <span
                                                class="error invalid-feedback"
                                                v-if="errors.correo"
                                                v-text="errors.correo[0]"
                                            ></span>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="input-style mb-20">
                                            <input
                                                placeholder="Tú Teléfono/Celular"
                                                type="tel"
                                                v-model="oForm.fono"
                                            />
                                            <span
                                                class="error invalid-feedback"
                                                v-if="errors.fono"
                                                v-text="errors.fono[0]"
                                            ></span>
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12">
                                        <div class="textarea-style mb-30">
                                            <textarea
                                                placeholder="Mensaje"
                                                :class="{
                                                    'is-invalid':
                                                        errors.mensaje,
                                                }"
                                                v-model="oForm.mensaje"
                                            ></textarea>
                                            <span
                                                class="error invalid-feedback"
                                                v-if="errors.mensaje"
                                                v-text="errors.mensaje[0]"
                                            ></span>
                                        </div>
                                        <button
                                            class="submit submit-auto-width"
                                            type="button"
                                            @click="setFormulario"
                                            :disabled="enviando"
                                            v-html="textoBoton"
                                        >
                                            Send message
                                        </button>
                                    </div>
                                </div>
                            </form>
                            <p class="form-messege"></p>
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
            oForm: {
                nombre: "",
                asunto: "",
                correo: "",
                fono: "",
                mensaje: "",
            },
            enviando: false,
            errors: [],
        };
    },
    computed: {
        textoBoton() {
            if (this.enviando) {
                return ` <i class="fa fa-spinner fa-spin"></i> Enviando...`;
            }
            return ` <i class="fa fa-paper-plane"></i> Enviar`;
        },
    },
    mounted() {
        let self = this;
        setTimeout(function () {
            self.loadingWindow.close();
        }, 500);
        this.getConfiguracion();
        this.getUrlAsset();
    },
    methods: {
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
        aplicarFiltros(key, valor) {
            this.loading = true;
            this.filtro[key] = valor;
            if (this.currentPage != 1) {
                this.currentPage = 1;
            } else {
                this.getProductos();
            }
        },
        setFormulario() {
            this.enviando = true;
            try {
                let url = main_url + "/correo_portal";
                axios
                    .post(url, this.oForm)
                    .then((res) => {
                        this.enviando = false;
                        Swal.fire({
                            icon: "success",
                            title: res.data.message,
                            showConfirmButton: false,
                            timer: 1500,
                        });
                        this.limpiaForm();
                        this.errors = [];
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (error.response) {
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors;
                            }
                            if (error.response.status === 500) {
                                Swal.fire({
                                    icon: "error",
                                    title: "Error",
                                    html: error.response.data.message,
                                    showConfirmButton: false,
                                    timer: 2000,
                                });
                            }
                        }
                    });
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        limpiaForm() {
            this.oForm.nombre = "";
            this.oForm.asunto = "";
            this.oForm.correo = "";
            this.oForm.fono = "";
            this.oForm.mensaje = "";
        },
    },
};
</script>
<style></style>
