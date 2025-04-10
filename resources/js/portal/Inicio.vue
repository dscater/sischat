<template>
    <div class="contenedor_inicio">
        <section
            class="product-tabs section-padding position-relative wow fadeIn animated animated animated"
            style="visibility: visible"
        >
            <div class="bg-square"></div>
            <div class="container">
                <div class="tab-header">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button
                                class="nav-link active"
                                id="nav-tab-one"
                                data-bs-toggle="tab"
                                data-bs-target="#tab-one"
                                type="button"
                                role="tab"
                                aria-controls="tab-one"
                                aria-selected="true"
                            >
                                Populares
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button
                                class="nav-link"
                                id="nav-tab-two"
                                data-bs-toggle="tab"
                                data-bs-target="#tab-two"
                                type="button"
                                role="tab"
                                aria-controls="tab-two"
                                aria-selected="false"
                            >
                                Nuevos Productos
                            </button>
                        </li>
                    </ul>
                    <router-link
                        :to="{ name: 'portal.productos' }"
                        class="view-more d-none d-md-flex"
                        >Ver mas<i class="fi-rs-angle-double-small-right"></i
                    ></router-link>
                </div>
                <!--End nav-tabs-->
                <div
                    class="tab-content wow fadeIn animated animated animated"
                    id="myTabContent"
                    style="visibility: visible"
                >
                    <div
                        class="tab-pane fade show active"
                        id="tab-one"
                        role="tabpanel"
                        aria-labelledby="tab-one"
                    >
                        <div class="row product-grid-4">
                            <div
                                class="col-lg-3 col-md-4 col-12 col-sm-6"
                                v-for="item in listPopulares"
                            >
                                <div class="product-cart-wrap mb-30">
                                    <div class="product-img-action-wrap">
                                        <div
                                            class="product-img product-img-zoom"
                                        >
                                            <div href="shop-product-right.html">
                                                <img
                                                    class="default-img"
                                                    :src="item.url_imagen"
                                                    alt=""
                                                />
                                                <!-- <img
                                                    class="hover-img"
                                                    :src="item.url_imagen"
                                                    alt=""
                                                /> -->
                                            </div>
                                        </div>
                                        <!-- <div class="product-action-1">
                                            <a
                                                aria-label="Quick view"
                                                class="action-btn hover-up"
                                                data-bs-toggle="modal"
                                                data-bs-target="#quickViewModal"
                                                ><i class="fi-rs-eye"></i
                                            ></a>
                                            <a
                                                aria-label="Add To Wishlist"
                                                class="action-btn hover-up"
                                                href="shop-wishlist.html"
                                                ><i class="fi-rs-heart"></i
                                            ></a>
                                            <a
                                                aria-label="Compare"
                                                class="action-btn hover-up"
                                                href="shop-compare.html"
                                                ><i class="fi-rs-shuffle"></i
                                            ></a>
                                        </div> -->
                                        <div
                                            class="product-badges product-badges-position product-badges-mrg"
                                        >
                                            <!-- <span class="hot">Hot</span> -->
                                        </div>
                                    </div>
                                    <div class="product-content-wrap">
                                        <div class="product-category">
                                            <span>{{
                                                item.categoria.nombre
                                            }}</span>
                                        </div>
                                        <h2>
                                            <span>{{
                                                item.nombre
                                            }}</span>
                                        </h2>
                                        <div class="product-price">
                                            <span>Bs. {{ item.precio }} </span>
                                            <!-- <span class="old-price"
                                                >$245.8</span
                                            > -->
                                        </div>
                                        <div class="product-action-1 show">
                                            <a
                                                aria-label="Añadir al carrito"
                                                class="action-btn hover-up"
                                                @click.prevent="
                                                    showModalProducto(item.id)
                                                "
                                                ><i
                                                    class="fi-rs-shopping-bag-add"
                                                ></i
                                            ></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--End product-grid-4-->
                    </div>
                    <!--En tab one (Populares)-->
                    <div
                        class="tab-pane fade"
                        id="tab-two"
                        role="tabpanel"
                        aria-labelledby="tab-two"
                    >
                        <div class="row product-grid-4">
                            <div
                                class="col-lg-3 col-md-4 col-12 col-sm-6"
                                v-for="item in listNuevos"
                            >
                                <div class="product-cart-wrap mb-30">
                                    <div class="product-img-action-wrap">
                                        <div
                                            class="product-img product-img-zoom"
                                        >
                                            <div href="shop-product-right.html">
                                                <img
                                                    class="default-img"
                                                    :src="item.url_imagen"
                                                    alt=""
                                                />
                                                <!-- <img
                                                    class="hover-img"
                                                    :src="item.url_imagen"
                                                    alt=""
                                                /> -->
                                            </div>
                                        </div>
                                        <!-- <div class="product-action-1">
                                            <a
                                                aria-label="Quick view"
                                                class="action-btn hover-up"
                                                data-bs-toggle="modal"
                                                data-bs-target="#quickViewModal"
                                                ><i class="fi-rs-eye"></i
                                            ></a>
                                            <a
                                                aria-label="Add To Wishlist"
                                                class="action-btn hover-up"
                                                href="shop-wishlist.html"
                                                ><i class="fi-rs-heart"></i
                                            ></a>
                                            <a
                                                aria-label="Compare"
                                                class="action-btn hover-up"
                                                href="shop-compare.html"
                                                ><i class="fi-rs-shuffle"></i
                                            ></a>
                                        </div> -->
                                        <!-- <div
                                            class="product-badges product-badges-position product-badges-mrg"
                                        >
                                            <span class="hot">Hot</span>
                                        </div> -->
                                    </div>
                                    <div class="product-content-wrap">
                                        <div class="product-category">
                                            <span href="shop-grid-right.html"
                                                >{{ item.categoria.nombre }}
                                            </span>
                                        </div>
                                        <h2>
                                            <span>{{ item.nombre }}</span>
                                        </h2>
                                        <div class="product-price">
                                            <span>Bs. {{ item.precio }} </span>
                                            <!-- <span class="old-price"
                                                >$245.8</span
                                            > -->
                                        </div>
                                        <div class="product-action-1 show">
                                            <a
                                                aria-label="Add To Cart"
                                                class="action-btn hover-up"
                                                href="shop-cart.html"
                                                ><i
                                                    class="fi-rs-shopping-bag-add"
                                                ></i
                                            ></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--End product-grid-4-->
                    </div>
                    <!--En tab two (Nuevos)-->
                </div>
                <!--End tab-content-->
            </div>
        </section>

        <!-- Product -->
        <section class="sec-blog bg0 p-b-90 fondo_seccion">
            <div
                class="container-fluid p-lr-40 mt-5 border fondo_tarjeta wow fadeInUp"
                wow-data-delay="0.2s"
            >
                <div class="row text-gray">
                    <div class="col-md-12 text-center">
                        <h4 class="font-weight-bold text-md mt-3 mb-3">
                            UBICACIÓN
                        </h4>
                        <div
                            v-html="oConfiguracion.ubicacion"
                            class="ubicacion_portal"
                        ></div>
                    </div>
                </div>
            </div>
        </section>
        <ModalProducto
            :id="id_seleccionado"
            :mostrar_modal="muestra_modal_producto"
            @close="muestra_modal_producto = false"
        ></ModalProducto>
    </div>
</template>
<script>
import ModalProducto from "./componentes/ModalProducto.vue";
export default {
    components: {
        ModalProducto,
    },
    data() {
        return {
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            url_asset: "",
            oConfiguracion: {
                nombre_sistema: "",
                alias: "",
                razon_social: "",
                nit: "",
                ciudad: "",
                dir: "",
                fono: "",
                web: "",
                actividad: "",
                correo: "",
                logo: "",
                servicios: "",
                servicios_img: "",
                mision: "",
                mision_img: "",
                vision: "",
                vision_img: "",
                nosotros: "",
                nosotros_img: "",
                facebook: "",
                instagram: "",
                twitter: "",
                youtube: "",
                ubicacion: "",
            },
            listPopulares: [],
            listNuevos: [],
            id_seleccionado: 0,
            muestra_modal_producto: false,
        };
    },
    mounted() {
        let self = this;
        setTimeout(function () {
            self.loadingWindow.close();
        }, 500);
        this.getConfiguracion();
        this.getUrlAsset();
        this.getProductosPopulares();
        this.getNuevosProductos();
    },
    methods: {
        getProductosPopulares() {
            axios
                .get(main_url + "/portal/productosPopulares")
                .then((response) => {
                    this.listPopulares = response.data.productos;
                });
        },
        getNuevosProductos() {
            axios.get(main_url + "/portal/nuevosProductos").then((response) => {
                this.listNuevos = response.data.productos;
            });
        },
        getConfiguracion() {
            axios
                .get(main_url + "/configuracion/getConfiguracion")
                .then((response) => {
                    this.oConfiguracion = response.data.configuracion;
                });
        },
        getUrlAsset() {
            axios.get(main_url + "/url_asset").then((response) => {
                this.url_asset = response.data;
            });
        },
        aplicarFiltros(key, valor) {
            this.loading = true;
            this.filtro[key] = valor;
            if (this.currentPage != 1) {
                this.currentPage = 1;
            } else {
                this.getProductos();
            }
        },
        showModalProducto(id) {
            this.id_seleccionado = id;
            this.muestra_modal_producto = true;
        },
    },
};
</script>
<style></style>
