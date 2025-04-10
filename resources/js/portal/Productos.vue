<template>
    <div class="contenedor_inicio">
        <div class="container mt-50 mb-50" style="transform: none">
            <div class="row flex-row-reverse" style="transform: none">
                <div class="col-lg-9">
                    <div class="shop-product-fillter">
                        <div class="totall-product">
                            <!-- Search product -->
                            <div class="dis-none panel-search w-full bg-white">
                                <div class="bor8 dis-flex p-l-15">
                                    <input
                                        class="mtext-107 cl2 size-114 plh2 p-r-15 w-100"
                                        type="text"
                                        name="search-product"
                                        placeholder="Buscar"
                                        id="btnBuscarProducto"
                                        v-model="search"
                                        @keyup="searchProductos"
                                    />
                                </div>
                            </div>

                            <p class="font-sm mb-0 pl-3">
                                Total:
                                <strong class="text-brand">{{
                                    total_registros
                                }}</strong>
                                productos
                            </p>
                        </div>
                        <div class="sort-by-product-area">
                            <!-- <div class="sort-by-cover mr-10">
                                <div class="sort-by-product-wrap">
                                    <div class="sort-by">
                                        <span
                                            ><i class="fi-rs-apps"></i
                                            >Show:</span
                                        >
                                    </div>
                                    <div class="sort-by-dropdown-wrap">
                                        <span>
                                            50
                                            <i
                                                class="fi-rs-angle-small-down"
                                            ></i
                                        ></span>
                                    </div>
                                </div>
                                <div class="sort-by-dropdown">
                                    <ul>
                                        <li>
                                            <a class="active" href="#">50</a>
                                        </li>
                                        <li><a href="#">100</a></li>
                                        <li><a href="#">150</a></li>
                                        <li><a href="#">200</a></li>
                                        <li><a href="#">All</a></li>
                                    </ul>
                                </div>
                            </div> -->
                            <div class="sort-by-cover">
                                <div class="sort-by-product-wrap">
                                    <div class="sort-by">
                                        <span
                                            ><i class="fi-rs-apps-sort"></i
                                            >Ordenar por:</span
                                        >
                                    </div>
                                    <div class="sort-by-dropdown-wrap">
                                        <span>
                                            {{ filtro.orden }}
                                            <i
                                                class="fi-rs-angle-small-down"
                                            ></i
                                        ></span>
                                    </div>
                                </div>
                                <div class="sort-by-dropdown">
                                    <ul>
                                        <li>
                                            <a
                                                :class="[
                                                    filtro.orden == 'defecto'
                                                        ? 'active'
                                                        : '',
                                                ]"
                                                @click="
                                                    aplicarFiltros(
                                                        'orden',
                                                        'defecto'
                                                    )
                                                "
                                                href="#"
                                                >Defecto</a
                                            >
                                        </li>
                                        <li>
                                            <a
                                                :class="[
                                                    filtro.orden ==
                                                    'precio_mayor'
                                                        ? 'active'
                                                        : '',
                                                ]"
                                                @click="
                                                    aplicarFiltros(
                                                        'orden',
                                                        'precio_mayor'
                                                    )
                                                "
                                                href="#"
                                                >Precio: Mas alto</a
                                            >
                                        </li>
                                        <li>
                                            <a
                                                :class="[
                                                    filtro.orden ==
                                                    'precio_menor'
                                                        ? 'active'
                                                        : '',
                                                ]"
                                                @click="
                                                    aplicarFiltros(
                                                        'orden',
                                                        'precio_menor'
                                                    )
                                                "
                                                href="#"
                                                >Precio: Bas bajo</a
                                            >
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row product-grid-3">
                        <div
                            class="col-lg-4 col-md-4 col-12 col-sm-6"
                            v-for="item in listProductos"
                        >
                            <div class="product-cart-wrap mb-30">
                                <div class="product-img-action-wrap">
                                    <div class="product-img product-img-zoom">
                                        <div>
                                            <img
                                                class="default-img"
                                                :src="item.url_imagen"
                                                alt=""
                                            />
                                            <!-- <img
                                                class="hover-img"
                                                src="assets/imgs/shop/product-2-2.jpg"
                                                alt=""
                                            /> -->
                                        </div>
                                    </div>
                                    <div class="product-action-1">
                                        <!-- <a
                                            aria-label="Quick view"
                                            class="action-btn hover-up"
                                            data-bs-toggle="modal"
                                            data-bs-target="#quickViewModal"
                                        >
                                            <i class="fi-rs-search"></i
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
                                        ></a> -->
                                    </div>
                                    <!-- <div
                                        class="product-badges product-badges-position product-badges-mrg"
                                    >
                                        <span class="hot">Hot</span>
                                    </div> -->
                                </div>
                                <div class="product-content-wrap">
                                    <div class="product-category">
                                        <span>{{ item.categoria.nombre }}</span>
                                    </div>
                                    <h2>
                                        <span>{{ item.nombre }}</span>
                                    </h2>
                                    <!-- <div class="rating-result" title="90%">
                                        <span>
                                            <span>90%</span>
                                        </span>
                                    </div> -->
                                    <div class="product-price">
                                        <span>Bs. {{ item.precio }} </span>
                                        <!-- <span class="old-price">$245.8</span> -->
                                    </div>
                                    <div class="product-action-1 show">
                                        <a
                                            aria-label="Añadir al carrito"
                                            class="action-btn hover-up"
                                            href="#"
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
                    <!--pagination-->
                    <div
                        class="row mt-5"
                        v-if="listProductos.length > 0"
                    >
                        <div
                            class="col-md-12 pb-3 paginacion_portal pagination"
                        >
                            <b-pagination
                                class="rounded-0"
                                align="center"
                                v-model="currentPage"
                                :total-rows="rows"
                                :per-page="perPage"
                                aria-controls="my-table"
                            ></b-pagination>
                        </div>
                    </div>
                </div>
                <div
                    class="col-lg-3 primary-sidebar sticky-sidebar"
                    style="
                        position: relative;
                        overflow: visible;
                        box-sizing: border-box;
                        min-height: 1px;
                    "
                >
                    <!-- Fillter By Price -->

                    <!-- Product sidebar Widget -->

                    <div
                        class="theiaStickySidebar"
                        style="
                            padding-top: 0px;
                            padding-bottom: 1px;
                            position: static;
                            transform: none;
                        "
                    >
                        <div class="widget-category mb-30">
                            <h5
                                class="section-title style-1 mb-30 wow fadeIn animated animated animated"
                                style="visibility: visible"
                            >
                                Categorías
                            </h5>
                            <ul class="categories">
                                <li
                                    :class="[
                                        filtro.categoria == 'todos'
                                            ? 'active'
                                            : '',
                                    ]"
                                >
                                    <a
                                        href="#"
                                        @click.prevent="
                                            aplicarFiltros('categoria', 'todos')
                                        "
                                        >Todos</a
                                    >
                                </li>
                                <li
                                    v-for="item in listCategorias"
                                    :class="[
                                        filtro.categoria == item.id
                                            ? 'active'
                                            : '',
                                    ]"
                                >
                                    <a
                                        href="#"
                                        @click.prevent="
                                            aplicarFiltros('categoria', item.id)
                                        "
                                        >{{ item.nombre }}</a
                                    >
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
            listCategorias: [],
            listProductos: [],
            total_registros: 0,
            id_seleccionado: 0,
            muestra_modal_producto: false,
            currentPage: 1,
            rows: 12,
            perPage: 5,
            search: "",
            setTimeOutSearch: null,
            loading: false,
            filtro: {
                orden: "defecto",
                precio: "todos",
                categoria: "todos",
            },
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
            },
        };
    },
    watch: {
        currentPage(newVal) {
            this.getProductos(newVal);
        },
    },
    mounted() {
        let self = this;
        setTimeout(function () {
            self.loadingWindow.close();
        }, 500);
        this.getConfiguracion();
        this.getUrlAsset();
        this.getProductos();
        this.getCategorias();
    },
    methods: {
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
        getProductos(page = 1) {
            this.loading = true;
            axios
                .get(main_url + "/portal/listaProductos", {
                    params: {
                        page: page,
                        orden: this.filtro.orden,
                        precio: this.filtro.precio,
                        categoria: this.filtro.categoria,
                        texto: this.search,
                    },
                })
                .then((response) => {
                    this.listProductos = response.data.productos.data;
                    this.rows = response.data.productos.total;
                    this.perPage = response.data.per_page;
                    let self = this;
                    this.total_registros = response.data.productos.total;
                    setTimeout(function () {
                        self.metodosProductos();
                        self.loading = false;
                    }, 300);
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
        searchProductos() {
            this.loading = true;
            clearInterval(this.setTimeOutSearch);
            let self = this;
            this.setTimeOutSearch = setTimeout(function () {
                self.getProductos();
            }, 600);
        },
        getCategorias() {
            axios.get(main_url + "/portal/getCategorias").then((response) => {
                this.listCategorias = response.data.categorias;
            });
        },
        showModalProducto(id) {
            this.id_seleccionado = id;
            this.muestra_modal_producto = true;
        },

        metodosProductos() {
            let self = this;
            /*-------------------------------
        Sort by active
    -----------------------------------*/
            if ($(".sort-by-product-area").length) {
                var $body = $("body"),
                    $cartWrap = $(".sort-by-product-area"),
                    $cartContent = $cartWrap.find(".sort-by-dropdown");
                $cartWrap.on("click", ".sort-by-product-wrap", function (e) {
                    e.preventDefault();
                    var $this = $(this);
                    if (!$this.parent().hasClass("show")) {
                        $this
                            .siblings(".sort-by-dropdown")
                            .addClass("show")
                            .parent()
                            .addClass("show");
                    } else {
                        $this
                            .siblings(".sort-by-dropdown")
                            .removeClass("show")
                            .parent()
                            .removeClass("show");
                    }
                });
                /*Close When Click Outside*/
                $body.on("click", function (e) {
                    var $target = e.target;
                    if (
                        !$($target).is(".sort-by-product-area") &&
                        !$($target).parents().is(".sort-by-product-area") &&
                        $cartWrap.hasClass("show")
                    ) {
                        $cartWrap.removeClass("show");
                        $cartContent.removeClass("show");
                    }
                });
            }
        },
    },
};
</script>
<style></style>
