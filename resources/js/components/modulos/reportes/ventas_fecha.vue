<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Reportes - Cantidad de ventas por fecha</h1>
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
                                <div class="ml-auto mr-auto col-md-12">
                                    <form>
                                        <div class="row mb-3">
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.producto_id,
                                                    }"
                                                    >Seleccionar
                                                    producto*</label
                                                >
                                                <el-select
                                                    v-model="
                                                        oReporte.producto_id
                                                    "
                                                    filterable
                                                    placeholder="Seleccionar producto"
                                                    class="d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.producto_id,
                                                    }"
                                                >
                                                    <el-option
                                                        v-for="item in listProductos"
                                                        :key="item.id"
                                                        :value="item.id"
                                                        :label="item.nombre"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.producto_id"
                                                    v-text="
                                                        errors.producto_id[0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.canal,
                                                    }"
                                                    >Seleccionar Canal*</label
                                                >
                                                <el-select
                                                    v-model="oReporte.canal"
                                                    filterable
                                                    class="d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.canal,
                                                    }"
                                                >
                                                    <el-option
                                                        v-for="item in listCanal"
                                                        :key="item"
                                                        :value="item"
                                                        :label="item"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.canal"
                                                    v-text="errors.canal[0]"
                                                ></span>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.filtro_fecha,
                                                    }"
                                                    >Fitro Fecha*</label
                                                >
                                                <el-select
                                                    v-model="
                                                        oReporte.filtro_fecha
                                                    "
                                                    filterable
                                                    class="d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.filtro_fecha,
                                                    }"
                                                >
                                                    <el-option
                                                        v-for="item in listFiltroFecha"
                                                        :key="item"
                                                        :value="item"
                                                        :label="item"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.filtro_fecha"
                                                    v-text="
                                                        errors.filtro_fecha[0]
                                                    "
                                                ></span>
                                            </div>
                                            <div
                                                class="col-md-4"
                                                v-if="
                                                    oReporte.filtro_fecha ==
                                                    'RANGO DE FECHAS'
                                                "
                                            >
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.fecha_ini,
                                                    }"
                                                    >Fecha Inicio*</label
                                                >
                                                <input
                                                    v-model="oReporte.fecha_ini"
                                                    type="date"
                                                    class="form-control"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.fecha_ini,
                                                    }"
                                                    @keyup="
                                                        validarFecha(
                                                            $event,
                                                            'fecha_ini'
                                                        )
                                                    "
                                                />
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.fecha_ini"
                                                    v-text="errors.fecha_ini[0]"
                                                ></span>
                                            </div>
                                            <div
                                                class="col-md-4"
                                                v-if="
                                                    oReporte.filtro_fecha ==
                                                    'RANGO DE FECHAS'
                                                "
                                            >
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.fecha_fin,
                                                    }"
                                                    >Fecha Fin*</label
                                                >
                                                <input
                                                    v-model="oReporte.fecha_fin"
                                                    type="date"
                                                    class="form-control"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.fecha_fin,
                                                    }"
                                                    @keyup="
                                                        validarFecha(
                                                            $event,
                                                            'fecha_fin'
                                                        )
                                                    "
                                                />
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.fecha_fin"
                                                    v-text="errors.fecha_fin[0]"
                                                ></span>
                                            </div>
                                            <div
                                                class="col-md-4"
                                                v-if="
                                                    oReporte.filtro_fecha ==
                                                        'MES' ||
                                                    oReporte.filtro_fecha ==
                                                        'TRIMESTRE' ||
                                                    oReporte.filtro_fecha ==
                                                        'SEMESTRE'
                                                "
                                            >
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.gestion,
                                                    }"
                                                    >Gestión*</label
                                                >
                                                <input
                                                    v-model="oReporte.gestion"
                                                    type="number"
                                                    class="form-control"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.gestion,
                                                    }"
                                                />
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.gestion"
                                                    v-text="errors.gestion[0]"
                                                ></span>
                                            </div>
                                        </div>
                                    </form>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <el-button
                                                type="primary"
                                                class="bg-primary w-full"
                                                :loading="enviando"
                                                @click="generaReporte()"
                                                >{{ textoBtn }}</el-button
                                            >
                                        </div>
                                        <div class="col-md-12">
                                            <el-button
                                                type="default"
                                                class="w-full mt-1"
                                                @click="limpiarFormulario()"
                                                >Reiniciar</el-button
                                            >
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" id="container"></div>
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
            user: JSON.parse(localStorage.getItem("user")),
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            errors: [],
            oReporte: {
                producto_id: "TODOS",
                canal: "TODOS",
                filtro_fecha: "RANGO DE FECHAS",
                gestion: this.getAnioActual(),
                fecha_ini: this.getFechaActual(),
                fecha_fin: this.getFechaActual(),
            },
            enviando: false,
            textoBtn: "Generar Reporte",
            listProductos: [],
            listFiltroFecha: [
                "RANGO DE FECHAS",
                "MES",
                "TRIMESTRE",
                "SEMESTRE",
                "ANUAL",
            ],
            listCanal: ["TODOS", "ECOMMERCE", "FISICO"],
            errors: [],
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getProductos();
    },
    methods: {
        limpiarFormulario() {
            this.oReporte.filtro = "Todos";
        },
        getProductos() {
            axios.get(main_url + "/admin/productos").then((response) => {
                this.listProductos = response.data.productos;
                this.listProductos.unshift({ id: "TODOS", name: "TODOS" });
            });
        },
        generaReporte() {
            this.enviando = true;
            axios
                .post("/admin/reportes/ventas_fecha", this.oReporte)
                .then((response) => {
                    this.errors = [];
                    Highcharts.chart("container", {
                        chart: {
                            type: "column",
                        },
                        title: {
                            text: "VENTAS POR FECHA",
                        },
                        subtitle: {
                            text: "",
                        },
                        xAxis: {
                            categories: response.data.categories,
                            // crosshair: true,
                            labels: {
                                rotation: -45,
                                style: {
                                    fontSize: "13px",
                                    fontFamily: "Verdana, sans-serif",
                                },
                            },
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: "CANTIDAD",
                            },
                        },
                        legend: {
                            enabled: true,
                        },
                        plotOptions: {
                            series: {
                                borderWidth: 0,
                                dataLabels: {
                                    enabled: true,
                                    format: "{point.y:.0f}",
                                },
                            },
                        },
                        tooltip: {
                            headerFormat:
                                '<span style="font-size:10px"><b>{point.key}</b></span><table>',
                            pointFormat:
                                '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                '<td style="padding:0"><b>{point.y}</b></td></tr>',
                            footerFormat: "</table>",
                            shared: true,
                            useHTML: true,
                        },
                        series: response.data.series,
                    });
                    this.enviando = false;
                })
                .catch(async (error) => {
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = error.response.data.errors;
                        }
                    }
                });
        },
        validarFecha(e, index) {
            let fecha = e.target.value;
            let validacion = false;

            const partes = fecha.split("-");
            const year = parseInt(partes[0], 10);
            const month = parseInt(partes[1], 10);
            const day = parseInt(partes[2], 10);
            const date = new Date(year, month - 1, day); // Meses en JavaScript son indexados desde 0
            const regex = /^\d{4}-\d{2}-\d{2}$/; // Expresión regular para el formato YYYY-MM-DD
            if (!regex.test(fecha)) {
                validacion = false;
            } else {
                // Verificar si los componentes de la fecha coinciden con los componentes originales
                if (
                    date.getFullYear() === year &&
                    date.getMonth() === month - 1 &&
                    date.getDate() === day
                ) {
                    validacion = true;
                }
            }

            this.errors[index] = [];
            if (!validacion) {
                this.errors[index].push("Fecha no valida");
            } else {
                this.$delete(this.errors, index);
            }
        },
    },
};
</script>

<style></style>
