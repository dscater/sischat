<template>
    <div class="login-page registro">
        <div class="login-box">
            <!-- /.login-logo -->
            <div class="card border border-primary">
                <!-- <div class="card-header text-center">
                    <img :src="logo" alt="Logo" />
                    <router-link :to="{ name: 'login' }" class="h1 text-white"
                        ><b v-text="empresa"></b
                    ></router-link>
                </div> -->
                <div class="card-body">
                    <p class="login-box-msg text-white font-weight-bold">
                        FORMULARIO DE REGISTRO
                    </p>

                    <form>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.nombre,
                                    }"
                                    >Nombre(s)*</label
                                >
                                <el-input
                                    placeholder="Nombre"
                                    :class="{ 'is-invalid': errors.nombre }"
                                    v-model="form_registro.nombre"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.nombre"
                                    v-text="errors.nombre[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.apellidos,
                                    }"
                                    >Apellidos*</label
                                >
                                <el-input
                                    placeholder="Nombre"
                                    :class="{ 'is-invalid': errors.apellidos }"
                                    v-model="form_registro.apellidos"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.apellidos"
                                    v-text="errors.apellidos[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.ci,
                                    }"
                                    >Número de C.I.*</label
                                >
                                <el-input
                                    placeholder="Número de C.I."
                                    :class="{ 'is-invalid': errors.ci }"
                                    v-model="form_registro.ci"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.ci"
                                    v-text="errors.ci[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.ci_exp,
                                    }"
                                    >Expedido*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid': errors.ci_exp,
                                    }"
                                    v-model="form_registro.ci_exp"
                                    clearable
                                >
                                    <el-option
                                        v-for="(item, index) in listExpedido"
                                        :key="index"
                                        :value="item.value"
                                        :label="item.label"
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.ci_exp"
                                    v-text="errors.ci_exp[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.nit,
                                    }"
                                    >Nit</label
                                >
                                <el-input
                                    placeholder="Nit"
                                    :class="{ 'is-invalid': errors.nit }"
                                    v-model="form_registro.nit"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.nit"
                                    v-text="errors.nit[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.fono,
                                    }"
                                    >Teléfono/Celular</label
                                >
                                <b-form-tags
                                    input-id="tags-basic"
                                    placeholder="Teléfono/Celular"
                                    :class="{ 'is-invalid': errors.fono }"
                                    v-model="form_registro.fono"
                                    addButtonText="Añadir"
                                    separator=" ,;"
                                    remove-on-delete
                                ></b-form-tags>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.fono"
                                    v-text="errors.fono[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.dir,
                                    }"
                                    >Dirección*</label
                                >
                                <el-input
                                    placeholder="Dirección"
                                    :class="{ 'is-invalid': errors.dir }"
                                    v-model="form_registro.dir"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.dir"
                                    v-text="errors.dir[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.correo,
                                    }"
                                    >Correo electrónico*</label
                                >
                                <el-input
                                    placeholder="Correo"
                                    :class="{ 'is-invalid': errors.correo }"
                                    v-model="form_registro.correo"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.correo"
                                    v-text="errors.correo[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.password,
                                    }"
                                    >Contraseña*</label
                                >
                                <el-input
                                    type="password"
                                    placeholder="Contraseña"
                                    :class="{ 'is-invalid': errors.password }"
                                    v-model="form_registro.password"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.password"
                                    v-text="errors.password[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger':
                                            errors.password_confirmation,
                                    }"
                                    >Confirmar contraseña*</label
                                >
                                <el-input
                                    type="password"
                                    placeholder="Confirmar contraseña"
                                    :class="{
                                        'is-invalid':
                                            errors.password_confirmation,
                                    }"
                                    v-model="
                                        form_registro.password_confirmation
                                    "
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.password_confirmation"
                                    v-text="errors.password_confirmation[0]"
                                ></span>
                            </div>
                        </div>

                        <div class="row mb-2">
                            <div
                                class="col-12 text-center contenedor_captcha"
                                :class="{
                                    'is-invalid': errors.captcha,
                                }"
                            >
                                <vue-recaptcha
                                    :sitekey="key_secret"
                                    ref="recaptcha"
                                    @verify="verificaCaptcha"
                                    @error="errorCaptcha"
                                >
                                </vue-recaptcha>
                                <span
                                    class="error invalid-feedback d-block"
                                    v-if="errors.captcha"
                                    v-text="errors.captcha[0]"
                                ></span>
                            </div>
                        </div>
                        <div class="row">
                            <!-- /.col -->
                            <div class="col-md-6 form-group mx-auto">
                                <button
                                    type="button"
                                    class="btn btn-primary btn-block btn-flat font-weight-bold"
                                    @click.prevent="registro()"
                                    :disabled="btnDisabled"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    Enviar formulario
                                </button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 form-group mx-auto">
                                <a
                                    :href="url_login"
                                    class="btn btn-default btn-block btn-flat font-weight-bold"
                                    v-loading.fullscreen.lock="
                                        fullscreenLoading
                                    "
                                >
                                    Iniciar Sesión
                                </a>
                            </div>
                            <div class="col-12 mt-2 text-center">
                                <a href="/" class="w-100 text-center text-info">
                                    Volver al portal
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { VueRecaptcha } from "vue-recaptcha";
export default {
    components: { VueRecaptcha },
    props: {
        empresa: { String, default: "Nombre Empresa" },
        logo: {
            String,
            default:
                "https://www.logodesign.net/logo/eye-and-house-5806ld.png?size=2&industry=All",
        },
        configuracion: {
            String,
            default: "",
        },
        url_login: {
            type: String,
            default: "/administracion",
        },
    },
    data() {
        return {
            form_registro: {
                id: 0,
                nombre: "",
                apellidos: "",
                ci: "",
                ci_exp: "",
                nit: "",
                fono: [],
                correo: "",
                dir: "",
                password: "",
                password_confirmation: "",
            },
            listExpedido: [
                { value: "LP", label: "La Paz" },
                { value: "CB", label: "Cochabamba" },
                { value: "SC", label: "Santa Cruz" },
                { value: "CH", label: "Chuquisaca" },
                { value: "OR", label: "Oruro" },
                { value: "PT", label: "Potosi" },
                { value: "TJ", label: "Tarija" },
                { value: "PD", label: "Pando" },
                { value: "BN", label: "Beni" },
            ],
            errors: [],
            listTipos: ["EMPRESA", "INVERSIONISTA"],
            fullscreenLoading: false,
            key_secret: key_captcha_local,
            captcha: null,
            btnDisabled: true,
        };
    },
    methods: {
        errorCaptcha() {},
        verificaCaptcha(datos) {
            let config = {
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
            };
            let formdata = new FormData();
            formdata.append("secret", this.key_secret);
            formdata.append("g-recaptcha-response", datos);
            axios
                .post("/verifica_captcha", formdata, config)
                .then((response) => {
                    if (response.data.success) {
                        this.captcha = response.data.success;
                        this.btnDisabled = false;
                    } else {
                        this.btnDisabled = true;
                    }
                })
                .catch((error) => {
                    this.btnDisabled = true;
                });
        },
        registro() {
            this.fullscreenLoading = true;
            let config = {
                headers: {
                    "Content-Type": "multipart/form-data",
                },
            };
            let formdata = new FormData();
            formdata.append(
                "nombre",
                this.form_registro.nombre ? this.form_registro.nombre : ""
            );
            formdata.append(
                "apellidos",
                this.form_registro.apellidos ? this.form_registro.apellidos : ""
            );
            formdata.append(
                "ci",
                this.form_registro.ci ? this.form_registro.ci : ""
            );
            formdata.append(
                "ci_exp",
                this.form_registro.ci_exp ? this.form_registro.ci_exp : ""
            );
            formdata.append(
                "nit",
                this.form_registro.nit ? this.form_registro.nit : ""
            );
            formdata.append(
                "fono",
                this.form_registro.fono
                    ? this.form_registro.fono.join("; ")
                    : ""
            );
            formdata.append(
                "correo",
                this.form_registro.correo ? this.form_registro.correo : ""
            );
            formdata.append(
                "dir",
                this.form_registro.dir ? this.form_registro.dir : ""
            );
            formdata.append(
                "password",
                this.form_registro.password ? this.form_registro.password : ""
            );
            formdata.append(
                "password_confirmation",
                this.form_registro.password_confirmation
                    ? this.form_registro.password_confirmation
                    : ""
            );

            if (this.captcha) {
                formdata.append("captcha", this.captcha);
            }
            axios
                .post(main_url + "/administracion/registro", formdata, config)
                .then((res) => {
                    let user = res.data.user;
                    setTimeout(() => {
                        this.obtienePermisos(user);
                    }, 50);
                })
                .catch((error) => {
                    this.error = true;
                    this.password = "";
                    this.fullscreenLoading = false;
                    console.log(error.response);
                    if (error.response.status === 500) {
                        Swal.fire({
                            icon: "error",
                            title: "Error",
                            html: error.response.data.message,
                            showConfirmButton: false,
                            timer: 4000,
                        });
                    }

                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = error.response.data.errors;
                        }
                    }
                });
        },
        cargaImagen(e) {
            this.form_registro.foto = e.target.files[0];
        },
        obtienePermisos(user) {
            axios.get("/admin/usuarios/getPermisos/" + user.id).then((res) => {
                this.error = false;
                this.$router.push({ name: "inicio" });
                localStorage.setItem("configuracion", this.configuracion);
                localStorage.setItem("permisos", JSON.stringify(res.data));
                localStorage.setItem("user", JSON.stringify(user));
                location.reload();
            });
        },
    },
};
</script>

<style>
.login-page {
    background: #00000081;
}

.login-page .card {
    border-radius: 0px;
    box-shadow: 0px 0px 1px 1px var(--primary);
    background: var(--transparente);
}
.login-page .card-header {
    border-bottom: solid 1px var(--primary);
}

.login-page.registro .login-box {
    min-width: 70%;
}
.login-page.registro .login-box form label {
    color: white;
}

@media screen (max-width: 800px) {
    .login-page.registro .login-box {
        min-width: 95%;
    }
}
</style>
