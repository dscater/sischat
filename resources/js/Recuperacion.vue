<template>
    <div class="login-page recuperacion">
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
                        FORMULARIO DE RECUPERACIÓN DE CONTRASEÑA
                    </p>

                    <form>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.password,
                                    }"
                                    >Nueva Contraseña*</label
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

                        <div class="row">
                            <!-- /.col -->
                            <div class="col-md-6 form-group mx-auto">
                                <button
                                    type="button"
                                    class="btn btn-primary btn-block btn-flat font-weight-bold"
                                    @click.prevent="registro()"
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
export default {
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
        recuperacion: {
            type: String,
            default: "",
        },
    },
    data() {
        return {
            form_registro: { password: "", password_confirmation: "" },
            oRecuperacion: this.recuperacion
                ? JSON.parse(this.recuperacion)
                : null,
            errors: [],
            fullscreenLoading: false,
        };
    },
    methods: {
        registro() {
            this.fullscreenLoading = true;
            axios
                .post(
                    main_url +
                        "/recuperacion/" +
                        this.oRecuperacion?.id,
                    this.form_registro
                )
                .then((res) => {
                    this.fullscreenLoading = false;
                    this.form_registro.password = "";
                    this.form_registro.password_confirmation = "";
                    Swal.fire({
                        icon: "success",
                        title: "Correcto",
                        html: res.data.message,
                        confirmButtonColor: "#149fda",
                        confirmButtonText: "Aceptar",
                    });
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

.login-page.recuperacion .login-box {
    min-width: 70%;
}
.login-page.recuperacion .login-box form label {
    color: white;
}
@media screen (max-width: 800px) {
    .login-page.recuperacion .login-box {
        min-width: 95%;
    }
}
</style>
