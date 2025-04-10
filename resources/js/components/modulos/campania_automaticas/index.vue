<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Envío Automático de Campañass</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-3">
                                        <button
                                            v-if="
                                                permisos.includes(
                                                    'campania_automaticas.create'
                                                )
                                            "
                                            class="btn btn-primary btn-flat btn-block"
                                            @click="
                                                abreModal('nuevo');
                                                limpiaCampaniaAutomatica();
                                            "
                                        >
                                            <i class="fa fa-plus"></i>
                                            Nuevo
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <b-col lg="10" class="my-1">
                                        <b-form-group
                                            label="Buscar"
                                            label-for="filter-input"
                                            label-cols-sm="3"
                                            label-align-sm="right"
                                            label-size="sm"
                                            class="mb-0"
                                        >
                                            <b-input-group size="sm">
                                                <b-form-input
                                                    id="filter-input"
                                                    v-model="filter"
                                                    type="search"
                                                    placeholder="Buscar"
                                                ></b-form-input>

                                                <b-input-group-append>
                                                    <b-button
                                                        class="bg-primary"
                                                        variant="primary"
                                                        :disabled="!filter"
                                                        @click="filter = ''"
                                                        >Borrar</b-button
                                                    >
                                                </b-input-group-append>
                                            </b-input-group>
                                        </b-form-group>
                                    </b-col>
                                    <div class="col-md-12">
                                        <b-overlay
                                            :show="showOverlay"
                                            rounded="sm"
                                        >
                                            <b-table
                                                :fields="fields"
                                                :items="listRegistros"
                                                show-empty
                                                stacked="md"
                                                responsive
                                                :current-page="currentPage"
                                                :per-page="perPage"
                                                @filtered="onFiltered"
                                                empty-text="Sin resultados"
                                                empty-filtered-text="Sin resultados"
                                                :filter="filter"
                                            >
                                                <template
                                                    #cell(frecuencia)="row"
                                                >
                                                    {{ row.item.frecuencia }}
                                                    <br />
                                                    <span
                                                        v-if="
                                                            row.item
                                                                .frecuencia ==
                                                            'RANGO DE FECHAS'
                                                        "
                                                    >
                                                        Del
                                                        {{
                                                            row.item.fecha_ini_t
                                                        }}
                                                        al
                                                        {{
                                                            row.item.fecha_fin_t
                                                        }}</span
                                                    >

                                                    <span
                                                        v-if="
                                                            row.item
                                                                .frecuencia ==
                                                            'DÍAS'
                                                        "
                                                    >
                                                        Días:
                                                        {{
                                                            row.item.dias
                                                        }}</span
                                                    >
                                                </template>
                                                <template
                                                    #cell(fecha_registro)="row"
                                                >
                                                    {{
                                                        formatoFecha(
                                                            row.item
                                                                .fecha_registro
                                                        )
                                                    }}
                                                </template>

                                                <template #cell(accion)="row">
                                                    <div
                                                        class="row justify-content-between"
                                                    >
                                                  
                                                        <b-button
                                                            size="sm"
                                                            pill
                                                            variant="outline-warning"
                                                            class="btn-flat btn-block"
                                                            title="Editar registro"
                                                            @click="
                                                                editarRegistro(
                                                                    row.item
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-edit"
                                                            ></i>
                                                        </b-button>
                                                        <b-button
                                                            size="sm"
                                                            pill
                                                            variant="outline-danger"
                                                            class="btn-flat btn-block"
                                                            title="Eliminar registro"
                                                            @click="
                                                                eliminaCampaniaAutomatica(
                                                                    row.item.id,
                                                                    row.item
                                                                        .campania
                                                                        .nombre +
                                                                        '<br/>' +
                                                                        row.item
                                                                            .tipo
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-trash"
                                                            ></i>
                                                        </b-button>
                                                    </div>
                                                </template>
                                            </b-table>
                                        </b-overlay>
                                        <div class="row">
                                            <b-col
                                                sm="6"
                                                md="2"
                                                class="ml-auto my-1"
                                            >
                                                <b-form-select
                                                    align="right"
                                                    id="per-page-select"
                                                    v-model="perPage"
                                                    :options="pageOptions"
                                                    size="sm"
                                                ></b-form-select>
                                            </b-col>
                                            <b-col
                                                sm="6"
                                                md="2"
                                                class="my-1 mr-auto"
                                                v-if="perPage"
                                            >
                                                <b-pagination
                                                    v-model="currentPage"
                                                    :total-rows="totalRows"
                                                    :per-page="perPage"
                                                    align="left"
                                                ></b-pagination>
                                            </b-col>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <Nuevo
            :muestra_modal="muestra_modal"
            :accion="modal_accion"
            :campania_automatica="oCampaniaAutomatica"
            @close="muestra_modal = false"
            @envioModal="getCampaniaAutomaticas"
        ></Nuevo>
    </div>
</template>

<script>
import Nuevo from "./Nuevo.vue";
export default {
    components: {
        Nuevo,
    },
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            search: "",
            listRegistros: [],
            showOverlay: false,
            fields: [
                {
                    key: "campania.nombre",
                    label: "Nombre de Campaña",
                    sortable: true,
                },
                { key: "tipo", label: "Tipo de Envío", sortable: true },
                {
                    key: "frecuencia",
                    label: "Frecuencia de Envío",
                    sortable: true,
                },
                {
                    key: "fecha_registro_t",
                    label: "Fecha de Registro",
                    sortable: true,
                },
                { key: "accion", label: "Acción" },
            ],
            loading: true,
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            muestra_modal: false,
            modal_accion: "nuevo",
            oCampaniaAutomatica: {
                id: 0,
                campania_id: "",
                tipo: "",
                fecha_registro: "",
                fecha_ini: "",
                fecha_fin: "",
                dias: "",
                array_dias: [],
            },
            currentPage: 1,
            perPage: 5,
            pageOptions: [
                { value: 5, text: "Mostrar 5 Registros" },
                { value: 10, text: "Mostrar 10 Registros" },
                { value: 25, text: "Mostrar 25 Registros" },
                { value: 50, text: "Mostrar 50 Registros" },
                { value: 100, text: "Mostrar 100 Registros" },
                { value: this.totalRows, text: "Mostrar Todo" },
            ],
            totalRows: 10,
            filter: null,
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getCampaniaAutomaticas();
    },
    methods: {
        // Seleccionar Opciones de Tabla
        editarRegistro(item) {
            this.oCampaniaAutomatica.id = item.id;
            this.oCampaniaAutomatica.campania_id = item.campania_id
                ? item.campania_id
                : "";
            this.oCampaniaAutomatica.tipo = item.tipo ? item.tipo : "";
            this.oCampaniaAutomatica.fecha_registro = item.fecha_registro
                ? item.fecha_registro
                : "";
            this.oCampaniaAutomatica.fecha_ini = item.fecha_ini
                ? item.fecha_ini
                : "";
            this.oCampaniaAutomatica.fecha_fin = item.fecha_fin
                ? item.fecha_fin
                : "";
            this.oCampaniaAutomatica.frecuencia = item.frecuencia
                ? item.frecuencia
                : "";
            this.oCampaniaAutomatica.dias = item.dias ? item.dias : "";
            this.oCampaniaAutomatica.array_dias = item.array_dias
                ? item.array_dias
                : [];

            this.modal_accion = "edit";
            this.muestra_modal = true;
        },

        // Listar CampaniaAutomaticas
        getCampaniaAutomaticas() {
            this.showOverlay = true;
            this.muestra_modal = false;
            let url = "/admin/campania_automaticas";
            if (this.pagina != 0) {
                url += "?page=" + this.pagina;
            }
            axios
                .get(url, {
                    params: { per_page: this.per_page },
                })
                .then((res) => {
                    this.showOverlay = false;
                    this.listRegistros = res.data.campania_automaticas;
                    this.totalRows = res.data.total;
                });
        },
        eliminaCampaniaAutomatica(id, descripcion) {
            Swal.fire({
                title: "¿Quierés eliminar este registro?",
                html: `<strong>${descripcion}</strong>`,
                showCancelButton: true,
                confirmButtonColor: "#149FDA",
                confirmButtonText: "Si, eliminar",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    axios
                        .post("/admin/campania_automaticas/" + id, {
                            _method: "DELETE",
                        })
                        .then((res) => {
                            this.getCampaniaAutomaticas();
                            this.filter = "";
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                        })
                        .catch((error) => {
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
                }
            });
        },
        abreModal(tipo_accion = "nuevo", campania_automatica = null) {
            this.muestra_modal = true;
            this.modal_accion = tipo_accion;
            if (campania_automatica) {
                this.oCampaniaAutomatica = campania_automatica;
            }
        },
        onFiltered(filteredItems) {
            // Trigger pagination to update the number of buttons/pages due to filtering
            this.totalRows = filteredItems.length;
            this.currentPage = 1;
        },
        limpiaCampaniaAutomatica() {
            this.oCampaniaAutomatica.campania_id = "";
            this.oCampaniaAutomatica.tipo = "";
            this.oCampaniaAutomatica.fecha_registro = "";
            this.oCampaniaAutomatica.fecha_ini = "";
            this.oCampaniaAutomatica.fecha_fin = "";
        },
        formatoFecha(date) {
            return this.$moment(String(date)).format("DD/MM/YYYY");
        },
    },
};
</script>

<style></style>
