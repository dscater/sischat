<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Reportes - Envío de campaña</h1>
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
                                                            errors.campania_id,
                                                    }"
                                                    >Seleccionar campaña*</label
                                                >
                                                <el-select
                                                    v-model="
                                                        oReporte.campania_id
                                                    "
                                                    filterable
                                                    placeholder="Seleccionar campaña"
                                                    class="d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.campania_id,
                                                    }"
                                                >
                                                    <el-option
                                                        v-for="item in listCampanias"
                                                        :key="item.id"
                                                        :value="item.id"
                                                        :label="item.nombre"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.campania_id"
                                                    v-text="
                                                        errors.campania_id[0]
                                                    "
                                                ></span>
                                            </div>
                                            <div class="col-md-4">
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
                                            <div class="col-md-4">
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
                                        </div>
                                    </form>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <el-button
                                                type="primary"
                                                class="bg-primary w-full"
                                                :loading="enviando"
                                                @click="generaReportePdf()"
                                                >{{ textoBtn }} PDF</el-button
                                            >
                                        </div>
                                        <div class="col-md-12 mt-3">
                                            <el-button
                                                type="primary"
                                                class="bg-primary w-full"
                                                :loading="enviando"
                                                @click="generaReporte()"
                                                >{{
                                                    textoBtn
                                                }}
                                                Gráfico</el-button
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
                campania_id: "TODOS",
                fecha_ini: this.getFechaActual(),
                fecha_fin: this.getFechaActual(),
            },
            enviando: false,
            textoBtn: "Generar Reporte",
            listCampanias: [],
            errors: [],
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getCampanias();
    },
    methods: {
        limpiarFormulario() {
            this.oReporte.filtro = "Todos";
        },
        getCampanias() {
            axios.get(main_url + "/admin/campanias").then((response) => {
                this.listCampanias = response.data.campanias;
                this.listCampanias.unshift({ id: "TODOS", name: "TODOS" });
            });
        },
        generaReportePdf() {
            this.enviando = true;
            let config = {
                responseType: "blob",
            };
            axios
                .post(
                    "/admin/reportes/envios_campania_pdf",
                    this.oReporte,
                    config
                )
                .then((res) => {
                    this.errors = [];
                    this.enviando = false;
                    let pdfBlob = new Blob([res.data], {
                        type: "application/pdf",
                    });
                    let urlReporte = URL.createObjectURL(pdfBlob);
                    window.open(urlReporte);
                })
                .catch(async (error) => {
                    let responseObj = await error.response.data.text();
                    responseObj = JSON.parse(responseObj);
                    console.log(error);
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = responseObj.errors;
                        }
                        if (
                            error.response.status === 420 ||
                            error.response.status === 419 ||
                            error.response.status === 401
                        ) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: responseObj.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                            window.location = "/";
                        }
                    }
                });
        },
        generaReporte() {
            this.enviando = true;
            axios
                .post("/admin/reportes/envios_campania", this.oReporte)
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
                            type: "category",
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
                        series: [
                            {
                                name: "Total Envíos",
                                colorByPoint: true,
                                data: response.data.datos,
                                dataLabels: {
                                    rotation: 0,
                                    color: "#000000",
                                    format: "{point.y:.0f}", // one decimal
                                    y: 0, // 10 pixels down from the top
                                    style: {
                                        fontSize: "10px",
                                        fontFamily: "Verdana, sans-serif",
                                    },
                                },
                            },
                        ],
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
