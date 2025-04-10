<template>
    <!-- Blog -->
    <section class="mt-50 mb-50">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="table-responsive">
                        <table class="table shopping-summery text-center clean">
                            <thead>
                                <tr class="main-heading">
                                    <th scope="col">Imagen</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Precio</th>
                                    <th scope="col">Cantidad</th>
                                    <th scope="col">Subtotal</th>
                                    <th scope="col">Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <template
                                    v-if="oPedido.detalle_pedidos.length > 0"
                                >
                                    <tr
                                        v-for="(
                                            item, index
                                        ) in oPedido.detalle_pedidos"
                                    >
                                        <td class="image product-thumbnail">
                                            <img
                                                :src="item.producto.url_imagen"
                                                alt="#"
                                            />
                                        </td>
                                        <td class="product-des product-name">
                                            <h5 class="product-name">
                                                <span
                                                    href="shop-product-right.html"
                                                    >{{
                                                        item.producto.nombre
                                                    }}</span
                                                >
                                            </h5>
                                            <p class="font-xs">
                                                {{ item.producto.descripcion }}
                                            </p>
                                        </td>
                                        <td class="price" data-title="Price">
                                            <span>Bs. {{ item.precio }} </span>
                                        </td>
                                        <td
                                            class="text-center"
                                            data-title="Stock"
                                        >
                                            <div
                                                class="detail-qty border radius m-auto"
                                            >
                                                <a
                                                    href="#"
                                                    @click.prevent="
                                                        actualizaCantidadMenos(
                                                            index
                                                        )
                                                    "
                                                    class="qty-down"
                                                    ><i
                                                        class="fi-rs-angle-small-down"
                                                    ></i
                                                ></a>
                                                <span class="qty-val">{{
                                                    item.cantidad
                                                }}</span>
                                                <a
                                                    href="#"
                                                    @click.prevent="
                                                        actualizaCantidadMas(
                                                            index
                                                        )
                                                    "
                                                    class="qty-up"
                                                    ><i
                                                        class="fi-rs-angle-small-up"
                                                    ></i
                                                ></a>
                                            </div>
                                        </td>
                                        <td
                                            class="text-right"
                                            data-title="Cart"
                                        >
                                            <span
                                                >Bs. {{ item.precio_total }}
                                            </span>
                                        </td>
                                        <td class="action" data-title="Remove">
                                            <a
                                                href="#"
                                                class="text-muted"
                                                @click.prevent="
                                                    eliminarProducto(index)
                                                "
                                                ><i class="fi-rs-trash"></i
                                            ></a>
                                        </td>
                                    </tr>
                                    <!-- <tr>
                                        <td colspan="6" class="text-end">
                                            <a href="#" class="text-muted">
                                                <i
                                                    class="fi-rs-cross-small"
                                                ></i>
                                                Clear Cart</a
                                            >
                                        </td>
                                    </tr> -->
                                </template>
                            </tbody>
                        </table>
                    </div>
                    <div class="cart-action text-end">
                        <router-link
                            class="btn"
                            :to="{ name: 'portal.productos' }"
                            ><i class="fi-rs-shopping-bag mr-10"></i>Seguir
                            comprando</router-link
                        >
                    </div>
                    <div class="divider center_icon mt-50 mb-50">
                        <i class="fi-rs-fingerprint"></i>
                    </div>
                    <div class="row mb-50">
                        <div class="col-lg-6 col-md-12">
                            <div class="mb-30 mt-50">
                                <div class="heading_s1 mb-3">
                                    <h4>Ingresar cupón (opcional)</h4>
                                </div>
                                <div class="total-amount">
                                    <div class="left">
                                        <div class="coupon">
                                            <div
                                                class="form-row row justify-content-center"
                                            >
                                                <div
                                                    class="form-group col-lg-6"
                                                >
                                                    <input
                                                        class="font-medium"
                                                        v-model="texto_cupon"
                                                        placeholder="Ingresa tu cupón"
                                                    />
                                                </div>
                                                <div
                                                    class="form-group col-lg-6"
                                                >
                                                    <button
                                                        class="btn btn-sm"
                                                        @click="verificaCupon"
                                                    >
                                                        <i
                                                            class="fi-rs-label mr-10"
                                                        ></i
                                                        >Aplicar
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-12">
                            <div
                                class="border p-md-4 p-30 border-radius cart-totals"
                            >
                                <div class="heading_s1 mb-3">
                                    <h4>Totales</h4>
                                </div>
                                <div class="table-responsive">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <td class="cart_total_label">
                                                    Carrito Subtotal
                                                </td>
                                                <td class="cart_total_amount">
                                                    <span
                                                        class="font-lg fw-900 text-brand"
                                                        >Bs.
                                                        {{
                                                            oPedido.monto_total
                                                        }}</span
                                                    >
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="cart_total_label">
                                                    Descuento
                                                </td>
                                                <td class="cart_total_amount">
                                                    <span class="">
                                                        {{
                                                            oCupon
                                                                ? oCupon.descuento +
                                                                  "%"
                                                                : "0%"
                                                        }}</span
                                                    >
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="cart_total_label">
                                                    Total
                                                </td>
                                                <td class="cart_total_amount">
                                                    <strong
                                                        ><span
                                                            class="font-xl fw-900 text-brand"
                                                            >Bs.
                                                            {{
                                                                oPedido.total_final
                                                            }}</span
                                                        ></strong
                                                    >
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="col-12 mt-3 px-0">
                                        <div class="form-group">
                                            <label class=""
                                                >Seleccionar forma de
                                                pago*</label
                                            >
                                            <select
                                                type="text"
                                                class="form-control w-100"
                                                :class="{
                                                    'is-invalid':
                                                        errors.configuracion_pago_id,
                                                }"
                                                v-model="
                                                    oPedido.configuracion_pago_id
                                                "
                                                @change="getInfoBanco"
                                            >
                                                <option value="">
                                                    - Seleccione -
                                                </option>
                                                <option
                                                    v-for="item in listConfiguracionPagos"
                                                    :value="item.id"
                                                >
                                                    {{ item.banco }}
                                                </option>
                                            </select>
                                            <span
                                                class="error invalid-feedback"
                                                v-if="
                                                    errors.configuracion_pago_id
                                                "
                                                v-text="
                                                    errors
                                                        .configuracion_pago_id[0]
                                                "
                                            ></span>
                                        </div>
                                    </div>
                                    <div
                                        class="col-12 mt-2 px-0"
                                        v-if="
                                            banco_actual &&
                                            oPedido.configuracion_pago_id != ''
                                        "
                                    >
                                        <p>{{ banco_actual.nro_cuenta }}</p>
                                        <img
                                            :src="banco_actual.url_qr"
                                            alt="QR"
                                            style="max-width: 200px"
                                        />
                                    </div>
                                    <div class="form-group col-12 px-0 mt-2">
                                        <label class="">Entrega*</label>
                                        <select
                                            class="form-control"
                                            :class="{
                                                'is-invalid': errors.entrega,
                                            }"
                                            v-model="oPedido.entrega"
                                        >
                                            <option value="">
                                                - Seleccione -
                                            </option>
                                            <option value="DOMICILIO">
                                                DOMICILIO
                                            </option>
                                            <option value="TIENDA">
                                                TIENDA
                                            </option>
                                        </select>
                                        <span
                                            class="error invalid-feedback"
                                            v-if="errors.entrega"
                                            v-text="errors.entrega[0]"
                                        ></span>
                                    </div>
                                    <div
                                        class="col-12 px-0 mt-3"
                                        v-show="oPedido.entrega == 'DOMICILIO'"
                                    >
                                        <label class=""
                                            >Selecciona tu ubicación:</label
                                        >
                                        <div id="google_map"></div>
                                    </div>
                                    <div class="form-group col-md-12 mt-3 px-0">
                                        <label class=""
                                            >Cargar comprobante de pago*</label
                                        >
                                        <input
                                            type="file"
                                            class="form-control"
                                            :class="{
                                                'is-invalid':
                                                    errors.comprobante,
                                            }"
                                            ref="input_file"
                                            @change="cargaArchivo"
                                        /><span
                                            class="error invalid-feedback"
                                            v-if="errors.comprobante"
                                            v-text="errors.comprobante[0]"
                                        ></span>
                                    </div>
                                </div>
                                <template
                                    v-if="oUser && oUser.tipo == 'CLIENTE'"
                                >
                                    <div class="row mb-2">
                                        <div
                                            class="col-12 text-center contenedor_captcha"
                                            :class="{
                                                'is-invalid': errors.captcha,
                                            }"
                                        >
                                            <vue-recaptcha
                                                :sitekey="key_secret"
                                                ref="recaptcha"
                                                @verify="verificaCaptcha"
                                                @error="errorCaptcha"
                                            >
                                            </vue-recaptcha>
                                            <span
                                                class="error invalid-feedback d-block"
                                                v-if="errors.captcha"
                                                v-text="errors.captcha[0]"
                                            ></span>
                                        </div>
                                    </div>
                                    <button
                                        class="btn"
                                        :disabled="enviando || btnDisabled"
                                        @click="prepararEnvio"
                                        v-html="txtBoton"
                                    ></button>
                                </template>
                                <template v-else>
                                    <p
                                        class="w-100 text-center"
                                        v-if="oUser && oUser.id"
                                    >
                                        Debes
                                        <a href="/administracion"
                                            >iniciar sesión</a
                                        >
                                        como CLIENTE para poder registrar el
                                        pedido
                                    </p>
                                    <p class="w-100 text-center" v-else>
                                        Debes
                                        <a href="/administracion"
                                            >iniciar sesión</a
                                        >
                                        para poder registrar el pedido
                                    </p>
                                </template>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>
<script>
import { VueRecaptcha } from "vue-recaptcha";
export default {
    components: { VueRecaptcha },
    data() {
        return {
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oPedido: {
                configuracion_pago_id: "",
                celular: "",
                comprobante: null,
                lat: "",
                lng: "",
                estado: "PENDIENTE",
                monto_total: "0.00",
                total_final: "0.00",
                detalle_pedidos: [],
                cupon: "",
            },
            errors: [],
            listConfiguracionPagos: [],
            enviando: false,
            marker_map: null,
            banco_actual: null,
            oUser: null,
            key_secret: key_captcha_local,
            captcha: null,
            btnDisabled: true,
            texto_cupon: "",
            oCupon: null,
        };
    },
    computed: {
        txtBoton() {
            if (this.btnDisabled) {
                return "Selecciona el captcha para continuar";
            }
            if (this.enviando) {
                return "Procesando...";
            }
            return ` <i class="fi-rs-box-alt mr-10"></i> Procesar el pedido`;
        },
    },
    mounted() {
        this.loadingWindow.close();
        this.getAuth();
        this.getConfiguracionPagos();
        this.cargaMapaGoogle("-16.496059", "-68.133345", true);
        this.getCarrito();
        $(".js-panel-cart").removeClass("show-header-cart");
        $(".js-sidebar").removeClass("show-sidebar");
    },
    methods: {
        errorCaptcha() {},
        verificaCaptcha(datos) {
            let config = {
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
            };
            let formdata = new FormData();
            formdata.append("secret", this.key_secret);
            formdata.append("g-recaptcha-response", datos);
            axios
                .post("/verifica_captcha", formdata, config)
                .then((response) => {
                    if (response.data.success) {
                        this.captcha = response.data.success;
                        this.btnDisabled = false;
                    } else {
                        this.btnDisabled = true;
                    }
                })
                .catch((error) => {
                    this.btnDisabled = true;
                });
        },
        verificaCupon() {
            axios
                .get(main_url + "/veririca_cupon", {
                    params: {
                        texto_cupon: this.texto_cupon,
                    },
                })
                .then((response) => {
                    if (response.data.sw) {
                        this.oCupon = response.data.cupon;
                        this.oPedido.cupon = this.oCupon.texto;
                    } else {
                        this.oCupon = null;
                    }
                    this.getTotal();
                });
        },
        getAuth() {
            axios.get(main_url + "/auth").then((response) => {
                this.oUser = response.data;
            });
        },
        getCarrito() {
            if (localStorage.getItem("carrito_siscrm")) {
                this.oPedido.detalle_pedidos = JSON.parse(
                    localStorage.getItem("carrito_siscrm")
                );
                this.cantidad_carrito = this.oPedido.detalle_pedidos.length;
            } else {
                this.cantidad_carrito;
            }
            this.getTotal();
        },
        getTotal() {
            if (localStorage.getItem("carrito_siscrm")) {
                this.oPedido.detalle_pedidos = JSON.parse(
                    localStorage.getItem("carrito_siscrm")
                );
                let sum_total = this.oPedido.detalle_pedidos.reduce(function (
                    acumulador,
                    objeto
                ) {
                    return acumulador + parseFloat(objeto.precio_total);
                },
                0);
                this.oPedido.monto_total = parseFloat(sum_total).toFixed(2);
                this.oPedido.total_final = parseFloat(sum_total).toFixed(2);
                if (this.oCupon) {
                    let p_descuento = parseFloat(this.oCupon.descuento) / 100;
                    let monto_descontar =
                        parseFloat(this.oPedido.monto_total) * p_descuento;
                    this.oPedido.total_final =
                        parseFloat(this.oPedido.total_final) - monto_descontar;
                    this.oPedido.total_final = parseFloat(
                        this.oPedido.total_final
                    ).toFixed(2);
                }
            } else {
                this.oPedido.monto_total = "0.00";
                this.oPedido.total_final = "0.00";
            }
        },
        eliminarProducto(index) {
            let nombre = this.oPedido.detalle_pedidos[index].producto.nombre;
            Swal.fire({
                title: "¿Quierés eliminar este producto del carrito?",
                html: `<strong>${nombre}</strong>`,
                showCancelButton: true,
                confirmButtonColor: "#dc3545",
                confirmButtonText: "Si, eliminar",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    this.oPedido.detalle_pedidos.splice(index, 1);
                    localStorage.setItem(
                        "carrito_siscrm",
                        JSON.stringify(this.oPedido.detalle_pedidos)
                    );
                    this.getCarrito();
                    EventBus.$emit("producto_agregado");
                }
            });
        },
        actualizaCantidadMas(index) {
            let cantidad = this.oPedido.detalle_pedidos[index].cantidad;
            cantidad++;
            if (
                cantidad <
                this.oPedido.detalle_pedidos[index].producto.stock_actual
            ) {
                this.oPedido.detalle_pedidos[index].cantidad = cantidad;
            } else {
                this.oPedido.detalle_pedidos[index].cantidad =
                    this.oPedido.detalle_pedidos[index].producto.stock_actual;
            }
            this.oPedido.detalle_pedidos[index].precio_total =
                parseFloat(this.oPedido.detalle_pedidos[index].cantidad) *
                parseFloat(this.oPedido.detalle_pedidos[index].precio);
            this.oPedido.detalle_pedidos[index].precio_total = parseFloat(
                this.oPedido.detalle_pedidos[index].precio_total
            ).toFixed(2);
            localStorage.setItem(
                "carrito_siscrm",
                JSON.stringify(this.oPedido.detalle_pedidos)
            );
            this.getTotal();
        },
        actualizaCantidadMenos(index) {
            let cantidad = this.oPedido.detalle_pedidos[index].cantidad;
            cantidad--;
            if (cantidad > 1) {
                this.oPedido.detalle_pedidos[index].cantidad = cantidad;
            } else {
                this.oPedido.detalle_pedidos[index].cantidad = 1;
            }

            this.oPedido.detalle_pedidos[index].precio_total =
                parseFloat(this.oPedido.detalle_pedidos[index].cantidad) *
                parseFloat(this.oPedido.detalle_pedidos[index].precio);
            this.oPedido.detalle_pedidos[index].precio_total = parseFloat(
                this.oPedido.detalle_pedidos[index].precio_total
            ).toFixed(2);
            localStorage.setItem(
                "carrito_siscrm",
                JSON.stringify(this.oPedido.detalle_pedidos)
            );
            this.getTotal();
        },
        detectaCambio(e, index) {
            let valor = e.target.value;
            if (valor != "") {
                let maximo = parseFloat(
                    this.oPedido.detalle_pedidos[index].producto.stock_actual
                );
                let minimo = 1;
                let cantidad = parseFloat(valor);
                this.oPedido.detalle_pedidos[index].cantidad = valor;
                if (cantidad < minimo) {
                    this.oPedido.detalle_pedidos[index].cantidad = 1;
                }
                if (cantidad > maximo) {
                    this.oPedido.detalle_pedidos[index].cantidad = maximo;
                }

                this.oPedido.detalle_pedidos[index].precio_total =
                    parseFloat(this.oPedido.detalle_pedidos[index].cantidad) *
                    parseFloat(this.oPedido.detalle_pedidos[index].precio);
                this.oPedido.detalle_pedidos[index].precio_total = parseFloat(
                    this.oPedido.detalle_pedidos[index].precio_total
                ).toFixed(2);
                localStorage.setItem(
                    "carrito_siscrm",
                    JSON.stringify(this.oPedido.detalle_pedidos)
                );
                this.getTotal();
            }
        },
        prepararEnvio() {
            this.enviando = true;
            let self = this;
            this.errors = [];
            setTimeout(function () {
                self.enviarPedido();
            }, 500);
        },
        getConfiguracionPagos() {
            axios
                .get(main_url + "/configuracion_pagos_portal")
                .then((response) => {
                    console.log(response.data);
                    this.listConfiguracionPagos =
                        response.data.configuracion_pagos;
                });
        },
        getInfoBanco() {
            if (this.oPedido.configuracion_pago_id != "") {
                this.banco_actual = this.listConfiguracionPagos.filter(
                    (elem) => elem.id == this.oPedido.configuracion_pago_id
                )[0];
            }
        },
        enviarPedido() {
            this.enviando = true;

            let formData = new FormData();
            formData.append(
                "configuracion_pago_id",
                this.oPedido.configuracion_pago_id
                    ? this.oPedido.configuracion_pago_id
                    : ""
            );
            formData.append(
                "celular",
                this.oPedido.celular ? this.oPedido.celular : ""
            );
            formData.append(
                "entrega",
                this.oPedido.entrega ? this.oPedido.entrega : ""
            );
            formData.append(
                "cupon",
                this.oPedido.cupon ? this.oPedido.cupon : ""
            );
            formData.append(
                "comprobante",
                this.oPedido.comprobante ? this.oPedido.comprobante : ""
            );
            formData.append("lat", this.oPedido.lat ? this.oPedido.lat : "");
            formData.append("lng", this.oPedido.lng ? this.oPedido.lng : "");
            formData.append("total", this.oPedido.monto_total);
            formData.append(
                "estado",
                this.oPedido.estado ? this.oPedido.estado : ""
            );
            this.oPedido.detalle_pedidos.forEach((elem) => {
                formData.append("productos[]", elem.producto.id);
                formData.append("cantidades[]", elem.cantidad);
                formData.append("precios[]", elem.precio);
                formData.append("precio_total[]", elem.precio_total);
            });

            let config = {
                headers: {
                    "Content-Type": "multipart/form-data",
                },
            };

            axios
                .post(main_url + "/admin/registraOrden", formData, config)
                .then((response) => {
                    Swal.fire({
                        icon: "success",
                        title: "¡Correcto!",
                        html: response.data.message,
                        showConfirmButton: false,
                        timer: 2000,
                    });
                    this.oPedido.detalle_pedidos = [];
                    localStorage.removeItem("carrito_siscrm");
                    this.limpiarOrdenPedido();
                    this.enviando = false;
                })
                .catch((error) => {
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = error.response.data.errors;
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
        },
        limpiarOrdenPedido() {
            this.oPedido.configuracion_pago_id = "";
            this.oPedido.celular = "";
            this.oPedido.comprobante = null;
            this.oPedido.lat = "";
            this.oPedido.lng = "";
            this.oPedido.estado = "PENDIENTE";
            this.oPedido.monto_total = "0.00";
            this.oPedido.total_final = "0.00";
            this.oPedido.detalle_pedidos = [];
            this.oPedido.captcha = false;
            this.oPedido.entrega = "TIENDA";
            this.$refs.input_file.value = null;
        },
        async cargaMapaGoogle(lat, lng, drag = false, dir = "") {
            this.oPedido.lat = lat;
            this.oPedido.lng = lng;
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
            this.marker_map = new AdvancedMarkerElement({
                map,
                position: { lat: lat, lng: lng },
                gmpDraggable: drag,
                // title:""
            });

            // Evento click sobre el mapa
            map.addListener("click", (event) => {
                const newPosition = event.latLng.toJSON();
                if (this.marker_map && this.marker_map.setMap) {
                    this.marker_map.setMap(null); // Eliminar el marcador anterior si existe
                }
                this.marker_map = new AdvancedMarkerElement({
                    map,
                    position: newPosition,
                    gmpDraggable: drag,
                });
                this.oPedido.lat = "" + newPosition.lat;
                this.oPedido.lng = "" + newPosition.lng;
                infoWindow.close();
            });

            // Escucha el evento de arrastrar del marcador
            this.marker_map.addListener("dragend", (event) => {
                const position = this.marker_map.position;
                // console.log(position.lat);
                // console.log(position.lng);
                this.oPedido.lat = "" + position.lat;
                this.oPedido.lng = "" + position.lng;
                console.log(this.oPedido.lat);
                console.log(this.oPedido.lng);
                // infoWindow.close();
                // infoWindow.setContent(
                //     `Pin dropped at: ${position.lat}, ${position.lng}`
                // );
                // infoWindow.open(AME.map, AME);
            });

            // evento click sobre el marcador
            infoWindow.close();
            infoWindow.setContent("Ubicación Entrega");
            this.marker_map.addListener("click", () => {
                infoWindow.open(this.marker_map.map, this.marker_map);
            });
        },
        cargaArchivo(e) {
            this.oPedido.comprobante = e.target.files[0];
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
