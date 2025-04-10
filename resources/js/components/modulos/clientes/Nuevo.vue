<template>
    <div
        class="modal fade"
        :class="{ show: bModal }"
        id="modal-default"
        aria-modal="true"
        role="dialog"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title" v-text="tituloModal"></h4>
                    <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                        @click="cierraModal"
                    >
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.nombre,
                                    }"
                                    >Nombres*</label
                                >
                                <el-input
                                    placeholder="Nombre"
                                    :class="{ 'is-invalid': errors.nombre }"
                                    v-model="cliente.nombre"
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
                                    placeholder="Apellidos*"
                                    :class="{ 'is-invalid': errors.apellidos }"
                                    v-model="cliente.apellidos"
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
                                    v-model="cliente.ci"
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
                                    >Expedición C.I.*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid': errors.ci_exp,
                                    }"
                                    v-model="cliente.ci_exp"
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
                                    v-model="cliente.nit"
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
                                    v-model="cliente.fono"
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
                                        'text-danger': errors.correo,
                                    }"
                                    >Correo electrónico*</label
                                >
                                <el-input
                                    placeholder="Correo electrónico"
                                    :class="{ 'is-invalid': errors.correo }"
                                    v-model="cliente.correo"
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
                                        'text-danger': errors.dir,
                                    }"
                                    >Dirección</label
                                >
                                <el-input
                                    placeholder="Dirección"
                                    :class="{ 'is-invalid': errors.dir }"
                                    v-model="cliente.dir"
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
                                        'text-danger': errors.password,
                                    }"
                                    >Contraseña</label
                                >
                                <div class="input-group">
                                    <input
                                        placeholder="Contraseña"
                                        :type="
                                            mostrar_password
                                                ? 'text'
                                                : 'password'
                                        "
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.password,
                                        }"
                                        v-model="cliente.password"
                                        clearable
                                    />
                                    <div class="input-group-append">
                                        <button
                                            class="btn btn-primary"
                                            type="button"
                                            @click="
                                                mostrar_password =
                                                    !mostrar_password
                                            "
                                        >
                                            <i
                                                class="fa"
                                                :class="
                                                    mostrar_password
                                                        ? 'fa-eye'
                                                        : 'fa-eye-slash'
                                                "
                                            ></i>
                                        </button>
                                    </div>
                                </div>
                                <span
                                    class="error invalid-feedback"
                                    :class="errors.password ? 'd-block' : ''"
                                    v-if="errors.password"
                                    v-text="errors.password[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.acceso,
                                    }"
                                    >Acceso*</label
                                >
                                <el-switch
                                    :class="{
                                        'is-invalid': errors.acceso,
                                    }"
                                    style="display: block"
                                    v-model="cliente.acceso"
                                    active-color="#13ce66"
                                    inactive-color="#ff4949"
                                    active-text="HABILITADO"
                                    inactive-text="DESHABILITADO"
                                    active-value="1"
                                    inactive-value="0"
                                >
                                </el-switch>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.acceso"
                                    v-text="errors.acceso[0]"
                                ></span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer justify-content-between">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cerrar
                    </button>
                    <el-button
                        type="primary"
                        class="bg-primary"
                        :loading="enviando"
                        @click="setRegistroModal()"
                        >{{ textoBoton }}</el-button
                    >
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        accion: {
            type: String,
            default: "nuevo",
        },
        cliente: {
            type: Object,
            default: {
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
                acceso: "0",
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.getSucursalCajas();
                this.bModal = true;
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            if (this.accion == "nuevo") {
                return "AGREGAR REGISTRO";
            } else {
                return "MODIFICAR REGISTRO";
            }
        },
        textoBoton() {
            if (this.accion == "nuevo") {
                return "Registrar";
            } else {
                return "Actualizar";
            }
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
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
            listTipos: ["ADMINISTRADOR", "SUPERVISOR", "CAJA"],
            listCajas: [],
            errors: [],
            mostrar_password: false,
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
    },
    methods: {
        getSucursalCajas() {
            axios
                .get("/admin/sucursals/getCajas", {
                    params: { id: this.cliente.sucursal_id },
                })
                .then((response) => {
                    this.listCajas = response.data;
                });
        },
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/clientes";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                formdata.append(
                    "nombre",
                    this.cliente.nombre ? this.cliente.nombre : ""
                );
                formdata.append(
                    "apellidos",
                    this.cliente.apellidos ? this.cliente.apellidos : ""
                );
                formdata.append("ci", this.cliente.ci ? this.cliente.ci : "");
                formdata.append(
                    "ci_exp",
                    this.cliente.ci_exp ? this.cliente.ci_exp : ""
                );
                formdata.append(
                    "nit",
                    this.cliente.nit ? this.cliente.nit : ""
                );
                formdata.append(
                    "fono",
                    this.cliente.fono ? this.cliente.fono.join("; ") : ""
                );
                formdata.append(
                    "correo",
                    this.cliente.correo ? this.cliente.correo : ""
                );
                formdata.append(
                    "dir",
                    this.cliente.dir ? this.cliente.dir : ""
                );
                formdata.append(
                    "password",
                    this.cliente.password ? this.cliente.password : ""
                );
                formdata.append(
                    "acceso",
                    this.cliente.acceso ? this.cliente.acceso : ""
                );
                if (this.accion == "edit") {
                    url = "/admin/clientes/" + this.cliente.id;
                    formdata.append("_method", "PUT");
                }
                axios
                    .post(url, formdata, config)
                    .then((res) => {
                        this.enviando = false;
                        Swal.fire({
                            icon: "success",
                            title: res.data.msj,
                            showConfirmButton: false,
                            timer: 1500,
                        });
                        this.limpiaCliente();
                        this.$emit("envioModal");
                        this.errors = [];
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
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
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaCliente() {
            this.errors = [];
            this.cliente.nombre = "";
            this.cliente.apellidos = "";
            this.cliente.ci = "";
            this.cliente.ci_exp = "";
            this.cliente.nit = "";
            this.cliente.fono = [];
            this.cliente.correo = "";
            this.cliente.dir = "";
            this.cliente.password = "";
            this.cliente.acceso = "0";
        },
    },
};
</script>

<style></style>
