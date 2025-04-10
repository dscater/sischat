<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Otras Configuraciones</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h4>Google Maps Api</h4>
                                <div class="row">
                                    <div class="col-md-12 form-group">
                                        <label for="">API KEY:</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid':
                                                    errors.google_maps,
                                            }"
                                            v-model="oConfiguracion.google_maps"
                                        />
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.google_maps"
                                            v-text="errors.google_maps[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for="">MAP ID:</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.map_id,
                                            }"
                                            v-model="oConfiguracion.map_id"
                                        />
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.map_id"
                                            v-text="errors.map_id[0]"
                                        ></span>
                                    </div>
                                </div>
                                <h4>Envio de correos</h4>
                                <div class="row">
                                    <div class="col-md-12 form-group">
                                        <label for="">HOST:</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.host,
                                            }"
                                            v-model="oConfiguracion.host"
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.host"
                                            v-text="errors.host[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for="">PUERTO</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.puerto,
                                            }"
                                            v-model="oConfiguracion.puerto"
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.puerto"
                                            v-text="errors.puerto[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for="">ENCRIPTACIÓN</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.encriptado,
                                            }"
                                            v-model="oConfiguracion.encriptado"
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.encriptado"
                                            v-text="errors.encriptado[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for="">EMAIL</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.email,
                                            }"
                                            v-model="oConfiguracion.email"
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.email"
                                            v-text="errors.email[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for="">NOMBRE</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.nombre,
                                            }"
                                            v-model="oConfiguracion.nombre"
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.nombre"
                                            v-text="errors.nombre[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for="">PASSWORD</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.password,
                                            }"
                                            v-model="oConfiguracion.password"
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.password"
                                            v-text="errors.password[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for="">DRIVER</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.driver,
                                            }"
                                            v-model="oConfiguracion.driver"
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.driver"
                                            v-text="errors.driver[0]"
                                        ></span>
                                    </div>
                                </div>
                                <h4>
                                    Envio de Whatsapp con VONAGE Api (Nexmo)<a
                                        href="https://dashboard.nexmo.com/"
                                        target="_blank"
                                        ><i class="fa fa-info-circle"></i
                                    ></a>
                                </h4>
                                <div class="row">
                                    <div class="col-md-12 form-group">
                                        <label for=""
                                            >Api Key
                                            <a
                                                href="https://dashboard.nexmo.com/settings"
                                                target="_blank"
                                                ><i
                                                    class="fa fa-info-circle"
                                                ></i></a
                                        ></label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.sid,
                                            }"
                                            v-model="oConfiguracion.sid"
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.sid"
                                            v-text="errors.sid[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for=""
                                            >Account Secret
                                            <a
                                                href="https://dashboard.nexmo.com/settings"
                                                target="_blank"
                                                ><i
                                                    class="fa fa-info-circle"
                                                ></i></a
                                        ></label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.token,
                                            }"
                                            v-model="oConfiguracion.token"
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.token"
                                            v-text="errors.token[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for=""
                                            >FROM
                                            <a
                                                href="https://dashboard.nexmo.com/messages/sandbox"
                                                target="_blank"
                                                ><i
                                                    class="fa fa-info-circle"
                                                ></i></a
                                        ></label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.from,
                                            }"
                                            v-model="oConfiguracion.from"
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.from"
                                            v-text="errors.from[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for=""
                                            >FRASE PARA UNIRSE
                                            <a
                                                href="https://dashboard.nexmo.com/messages/sandbox"
                                                target="_blank"
                                                ><i
                                                    class="fa fa-info-circle"
                                                ></i></a
                                        ></label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.url_phone,
                                            }"
                                            v-model="oConfiguracion.url_phone"
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.url_phone"
                                            v-text="errors.url_phone[0]"
                                        ></span>
                                    </div>
                                </div>
                                <h4>
                                    Configuracion Captcha
                                    <a
                                        href="https://www.google.com/recaptcha/admin/create"
                                        target="_blank"
                                        ><i class="fa fa-circle"></i
                                    ></a>
                                </h4>
                                <div class="row">
                                    <div class="col-md-12 form-group">
                                        <label for=""
                                            >Clave local (Sitio Web):</label
                                        >
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid':
                                                    errors.captcha_local,
                                            }"
                                            v-model="
                                                oConfiguracion.captcha_local
                                            "
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.captcha_local"
                                            v-text="errors.captcha_local[0]"
                                        ></span>
                                    </div>
                                    <div class="col-md-12 form-group">
                                        <label for="">Clave servidor:</label>
                                        <input
                                            type="text"
                                            class="form-control"
                                            :class="{
                                                'is-invalid':
                                                    errors.captcha_servidor,
                                            }"
                                            v-model="
                                                oConfiguracion.captcha_servidor
                                            "
                                        />

                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.captcha_servidor"
                                            v-text="errors.captcha_servidor[0]"
                                        ></span>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <div class="row">
                                    <div class="col-md-3">
                                        <button
                                            class="btn btn-primary btn-block btn-flat"
                                            :disabled="enviando"
                                            @click="setRegistro"
                                        >
                                            <i class="fa fa-save"></i> Guardar
                                            Cambios
                                        </button>
                                    </div>
                                </div>
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
            permisos: localStorage.getItem("permisos"),
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            // config modal
            enviando: false,
            oConfiguracion: {
                id: 0,
                google_maps: "",
                map_id: "",
                host: "",
                puerto: "",
                encriptado: "",
                email: "",
                nombre: "",
                password: "",
                driver: "",
                sid: "",
                token: "",
                from: "",
                url_phone: "",
                texto: "",
                descuento: "",
            },
            errors: [],
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getConfiguracion();
    },
    methods: {
        getFile(e) {
            this.oConfiguracion.logo = e.target.files[0];
        },
        // Listar Usuarios
        getConfiguracion() {
            this.loading = true;
            let url = main_url + "/admin/otra_configuracion";
            axios.get(url).then((res) => {
                if (res.data.api_map) {
                    this.oConfiguracion.google_maps =
                        res.data.api_map.google_maps;
                    this.oConfiguracion.map_id = res.data.api_map.map_id;
                }

                if (res.data.envio_correo) {
                    this.oConfiguracion.host = res.data.envio_correo.host;
                    this.oConfiguracion.puerto = res.data.envio_correo.puerto;
                    this.oConfiguracion.encriptado =
                        res.data.envio_correo.encriptado;
                    this.oConfiguracion.email = res.data.envio_correo.email;
                    this.oConfiguracion.nombre = res.data.envio_correo.nombre;
                    this.oConfiguracion.password =
                        res.data.envio_correo.password;
                    this.oConfiguracion.driver = res.data.envio_correo.driver;
                }
                if (res.data.envio_whatsapp) {
                    this.oConfiguracion.sid = res.data.envio_whatsapp.sid;
                    this.oConfiguracion.token = res.data.envio_whatsapp.token;
                    this.oConfiguracion.from = res.data.envio_whatsapp.from;
                    this.oConfiguracion.url_phone =
                        res.data.envio_whatsapp.url_phone;
                }
                if (res.data.cupon) {
                    this.oConfiguracion.texto = res.data.cupon.texto;
                    this.oConfiguracion.descuento = res.data.cupon.descuento;
                }
                if (res.data.configuracion) {
                    this.oConfiguracion.captcha_local =
                        res.data.configuracion.captcha_local;
                    this.oConfiguracion.captcha_servidor =
                        res.data.configuracion.captcha_servidor;
                }
            });
        },
        setRegistro() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = main_url + "/admin/otra_configuracion";

                axios
                    .post(url, this.oConfiguracion)
                    .then((res) => {
                        this.getConfiguracion();
                        this.enviando = false;
                        Swal.fire({
                            icon: "success",
                            title: res.data.msj,
                            showConfirmButton: false,
                            timer: 1500,
                        });
                        this.errors = [];
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (error.response) {
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors;
                            }
                            if (
                                error.response.status === 420 ||
                                error.response.status === 419 ||
                                error.response.status === 401
                            ) {
                                window.location = "/";
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
        limpiarConfiguracion() {
            this.accion = "create";
            this.textoBtn = "Actualizar";
            this.oConfiguracion.nombre_sistema = "";
            this.oConfiguracion.alias = "";
            this.oConfiguracion.razon_social = "";
            this.oConfiguracion.nit = "";
            this.oConfiguracion.ciudad = "";
            this.oConfiguracion.dir = "";
            this.oConfiguracion.fono = "";
            this.oConfiguracion.web = "";
            this.oConfiguracion.actividad = "";
            this.oConfiguracion.correo = "";
            this.oConfiguracion.logo = "";
            this.oConfiguracion.texto = "";
            this.oConfiguracion.descuento = "";
        },
    },
};
</script>

<style>
.el-descriptions-item__cell.el-descriptions-item__label.is-bordered-label {
    background: var(--primary) !important;
}
</style>
