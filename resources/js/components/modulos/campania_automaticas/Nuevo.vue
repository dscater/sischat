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
                                        'text-danger': errors.campania_id,
                                    }"
                                    >Seleccionar campaña*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid': errors.campania_id,
                                    }"
                                    v-model="campania_automatica.campania_id"
                                    clearable
                                    filterable
                                >
                                    <el-option
                                        v-for="(item, index) in listCampanias"
                                        :key="index"
                                        :value="item.id"
                                        :label="item.nombre"
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.campania_id"
                                    v-text="errors.campania_id[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.tipo,
                                    }"
                                    >Tipo de Envío*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid': errors.tipo,
                                    }"
                                    v-model="campania_automatica.tipo"
                                    clearable
                                >
                                    <el-option
                                        v-for="(item, index) in listTipos"
                                        :key="index"
                                        :value="item"
                                        :label="item"
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.tipo"
                                    v-text="errors.tipo[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.frecuencia,
                                    }"
                                    >Frecuencia de Envío*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid': errors.frecuencia,
                                    }"
                                    v-model="campania_automatica.frecuencia"
                                    clearable
                                >
                                    <el-option
                                        v-for="(item, index) in listFrecuencias"
                                        :key="index"
                                        :value="item"
                                        :label="item"
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.frecuencia"
                                    v-text="errors.frecuencia[0]"
                                ></span>
                            </div>
                        </div>
                        <div
                            class="row"
                            v-if="
                                campania_automatica.frecuencia ==
                                'RANGO DE FECHAS'
                            "
                        >
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.fecha_ini,
                                    }"
                                    >Fecha de Inicio*</label
                                >
                                <input
                                    type="date"
                                    class="form-control"
                                    :class="{ 'is-invalid': errors.fecha_ini }"
                                    v-model="campania_automatica.fecha_ini"
                                />
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.fecha_ini"
                                    v-text="errors.fecha_ini[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.fecha_fin,
                                    }"
                                    >Fecha Fin*</label
                                >
                                <input
                                    type="date"
                                    class="form-control"
                                    :class="{ 'is-invalid': errors.fecha_fin }"
                                    v-model="campania_automatica.fecha_fin"
                                />
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.fecha_fin"
                                    v-text="errors.fecha_fin[0]"
                                ></span>
                            </div>
                        </div>
                        <div
                            class="row"
                            v-if="campania_automatica.frecuencia == 'DÍAS'"
                        >
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.array_dias,
                                    }"
                                    >Seleccionar días*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid': errors.array_dias,
                                    }"
                                    v-model="campania_automatica.array_dias"
                                    multiple
                                >
                                    <el-option
                                        v-for="(item, index) in listDias"
                                        :key="index"
                                        :value="item"
                                        :label="item"
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.array_dias"
                                    v-text="errors.array_dias[0]"
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
        campania_automatica: {
            type: Object,
            default: {
                id: 0,
                campania_id: "",
                tipo: "",
                fecha_registro: "",
                fecha_ini: "",
                fecha_fin: "",
                frecuencia: "",
                array_dias: [],
                dias: "",
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.getCampanias();
                this.bModal = true;
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            if (this.accion == "nuevo") {
                return "NUEVO REGISTRO";
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
            listCampanias: [],
            listTipos: ["CORREO", "WHATSAPP", "TODOS"],
            listFrecuencias: ["RANGO DE FECHAS", "DÍAS"],
            errors: [],
            listDias: ["5", "10", "15", "30"],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
    },
    methods: {
        getCampanias() {
            axios.get(main_url + "/admin/campanias").then((response) => {
                this.listCampanias = response.data.campanias;
            });
        },
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/campania_automaticas";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                formdata.append(
                    "campania_id",
                    this.campania_automatica.campania_id
                        ? this.campania_automatica.campania_id
                        : ""
                );
                formdata.append(
                    "tipo",
                    this.campania_automatica.tipo
                        ? this.campania_automatica.tipo
                        : ""
                );
                formdata.append(
                    "fecha_registro",
                    this.campania_automatica.fecha_registro
                        ? this.campania_automatica.fecha_registro
                        : ""
                );
                formdata.append(
                    "fecha_ini",
                    this.campania_automatica.fecha_ini
                        ? this.campania_automatica.fecha_ini
                        : ""
                );
                formdata.append(
                    "fecha_fin",
                    this.campania_automatica.fecha_fin
                        ? this.campania_automatica.fecha_fin
                        : ""
                );
                formdata.append(
                    "frecuencia",
                    this.campania_automatica.frecuencia
                        ? this.campania_automatica.frecuencia
                        : ""
                );
                formdata.append(
                    "array_dias",
                    this.campania_automatica.array_dias
                        ? this.campania_automatica.array_dias
                        : ""
                );
                formdata.append(
                    "dias",
                    this.campania_automatica.array_dias.length > 0
                        ? this.campania_automatica.array_dias.toString()
                        : ""
                );

                if (this.accion == "edit") {
                    url =
                        "/admin/campania_automaticas/" +
                        this.campania_automatica.id;
                    formdata.append("_method", "PUT");
                }
                axios
                    .post(url, formdata, config)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.limpiaCampaniaAutomatica();
                            this.$emit("envioModal");
                            this.errors = [];
                            if (this.accion == "edit") {
                                this.textoBtn = "Actualizar";
                            } else {
                                this.textoBtn = "Registrar";
                            }
                        } else {
                            Swal.fire({
                                icon: "info",
                                title: "Atención",
                                html: res.data.msj,
                                showConfirmButton: false,
                                timer: 2000,
                            });
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
        limpiaCampaniaAutomatica() {
            this.errors = [];
            this.campania_automatica.campania_id = "";
            this.campania_automatica.tipo = "";
            this.campania_automatica.fecha_registro = "";
            this.campania_automatica.fecha_ini = "";
            this.campania_automatica.fecha_fin = "";
        },
    },
};
</script>

<style></style>
