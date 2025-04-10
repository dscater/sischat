<template>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-4 form-group">
                    <label
                        :class="{
                            'text-danger': errors.nombre,
                        }"
                        >Nombre de Campaña*</label
                    >
                    <el-input
                        placeholder="Nombre de Campaña"
                        :class="{ 'is-invalid': errors.nombre }"
                        v-model="campania.nombre"
                        clearable
                    >
                    </el-input>
                    <span
                        class="error invalid-feedback"
                        v-if="errors.nombre"
                        v-text="errors.nombre[0]"
                    ></span>
                </div>
                <div class="col-4 form-group">
                    <label
                        :class="{
                            'text-danger': errors.fecha_ini,
                        }"
                        >Fecha Inicio*</label
                    >
                    <input
                        placeholder="Fecha Inicio"
                        type="date"
                        class="form-control"
                        :class="{
                            'is-invalid': errors.fecha_ini,
                        }"
                        v-model="campania.fecha_ini"
                        clearable
                    />
                    <span
                        class="error invalid-feedback"
                        v-if="errors.fecha_ini"
                        v-text="errors.fecha_ini[0]"
                    ></span>
                </div>
                <div class="col-4 form-group">
                    <label
                        :class="{
                            'text-danger': errors.fecha_fin,
                        }"
                        >Fecha Fin*</label
                    >
                    <input
                        placeholder="Fecha Fin"
                        type="date"
                        class="form-control"
                        :class="{
                            'is-invalid': errors.fecha_fin,
                        }"
                        v-model="campania.fecha_fin"
                        clearable
                    />
                    <span
                        class="error invalid-feedback"
                        v-if="errors.fecha_fin"
                        v-text="errors.fecha_fin[0]"
                    ></span>
                </div>
                <div class="col-4 form-group">
                    <label
                        :class="{
                            'text-danger': errors.tipo,
                        }"
                        >Tipo*</label
                    >
                    <select
                        placeholder="Tipo"
                        class="form-control"
                        :class="{
                            'is-invalid': errors.tipo,
                        }"
                        v-model="campania.tipo"
                    >
                        <option value="">- Seleccione -</option>
                        <option v-for="item in listTipos" :value="item">
                            {{ item }}
                        </option>
                    </select>
                    <span
                        class="error invalid-feedback"
                        v-if="errors.tipo"
                        v-text="errors.tipo[0]"
                    ></span>
                </div>
                <div class="col-4 form-group">
                    <label
                        :class="{
                            'text-danger': errors.tipo_cliente,
                        }"
                        >Tipos de Clientes*</label
                    >
                    <select
                        placeholder="Tipos de Clientes"
                        class="form-control"
                        :class="{
                            'is-invalid': errors.tipo_cliente,
                        }"
                        v-model="campania.tipo_cliente"
                    >
                        <option value="">- Seleccione -</option>
                        <option v-for="item in listTipoClientes" :value="item">
                            {{ item }}
                        </option>
                    </select>
                    <span
                        class="error invalid-feedback"
                        v-if="errors.tipo_cliente"
                        v-text="errors.tipo_cliente[0]"
                    ></span>
                </div>
                <div class="col-4 form-group">
                    <label
                        :class="{
                            'text-danger': errors.descripcion,
                        }"
                        >Descripción</label
                    >
                    <input
                        placeholder="Descripción"
                        type="text"
                        class="form-control"
                        :class="{
                            'is-invalid': errors.descripcion,
                        }"
                        v-model="campania.descripcion"
                    />

                    <span
                        class="error invalid-feedback"
                        v-if="errors.descripcion"
                        v-text="errors.descripcion[0]"
                    ></span>
                </div>
            </div>
            <div class="row" v-if="campania.tipo == 'CATÁLOGO'">
                <div class="col-md-6 offset-md-3 form-group">
                    <label>Seleccionar Catálogo</label>
                    <select
                        class="form-control"
                        :class="{
                            'is-invalid': errors.catalogo_id,
                        }"
                        v-model="campania.catalogo_id"
                    >
                        <option value="">- Seleccione -</option>
                        <option v-for="item in listCatalogos" :value="item.id">
                            {{ item.nombre }}
                        </option>
                    </select>
                    <span
                        class="error invalid-feedback"
                        v-if="errors.catalogo_id"
                        v-text="errors.catalogo_id[0]"
                    ></span>
                </div>
            </div>
            <div class="row" v-if="campania.tipo_cliente == 'PERSONALIZADO'">
                <div class="col-md-6 offset-md-3 form-group">
                    <label>Seleccionar Filtro</label>
                    <select
                        class="form-control"
                        :class="{
                            'is-invalid': errors.filtro_cliente,
                        }"
                        v-model="campania.filtro_cliente"
                    >
                        <option value="">- Seleccione -</option>
                        <option
                            v-for="item in listFiltroClientes"
                            :value="item.value"
                        >
                            {{ item.label }}
                        </option>
                    </select>
                    <span
                        class="error invalid-feedback"
                        v-if="errors.filtro_cliente"
                        v-text="errors.filtro_cliente[0]"
                    ></span>
                </div>
                <!-- PRODUCTO COMPRADO -->
                <div
                    class="col-12"
                    v-if="campania.filtro_cliente == 'PRODUCTO COMPRADO'"
                >
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label
                                        :class="{
                                            'text-danger': errors.producto_id,
                                        }"
                                        >Buscar producto</label
                                    >
                                    <el-select
                                        class="w-full d-block"
                                        :class="{
                                            'is-invalid': errors.producto_id,
                                        }"
                                        v-model="campania.producto_id"
                                        filterable
                                        remote
                                        reserve-keyword
                                        clearable
                                        placeholder="Buscar producto"
                                        :remote-method="buscarProducto"
                                        :loading="loading_buscador"
                                        @change="getProducto"
                                    >
                                        <el-option
                                            v-for="item in aux_lista_productos"
                                            :key="item.id"
                                            :value="item.id"
                                            :label="item.nombre"
                                        >
                                        </el-option>
                                    </el-select>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.producto_id"
                                        v-text="errors.producto_id[0]"
                                    ></span>
                                    <div class="row" v-if="oProducto">
                                        <div class="col-12 text-center">
                                            <p>
                                                <strong>{{
                                                    oProducto.nombre
                                                }}</strong>
                                            </p>
                                            <p>
                                                <img
                                                    :src="oProducto.url_imagen"
                                                    alt=""
                                                    style="max-width: 100%"
                                                />
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- CANTIDAD COMPRA -->
                <div
                    class="col-12"
                    v-if="campania.filtro_cliente == 'CANTIDAD COMPRA'"
                >
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label
                                        :class="{
                                            'text-danger':
                                                errors.cantidad_compra,
                                        }"
                                        >Cantidad compra</label
                                    >
                                    <input
                                        type="number"
                                        step="0.01"
                                        class="form-control"
                                        :class="{
                                            'is-invalid':
                                                errors.cantidad_compra,
                                        }"
                                        v-model="campania.cantidad_compra"
                                        placeholder="Cantidad Compra"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.cantidad_compra"
                                        v-text="errors.cantidad_compra[0]"
                                    ></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- CLIENTES ESPECIFICOS -->
                <div
                    class="col-12"
                    v-if="campania.filtro_cliente == 'CLIENTES ESPECIFICOS'"
                >
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-8 offset-md-2">
                                    <label>Seleccionar Clientes</label>
                                    <el-select
                                        class="w-100"
                                        v-model="campania.campania_clientes"
                                        filterable
                                        multiple
                                        placeholder="Seleccionar Clientes"
                                    >
                                        <el-option
                                            v-for="cliente in listClientes"
                                            :key="cliente.id"
                                            :value="cliente.id"
                                            :label="cliente.nombre"
                                        >
                                        </el-option>
                                    </el-select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12" v-if="campania">
                    <el-button
                        type="primary"
                        class="btn-primary bg-primary btn-block"
                        :loading="enviando"
                        @click="enviarFormulario()"
                        v-html="textoBoton"
                        :disabled="this.enviando"
                    ></el-button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        accion: {
            type: String,
            default: "nuevo",
        },
        campania: {
            type: Object,
            default() {
                return {
                    id: 0,
                    nombre: "",
                    fecha_ini: "",
                    fecha_fin: "",
                    tipo: "",
                    tipo_cliente: "",
                    filtro_cliente: "",
                    producto_id: "",
                    cantidad_compra: "",
                    descripcion: "",
                    catalogo_id: "",
                    campania_detalles: [],
                    campania_clientes: [],
                };
            },
        },
    },
    watch: {
        campania(newVal, oldVal) {
            if (newVal.id != 0) {
                this.getClientes();
                this.getCatalogos();
                if (this.campania.producto) {
                    this.getProductosQuery(this.campania.producto.nombre);
                    setTimeout(() => {
                        this.getProducto();
                    }, 300);
                }
            }
        },
    },
    computed: {
        textoBoton() {
            if (this.enviando) {
                return '<i class="fa fa-spinner fa-spin"></i> Enviando...';
            }

            if (this.accion == "edit") {
                return '<i class="fa fa-edit"></i> Actualizar campania';
            }

            return '<i class="fa fa-save"></i> Registrar campania';
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            enviando: false,
            producto_id: "",
            cantidad: 1,
            errors: [],
            listClientes: [],
            aux_lista_productos: [],
            listProductos: [],
            listCatalogos: [],
            listFiltroClientes: [
                {
                    value: "PRODUCTO COMPRADO",
                    label: "PRODUCTO COMPRADO",
                },
                {
                    value: "CANTIDAD COMPRA",
                    label: "CANTIDAD COMPRA",
                },
                {
                    value: "CLIENTES ESPECIFICOS",
                    label: "CLIENTES ESPECIFICOS",
                },
            ],
            listTipos: [
                "GIFTCARD",
                "POST-COMPRA",
                "PROMOCIÓN",
                "DESCUENTO",
                "CATÁLOGO",
                "RECORDATORIO",
            ],
            listTipoClientes: ["ECOMMERCE", "FISICO", "PERSONALIZADO", "TODOS"],
            eliminados: [],
            muestra_modal: false,
            modal_accion: "nuevo",
            oProducto: null,
            sw_busqueda: "todos",
            loading_buscador: false,
            timeOutProductos: null,
        };
    },
    mounted() {
        this.getClientes();
        this.getCatalogos();
    },
    methods: {
        getCatalogos() {
            axios.get(main_url + "/admin/catalogos").then((response) => {
                this.listCatalogos = response.data.catalogos;
            });
        },
        getClientes() {
            this.muestra_modal = false;
            axios.get("/admin/clientes").then((response) => {
                this.listClientes = response.data.clientes;
            });
        },
        agregarProducto() {
            if (this.oProducto) {
                this.campania.campania_detalles.push({
                    id: 0,
                    campania_id: 0,
                    producto_id: this.oProducto.id,
                    producto: this.oProducto,
                });

                this.producto_id = "";
                this.oProducto = null;
            }
        },
        quitarDetalle(index, id) {
            if (id != 0) {
                this.eliminados.push(id);
            }

            this.campania.campania_detalles.splice(index, 1);
        },
        getProducto() {
            if (this.campania.producto_id != "") {
                axios
                    .get("/admin/productos/" + this.campania.producto_id)
                    .then((response) => {
                        this.oProducto = response.data.producto;
                    });
            } else {
                this.oProducto = null;
            }
        },
        // ENVIAR REGISTRO
        enviarFormulario() {
            this.enviando = true;
            try {
                let url = "/admin/campanias";
                if (this.accion == "edit") {
                    url = "/admin/campanias/" + this.campania.id;
                    this.campania["_method"] = "PUT";
                    this.campania.eliminados = this.eliminados;
                }
                axios
                    .post(url, this.campania)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                            this.$emit("envioFormulario", res.data.campania.id);
                            this.errors = [];
                            if (this.accion == "edit") {
                                this.textoBtn = "Actualizar campania";
                            } else {
                                this.textoBtn = "Registrar campania";
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
                            this.textoBtn = "Actualizar campania";
                        } else {
                            this.textoBtn = "Registrar campania";
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
        limpiaCampania() {
            this.errors = [];
        },
        fechaActual() {
            // crea un nuevo objeto `Date`
            var today = new Date();

            // `getDate()` devuelve el día del mes (del 1 al 31)
            var day = today.getDate();
            if (day < 10) {
                day = "0" + day;
            }
            // `getMonth()` devuelve el mes (de 0 a 11)
            var month = today.getMonth() + 1;
            if (month < 10) {
                month = "0" + month;
            }

            // `getFullYear()` devuelve el año completo
            var year = today.getFullYear();

            // muestra la fecha de hoy en formato `MM/DD/YYYY`
            return `${year}-${month}-${day}`;
        },
        iniciaSeleccionFilas() {
            $(".detalle_campanias").on("focusin", "input", function () {
                $(this).parents("tr").addClass("seleccionado");
            });
            $(".detalle_campanias").on("focusout", "input", function () {
                $(this).parents("tr").removeClass("seleccionado");
            });
        },
        buscarProducto(query) {
            this.aux_lista_productos = [];
            this.loading_buscador = true;
            clearTimeout(this.timeOutProductos);
            let self = this;
            this.timeOutProductos = setTimeout(() => {
                self.getProductosQuery(query);
            }, 1000);
        },
        getProductosQuery(query) {
            if (query !== "") {
                axios
                    .get("/admin/productos/buscar_producto", {
                        params: {
                            value: query,
                            sw_busqueda: this.sw_busqueda,
                        },
                    })
                    .then((response) => {
                        this.loading_buscador = false;
                        this.listProductos;
                        this.aux_lista_productos = response.data;
                    });
            } else {
                this.loading_buscador = false;
                this.aux_lista_productos = [];
            }
        },
    },
};
</script>

<style>
.detalle_campanias tbody tr td {
    padding: 0px;
    vertical-align: middle;
}

.detalle_campanias tbody tr td:nth-child(1) {
    padding-left: 5px;
}

.contenedor_tabla {
    overflow: auto;
}

@media (max-width: 780px) {
    .tabla_responsive thead {
        display: none;
    }

    .tabla_responsive.table-striped tbody tr td,
    .tabla_responsive.table-bordered tbody tr td {
        display: block !important;
    }
    .tabla_responsive.table-striped tbody tr td:before,
    .tabla_responsive.table-bordered tbody tr td:before {
        content: attr(data-col);
        font-weight: bold;
    }

    .tabla_responsive.table-bordered tfoot tr td,
    .tabla_responsive.table-bordered tfoot tr th,
    .tabla_responsive.table-striped tfoot tr td,
    .tabla_responsive.table-striped tfoot tr th {
        display: block;
    }

    .tabla_responsive.table-bordered tfoot tr td.ocultar,
    .tabla_responsive.table-bordered tfoot tr th.ocultar,
    .tabla_responsive.table-striped tfoot tr td.ocultar,
    .tabla_responsive.table-striped tfoot tr th.ocultar {
        display: none !important;
    }

    .tabla_responsive.table-bordered tfoot tr td:before,
    .tabla_responsive.table-bordered tfoot tr th:before,
    .tabla_responsive.table-striped tfoot tr td:before,
    .tabla_responsive.table-striped tfoot tr th:before {
        content: attr(data-col);
        font-weight: bold;
    }
}
</style>
