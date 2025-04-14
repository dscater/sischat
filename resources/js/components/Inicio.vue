<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row" v-if="configuracion">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h2
                                    style="
                                        font-weight: bold;
                                        text-align: center;
                                    "
                                >
                                    SISTEMA {{ configuracion.nombre_sistema }}
                                </h2>
                                <h3 style="text-align: center">
                                    ¡BIENVENID@ {{ user.full_name }}!
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div
                        class="col-12 col-sm-6 col-md-3"
                        v-for="(item, index) in listInfoBox"
                        :key="index"
                    >
                        <div class="info-box">
                            <span
                                class="info-box-icon elevation-1"
                                :class="item.color"
                                ><i :class="item.icon"></i
                            ></span>
                            <div class="info-box-content">
                                <span class="info-box-text">{{
                                    item.label
                                }}</span>
                                <span class="info-box-number">{{
                                    item.cantidad
                                }}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div
                    class="row"
                    v-if="
                        user &&
                        user.id &&
                        (user.tipo == 'ADMINISTRADOR' ||
                            user.tipo == 'SUPERVISOR')
                    "
                >
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
                                                    @change="generaReporte"
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
                                                    @change="generaReporte"
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
                                                    @change="generaReporte"
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
                                                    @change="generaReporte"
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
                                                    @change="generaReporte"
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
                                                    @change="generaReporte"
                                                    @keyup="generaReporte"
                                                />
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.gestion"
                                                    v-text="errors.gestion[0]"
                                                ></span>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" id="container"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div
                    class="row"
                    v-if="user && user.id && user.tipo == 'CLIENTE'"
                >
                    <div class="col-12" v-if="oEnvioWhatsapp">
                        <p class="w-100 text-center">
                            Recibe notificaciones sobre
                            campañas,promociones,etc. en tu whatsapp envíando el
                            texto
                            <strong>"{{ oEnvioWhatsapp.url_phone }}" </strong>,
                            al número {{ oEnvioWhatsapp.from }}. Solo debes
                            hacer click
                            <a
                                :href="
                                    'http://wa.me/' +
                                    oEnvioWhatsapp.from +
                                    '?text=' +
                                    oEnvioWhatsapp.url_phone
                                "
                                >aquí</a
                            >
                        </p>
                    </div>
                    <div class="col-12 text-center">
                        <a :href="url_asset + '/productos'" class="text-md mr-3"
                            >Seguir comprando</a
                        >
                        <a :href="url_asset + '/carrito'" class="text-md ml-3"
                            >Ver mi carrito</a
                        >
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </section>
    </div>
</template>

<script>
export default {
    data() {
        return {
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            usuarios: 10,
            configuracion: JSON.parse(localStorage.getItem("configuracion")),
            user: JSON.parse(localStorage.getItem("user")),
            listInfoBox: [],
            htmlMision: "",
            htmlVision: "",
            htmlObjetivos: "",
            url_asset: "/",
            oEnvioWhatsapp: null,
            texto_whatsapp: "",
            texto_numero: "",
            enviando: false,
            textoBtn: "Generar Reporte",
            errors: [],
            oReporte: {
                producto_id: "TODOS",
                canal: "TODOS",
                filtro_fecha: "RANGO DE FECHAS",
                gestion: this.getAnioActual(),
                fecha_ini: this.getFechaActual(),
                fecha_fin: this.getFechaActual(),
            },
            listProductos: [],
            listFiltroFecha: [
                "RANGO DE FECHAS",
                "MES",
                "TRIMESTRE",
                "SEMESTRE",
                "ANUAL",
            ],
            listCanal: ["TODOS", "ECOMMERCE", "FISICO"],
        };
    },
    mounted() {
        this.url_asset = main_url;
        this.loadingWindow.close();
        this.getInfoBox();
        this.getEnvioWhatsapp();
        this.getProductos();
        this.generaReporte();
    },
    methods: {
        getEnvioWhatsapp() {
            axios.get(main_url + "/url_phone").then((response) => {
                this.oEnvioWhatsapp = response.data;
            });
        },
        getInfoBox() {
            axios.get("/admin/usuarios/getInfoBox").then((res) => {
                this.listInfoBox = res.data;
            });
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
