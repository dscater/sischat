<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-12">
                        <h1>Ordenes de Pedidos - <span>Ver Orden</span></h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <router-link
                            :to="{ name: 'orden_pedidos.index' }"
                            class="btn btn-default btn-flat btn-block"
                            ><i class="fa fa-arrow-left"></i>
                            Volver</router-link
                        >
                    </div>
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row mb-2">
                                    <div
                                        class="col-6 col-md-2 text-right font-weight-bold"
                                    >
                                        Código:
                                    </div>
                                    <div class="col-6 col-md-4">
                                        {{ oOrdenPedido.codigo }}
                                    </div>
                                    <div
                                        class="col-6 col-md-2 text-right font-weight-bold"
                                    >
                                        Cliente:
                                    </div>
                                    <div class="col-6 col-md-4">
                                        {{ oOrdenPedido.user.full_name }}
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div
                                        class="col-6 col-md-2 text-right font-weight-bold"
                                    >
                                        Forma de Pago:
                                    </div>
                                    <div class="col-6 col-md-4">
                                        {{
                                            oOrdenPedido.configuracion_pago
                                                .banco
                                        }}
                                        <small
                                            >({{
                                                oOrdenPedido.configuracion_pago
                                                    .nro_cuenta
                                            }})</small
                                        >
                                    </div>
                                    <div
                                        class="col-6 col-md-2 text-right font-weight-bold"
                                    >
                                        Celular:
                                    </div>
                                    <div class="col-6 col-md-4">
                                        {{
                                            oOrdenPedido.user?.cliente?.fono
                                        }}
                                    </div>
                                    <div
                                        class="col-6 col-md-2 text-right font-weight-bold"
                                    >
                                        Entrega:
                                    </div>
                                    <div class="col-6 col-md-4">
                                        {{ oOrdenPedido.entrega }}
                                    </div>
                                </div>
                                <div
                                    class="row mb-2"
                                    v-if="oOrdenPedido.entrega == 'DOMICILIO'"
                                >
                                    <div
                                        class="col-6 col-md-2 text-right font-weight-bold"
                                    >
                                        Ubicación:
                                    </div>
                                    <div class="col-6 col-md-10">
                                        <div id="google_map"></div>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div
                                        class="col-6 col-md-2 text-right font-weight-bold"
                                    >
                                        Comprobante de Pago:
                                    </div>
                                    <div class="col-6 col-md-10">
                                        <a
                                            class="btn btn-primary"
                                            :href="oOrdenPedido.url_comprobante"
                                            target="_blank"
                                            ><i
                                                class="fa fa-external-link-alt"
                                            ></i
                                        ></a>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div class="col-12" style="overflow: auto">
                                        <strong class="w-100 text-center"
                                            >Productos:</strong
                                        >
                                        <table class="table table-borderd">
                                            <thead>
                                                <tr>
                                                    <th>N°</th>
                                                    <th>Producto</th>
                                                    <th>Cantidad</th>
                                                    <th>Precio</th>
                                                    <th>Subtotal</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr
                                                    v-for="(
                                                        item, index
                                                    ) in oOrdenPedido.orden_detalles"
                                                >
                                                    <td>{{ index + 1 }}</td>
                                                    <td>
                                                        {{
                                                            item.producto.nombre
                                                        }}
                                                    </td>
                                                    <td>{{ item.cantidad }}</td>
                                                    <td>{{ item.precio }}</td>
                                                    <td>
                                                        {{ item.precio_total }}
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td
                                                        colspan="4"
                                                        class="text-right font-weight-bold"
                                                    >
                                                        TOTAL
                                                    </td>
                                                    <td>
                                                        {{ oOrdenPedido.total }}
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td
                                                        colspan="4"
                                                        class="text-right font-weight-bold"
                                                    >
                                                        DESCUENTO
                                                    </td>
                                                    <td>
                                                        {{
                                                            oOrdenPedido.descuento
                                                        }}%
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td
                                                        colspan="4"
                                                        class="text-right font-weight-bold"
                                                    >
                                                        TOTAL FINAL
                                                    </td>
                                                    <td>
                                                        {{
                                                            oOrdenPedido.total_final
                                                        }}
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="row mb-2">
                                    <div
                                        class="col-6 col-md-2 text-right font-weight-bold"
                                    >
                                        Estado:
                                    </div>
                                    <div class="col-6 col-md-10">
                                        <span>{{ oOrdenPedido.estado }}</span>
                                    </div>
                                </div>
                                <div
                                    class="row mb-2"
                                    v-if="
                                        oOrdenPedido.estado ==
                                            'PEDIDO PENDIENTE' &&
                                        oOrdenPedido.status != 0 &&
                                        oUser &&
                                        (oUser.tipo == 'ADMINISTRADOR' ||
                                            oUser.tipo == 'VENDEDOR')
                                    "
                                >
                                    <div
                                        class="col-6 col-md-2 text-right font-weight-bold"
                                    >
                                        Acciones:
                                    </div>
                                    <div class="col-6 col-md-10">
                                        <button
                                            class="btn btn-primary btn-block btn-flat"
                                            @click="actualizarEstado"
                                            :disabled="actualizando"
                                            v-html="txtBotonProcesar"
                                        ></button>
                                        <button
                                            class="btn btn-danger btn-block btn-flat"
                                            @click="eliminarOrdenPedido"
                                        >
                                            <i class="fa fa-ban"></i> Anular
                                            Orden
                                        </button>
                                    </div>
                                </div>
                                <div
                                    class="row mb-2"
                                    v-if="
                                        oOrdenPedido.status == 0 &&
                                        oUser &&
                                        oUser.tipo == 'ADMINISTRADOR'
                                    "
                                >
                                    <div
                                        class="col-6 col-md-2 text-right font-weight-bold"
                                    >
                                        Acciones:
                                    </div>
                                    <div class="col-6 col-md-10">
                                        <button
                                            class="btn btn-success btn-block btn-flat"
                                            @click="rehabilitar"
                                        >
                                            <i class="fa fa-check"></i>
                                            Rehabilitar Orden
                                        </button>
                                    </div>
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
    props: ["id"],
    data() {
        return {
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oOrdenPedido: {
                id: 0,
                codigo: "",
                nro: "",
                configuracion_pago_id: "",
                celular: "",
                comprobante: "",
                lat: "",
                lng: "",
                total: "",
                estado: "",
                user_id: "",
                fecha_registro: "",
                fecha_registro_t: "",
                orden_detalles: [],
                user: {
                    id: 0,
                    full_name: "",
                },
                configuracion_pago: {
                    banco: "",
                    nro_cuenta: "",
                    qr: "",
                },
            },
            actualizando: false,
            oUser: null,
        };
    },
    computed: {
        txtBotonProcesar() {
            if (this.actualizando) {
                return `<i class="fa fa-spinner fa-spin"></i> Procesando...`;
            }
            return `<i class="fa fa-check"></i> Orden procesada`;
        },
    },
    mounted() {
        this.getOrdenPedido();
        this.loadingWindow.close();
        this.getAuth();
    },
    methods: {
        getAuth() {
            axios
                .get(main_url + "/admin/usuarios/userActual")
                .then((response) => {
                    this.oUser = response.data;
                });
        },
        recargaFormulario(id) {
            this.$router.push({
                name: "orden_pedidos.ticket",
                params: {
                    id: id,
                    imprime: true,
                },
            });
            // location.reload();
        },
        getOrdenPedido() {
            axios.get("/admin/orden_pedidos/" + this.id).then((response) => {
                this.oOrdenPedido = response.data.orden_pedido;
                if (this.oOrdenPedido.entrega == "DOMICILIO") {
                    this.cargaMapaGoogle(
                        this.oOrdenPedido.lat,
                        this.oOrdenPedido.lng
                    );
                }
            });
        },
        actualizarEstado() {
            Swal.fire({
                title: "¿Quierés actualizar el estado del pedido?",
                html: `Cambiar a: <strong>ORDEN PROCESADA</strong>`,
                showCancelButton: true,
                confirmButtonColor: "#28a745",
                confirmButtonText: "Si, cambiar",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    this.actualizando = true;
                    axios
                        .post(
                            "/admin/orden_pedidos/actualiza_estado/" +
                                this.oOrdenPedido.id,
                            {
                                _method: "PATCH",
                                estado: "ORDEN PROCESADA",
                            }
                        )
                        .then((res) => {
                            this.getOrdenPedido();

                            this.actualizando = false;
                            Swal.fire({
                                icon: "success",
                                title: res.data.message,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                        })
                        .catch((error) => {
                            this.actualizando = false;
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
        eliminarOrdenPedido() {
            Swal.fire({
                title: "¿Quierés anular este registro?",
                showCancelButton: true,
                confirmButtonColor: "#c82333",
                confirmButtonText: "Si, anular",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    axios
                        .post("/admin/orden_pedidos/" + this.oOrdenPedido.id, {
                            _method: "DELETE",
                        })
                        .then((res) => {
                            this.getOrdenPedido();

                            Swal.fire({
                                icon: "success",
                                title: res.data.message,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.$router.push({ name: "orden_pedidos.index" });
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
        rehabilitar() {
            Swal.fire({
                title: "¿Quierés volver a habilitar este registro?",
                showCancelButton: true,
                confirmButtonColor: "#149fda",
                confirmButtonText: "Si, habilitar",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    axios
                        .post(
                            "/admin/orden_pedidos/habilitar/" +
                                this.oOrdenPedido.id,
                            {
                                _method: "PATCH",
                            }
                        )
                        .then((res) => {
                            this.getOrdenPedido();

                            Swal.fire({
                                icon: "success",
                                title: res.data.message,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.$router.push({ name: "orden_pedidos.index" });
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
        async cargaMapaGoogle(lat, lng, drag = false, dir = "") {
            lat = parseFloat(lat);
            lng = parseFloat(lng);
            // Inicializa el mapa
            const { Map, InfoWindow } = await google.maps.importLibrary("maps");
            const { AdvancedMarkerElement } = await google.maps.importLibrary(
                "marker"
            );
            const map = new Map(document.getElementById("google_map"), {
                zoom: 18,
                center: { lat: lat, lng: lng },
                mapId: mapa_id,
            });
            const infoWindow = new InfoWindow();
            // Crea un marcador en el centro del mapa
            const marker_map = new AdvancedMarkerElement({
                map,
                position: { lat: lat, lng: lng },
                gmpDraggable: drag,
                // title:""
            });

            // evento click sobre el marcador
            infoWindow.close();
            infoWindow.setContent("Ubicación Entrega");
            marker_map.addListener("click", () => {
                infoWindow.open(marker_map.map, marker_map);
            });
        },
    },
};
</script>
<style>
#google_map {
    width: 100%;
    height: 300px;
}
</style>
