<template>
    <div class="row">
        <div class="col-md-6">
            <form>
                <div class="row">
                    <div class="form-group col-md-12">
                        <label
                            :class="{
                                'text-danger': errors.producto_id,
                            }"
                            >Seleccionar producto</label
                        >
                        <el-select
                            class="w-full d-block"
                            :class="{
                                'is-invalid': errors.producto_id,
                            }"
                            v-model="producto_id"
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
                                    <strong>{{ oProducto.nombre }}</strong>
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
                    <div class="col-md-12">
                        <button
                            class="btn btn-primary btn-flat btn-block"
                            :disabled="
                                cantidad <= 0 ||
                                cantidad == '' ||
                                producto_id == ''
                            "
                            @click.prevent="agregarProducto()"
                        >
                            <i class="fa fa-plus"></i> Agregar producto
                        </button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-md-6">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <h4>Catálogo</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12 form-group">
                                    <label
                                        :class="{
                                            'text-danger': errors.nombre,
                                        }"
                                        >Nombre Catálogo*</label
                                    >
                                    <el-input
                                        placeholder="Nombre Catálogo"
                                        :class="{ 'is-invalid': errors.nombre }"
                                        v-model="catalogo.nombre"
                                        clearable
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.nombre"
                                        v-text="errors.nombre[0]"
                                    ></span>
                                </div>
                            </div>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>N°</th>
                                        <th>Producto</th>
                                        <th>Imagen</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody
                                    v-if="
                                        catalogo &&
                                        catalogo.catalogo_detalles.length > 0
                                    "
                                >
                                    <tr
                                        v-for="(
                                            item, index
                                        ) in catalogo.catalogo_detalles"
                                    >
                                        <td>{{ index + 1 }}</td>
                                        <td>{{ item.producto.nombre }}</td>
                                        <td>
                                            <img
                                                :src="item.producto.url_imagen"
                                                alt="IMAGEN"
                                                width="90px"
                                            />
                                        </td>
                                        <td>
                                            <button
                                                class="btn btn-danger"
                                                @click="
                                                    quitarDetalle(
                                                        index,
                                                        item.id
                                                    )
                                                "
                                            >
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="row">
                                <div class="col-12" v-if="catalogo">
                                    <el-button
                                        type="primary"
                                        class="btn-primary bg-primary btn-block"
                                        :loading="enviando"
                                        @click="enviarFormulario()"
                                        v-html="textoBoton"
                                        :disabled="
                                            catalogo.catalogo_detalles.length <=
                                                0 || this.enviando
                                        "
                                    ></el-button>
                                </div>
                            </div>
                        </div>
                    </div>
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
        catalogo: {
            type: Object,
            default() {
                return {
                    id: 0,
                    nombre: "",
                    catalogo_detalles: [],
                };
            },
        },
    },
    watch: {
        catalogo(newVal, oldVal) {
            if (newVal.id != 0) {
                this.getProductos();
            }
        },
    },
    computed: {
        textoBoton() {
            if (this.enviando) {
                return '<i class="fa fa-spinner fa-spin"></i> Enviando...';
            }

            if (this.accion == "edit") {
                return '<i class="fa fa-edit"></i> Actualizar catalogo';
            }

            return '<i class="fa fa-save"></i> Registrar catalogo';
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
        this.getProductos();
    },
    methods: {
        getProductos() {
            this.muestra_modal = false;
            axios.get("/admin/clientes").then((response) => {
                this.listClientes = response.data.clientes;
            });
        },
        agregarProducto() {
            if (this.oProducto) {
                this.catalogo.catalogo_detalles.push({
                    id: 0,
                    catalogo_id: 0,
                    producto_id: this.oProducto.id,
                    producto: this.oProducto,
                });

                console.log(this.catalogo);
                console.log(this.catalogo.catalogo_detalles);
                this.producto_id = "";
                this.oProducto = null;
            }
        },
        quitarDetalle(index, id) {
            if (id != 0) {
                this.eliminados.push(id);
            }

            this.catalogo.catalogo_detalles.splice(index, 1);
        },
        getProducto() {
            if (this.producto_id != "") {
                axios
                    .get("/admin/productos/" + this.producto_id)
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
                let url = "/admin/catalogos";
                if (this.accion == "edit") {
                    url = "/admin/catalogos/" + this.catalogo.id;
                    this.catalogo["_method"] = "PUT";
                    this.catalogo.eliminados = this.eliminados;
                }
                axios
                    .post(url, this.catalogo)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                            this.$emit("envioFormulario", res.data.catalogo.id);
                            this.errors = [];
                            if (this.accion == "edit") {
                                this.textoBtn = "Actualizar catalogo";
                            } else {
                                this.textoBtn = "Registrar catalogo";
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
                            this.textoBtn = "Actualizar catalogo";
                        } else {
                            this.textoBtn = "Registrar catalogo";
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
        limpiaCatalogo() {
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
            $(".detalle_catalogos").on("focusin", "input", function () {
                $(this).parents("tr").addClass("seleccionado");
            });
            $(".detalle_catalogos").on("focusout", "input", function () {
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
.detalle_catalogos tbody tr td {
    padding: 0px;
    vertical-align: middle;
}

.detalle_catalogos tbody tr td:nth-child(1) {
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
