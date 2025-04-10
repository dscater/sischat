<template>
    <!-- Modal1 -->
    <div
        class="modal fade custom-modal"
        :class="[muestra ? 'show bg-transparente' : '']"
        :style="muestra ? 'display:block;' : ''"
    >
        <div class="modal-dialog">
            <div class="modal-content">
                <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="modal"
                    aria-label="Close"
                    @click="cerrar"
                ></button>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 col-sm-12 col-xs-12">
                            <div class="detail-gallery">
                                <!-- <span class="zoom-icon"
                                    ><i class="fi-rs-search"></i
                                ></span> -->
                                <!-- MAIN SLIDES -->
                                <div
                                    class="product-image-slider slick-initialized slick-slider"
                                >
                                    <img
                                        :src="oProducto.url_imagen"
                                        alt="Imagen"
                                    />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-12 col-xs-12">
                            <div class="detail-info">
                                <h3 class="title-detail mt-30">
                                    {{ oProducto.nombre }}
                                </h3>

                                <div class="clearfix product-price-cover">
                                    <div
                                        class="product-price primary-color float-left"
                                    >
                                        <ins
                                            ><span class="text-brand"
                                                >Bs.
                                                {{ oProducto.precio }}</span
                                            ></ins
                                        >
                                        <!-- <ins
                                            ><span
                                                class="old-price font-md ml-15"
                                                >$200.00</span
                                            ></ins
                                        >
                                        <span
                                            class="save-price font-md color3 ml-15"
                                            >25% Off</span
                                        > -->
                                    </div>
                                </div>
                                <div
                                    class="bt-1 border-color-1 mt-15 mb-15"
                                ></div>
                                <div class="short-desc mb-30">
                                    <p class="font-sm">
                                        {{ oProducto.descripcion }}
                                    </p>
                                </div>
                                <div
                                    class="bt-1 border-color-1 mt-30 mb-30"
                                ></div>
                                <div class="detail-extralink">
                                    <div class="detail-qty border radius">
                                        <a
                                            href="#"
                                            class="qty-down"
                                            @click.prevent="restaCantidad"
                                            ><i
                                                class="fi-rs-angle-small-down"
                                            ></i
                                        ></a>
                                        <span class="qty-val">{{
                                            cantidad_agregar
                                        }}</span>
                                        <a
                                            href="#"
                                            class="qty-up"
                                            @click.prevent="sumaCantidad"
                                            ><i class="fi-rs-angle-small-up"></i
                                        ></a>
                                    </div>
                                    <div class="product-extra-link2">
                                        <button
                                            type="button"
                                            class="button button-add-to-cart"
                                            @click="agregarCarrito"
                                        >
                                            Añadir al carrito
                                        </button>
                                    </div>
                                </div>
                                <ul
                                    class="product-meta font-xs color-grey mt-50"
                                >
                                    <li class="mb-5">
                                        Categoría:
                                        {{ oProducto.categoria.nombre }}
                                    </li>
                                    <li>
                                        Disponibles:<span
                                            class="in-stock text-success ml-5"
                                            >{{
                                                oProducto.stock_actual
                                            }}
                                            unidades disponibles</span
                                        >
                                    </li>
                                </ul>
                            </div>
                            <!-- Detail Info -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props: ["id", "mostrar_modal"],
    data() {
        return {
            oProducto: {
                id: 0,
                nombre: "",
                descripcion: "",
                precio: "",
                stock_actual: "",
                url_imagen: "",
                categoria: { nombre: "", descripcion: "" },
            },
            cargando_producto: true,
            muestra: false,
            cantidad_agregar: 1,
        };
    },
    watch: {
        mostrar_modal(newVal) {
            this.muestra = newVal;
            if (this.id != 0) {
                console.log("asdasd");
                $("body").addClass("modal-open");
                this.cantidad_agregar = 1;
                this.getProducto();
            }
        },
    },
    mounted() {},
    methods: {
        getProducto() {
            this.cargando_producto = true;
            axios
                .get(main_url + "/portal/getProducto/" + this.id)
                .then((response) => {
                    let self = this;
                    this.oProducto = response.data.producto;
                    setTimeout(function () {
                        self.initSlick3();
                        self.cargando_producto = false;
                    }, 500);
                });
        },
        agregarCarrito() {
            if (this.cantidad_agregar > 0) {
                let carrito = [];
                if (localStorage.getItem("carrito_siscrm")) {
                    carrito = JSON.parse(
                        localStorage.getItem("carrito_siscrm")
                    );
                }
                let precio_total =
                    parseFloat(this.cantidad_agregar) *
                    parseFloat(this.oProducto.precio);
                precio_total = precio_total.toFixed(2);

                // let cantidad_agregada = this.cantidad_agregar;

                // if (cantidad_agregada > this.oProducto.stock_actual) {
                //     cantidad_agregada = this.oProducto.stock_actual;
                // }

                carrito.push({
                    orden_pedido_id: 0,
                    producto_id: this.oProducto.id,
                    cantidad: this.cantidad_agregar,
                    precio: this.oProducto.precio,
                    precio_total: precio_total,
                    categoria: this.oProducto.categoria,
                    producto: this.oProducto,
                });
                localStorage.setItem("carrito_siscrm", JSON.stringify(carrito));
                this.cantidad_agregar = 1;
                EventBus.$emit("producto_agregado");
                this.cerrar();
                Swal.fire({
                    icon: "success",
                    title: "Correcto",
                    html: "Producto agregado correctamente",
                    showConfirmButton: false,
                    timer: 1500,
                });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    html: "La cantidad no debe ser menor a 1",
                    showConfirmButton: true,
                    confirmButtonColor: "#c57a40",
                    confirmButtonText: "Aceptar",
                });
            }
        },
        cerrar() {
            this.oProducto = {
                id: 0,
                nombre: "",
                descripcion: "",
                precio: "",
                stock_actual: "",
                url_imagen: "",
                categoria: { nombre: "", descripcion: "" },
            };
            this.$emit("close");
        },
        initSlick3() {
            $(document).ready(function () {
                $(".wrap-slick3").each(function () {
                    $(this).find(".slick3").slick({
                        slidesToShow: 1,
                        slidesToScroll: 1,
                        fade: true,
                        infinite: true,
                        autoplay: false,
                    });
                });

                // GALERIA
                $(".gallery-lb").each(function () {
                    // the containers for all your galleries
                    $(this).magnificPopup({
                        delegate: "a", // the selector for gallery item
                        type: "image",
                        gallery: {
                            enabled: true,
                        },
                        mainClass: "mfp-fade",
                    });
                });
            });
        },
        validaCantidad() {
            if (this.oProducto.id != 0) {
                if (this.cantidad_agregar > this.oProducto.stock_actual) {
                    this.cantidad_agregar = this.oProducto.stock_actual;
                } else if (this.cantidad_agregar < 1) {
                    this.cantidad_agregar = 1;
                }
            } else {
                this.cantidad_agregar = "";
            }
        },

        sumaCantidad() {
            if (this.oProducto.id != 0) {
                if (this.cantidad_agregar < this.oProducto.stock_actual) {
                    this.cantidad_agregar++;
                } else {
                    this.cantidad_agregar = this.oProducto.stock_actual;
                }
            } else {
                this.cantidad_agregar = "";
            }
        },
        restaCantidad() {
            if (this.oProducto.id != 0) {
                if (this.cantidad_agregar > 1) {
                    this.cantidad_agregar--;
                } else {
                    this.cantidad_agregar = 1;
                }
            } else {
                this.cantidad_agregar = "";
            }
        },
    },
};
</script>
