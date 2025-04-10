<template>
    <div>
        <header class="header-area header-style-1 header-height-2">
            <div class="header-top header-top-ptb-1 d-none d-lg-block">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-xl-3 col-lg-4">
                            <div class="header-info">
                                <ul>
                                    <li>
                                        <i class="fi-rs-smartphone"></i>
                                        <a href="#">{{ configuracion.fono }}</a>
                                    </li>
                                    <li>
                                        <i class="fi-rs-marker"></i
                                        ><span>{{ configuracion.dir }}</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-xl-6 col-lg-4">
                            <!-- <div class="text-center">
                                <div id="news-flash" class="d-inline-block">
                                    <ul>
                                        <li>
                                            Get great devices up to 50% off
                                            <a href="shop-grid-right.html"
                                                >View details</a
                                            >
                                        </li>
                                        <li>
                                            Supper Value Deals - Save more with
                                            coupons
                                        </li>
                                        <li>
                                            Trendy 25silver jewelry, save up 35%
                                            off today
                                            <a href="shop-grid-right.html"
                                                >Shop now</a
                                            >
                                        </li>
                                    </ul>
                                </div>
                            </div> -->
                        </div>
                        <div class="col-xl-3 col-lg-4">
                            <div class="header-info header-info-right">
                                <ul>
                                    <li v-if="oUser && oUser.id">
                                        <i class="fi-rs-user"></i
                                        ><a href="/administracion">{{
                                            oUser.full_name
                                        }}</a>
                                    </li>
                                    <li v-else>
                                        <i class="fi-rs-user"></i
                                        ><a href="/administracion">Ingresar</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="header-middle header-middle-ptb-1 d-none d-lg-block">
                <div class="container">
                    <div class="header-wrap">
                        <div class="logo logo-width-1">
                            <a href="/"
                                ><img
                                    :src="configuracion.path_image"
                                    alt="logo"
                            /></a>
                        </div>
                        <div class="header-right">
                            <div class="search-style-2">
                                <h1 class="w-100 text-center">
                                    {{ configuracion.razon_social }}
                                </h1>
                            </div>
                            <div class="header-action-right">
                                <div class="header-action-2">
                                    <div class="header-action-icon-2">
                                        <a class="mini-cart-icon" href="#">
                                            <img
                                                alt="Evara"
                                                :src="
                                                    url_assets +
                                                    '/imgs/theme/icons/icon-cart.svg'
                                                "
                                            />
                                            <span class="pro-count blue">{{
                                                carrito.length
                                            }}</span>
                                        </a>
                                        <div
                                            class="cart-dropdown-wrap cart-dropdown-hm2"
                                        >
                                            <ul>
                                                <li
                                                    v-for="(
                                                        item, index
                                                    ) in carrito"
                                                >
                                                    <div
                                                        class="shopping-cart-img"
                                                    >
                                                        <span
                                                            ><img
                                                                alt="Producto"
                                                                :src="
                                                                    item
                                                                        .producto
                                                                        .url_imagen
                                                                "
                                                        /></span>
                                                    </div>
                                                    <div
                                                        class="shopping-cart-title"
                                                    >
                                                        <h4>
                                                            <span>{{
                                                                item.producto
                                                                    .nombre
                                                            }}</span>
                                                        </h4>
                                                        <h4>
                                                            <span
                                                                >{{
                                                                    item.cantidad
                                                                }}
                                                                × </span
                                                            >Bs.
                                                            {{ item.precio }}
                                                        </h4>
                                                    </div>
                                                    <div
                                                        class="shopping-cart-delete"
                                                    >
                                                        <a
                                                            href="#"
                                                            @click.prevent="
                                                                eliminarProducto(
                                                                    index
                                                                )
                                                            "
                                                            ><i
                                                                class="fi-rs-cross-small"
                                                            ></i
                                                        ></a>
                                                    </div>
                                                </li>
                                            </ul>
                                            <div
                                                class="shopping-cart-footer"
                                                v-if="carrito.length > 0"
                                            >
                                                <div
                                                    class="shopping-cart-total"
                                                >
                                                    <h4>
                                                        Total
                                                        <span
                                                            >Bs.
                                                            {{ total }}</span
                                                        >
                                                    </h4>
                                                </div>
                                                <div
                                                    class="shopping-cart-button"
                                                >
                                                    <router-link
                                                        :to="{
                                                            name: 'portal.carrito',
                                                        }"
                                                        class="outline"
                                                        >Ver
                                                        carrito</router-link
                                                    >
                                                </div>
                                            </div>
                                            <div
                                                class="shopping-cart-footer"
                                                v-else
                                            >
                                                <div
                                                    class="shopping-cart-total"
                                                >
                                                    <h4>
                                                        Aún no agregaste ningún
                                                        producto
                                                    </h4>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="header-bottom header-bottom-bg-color sticky-bar">
                <div class="container">
                    <div
                        class="header-wrap header-space-between position-relative"
                    >
                        <div class="logo logo-width-1 d-block d-lg-none">
                            <a href="/"
                                ><img
                                    :src="configuracion.path_image"
                                    alt="logo"
                            /></a>
                        </div>
                        <div class="header-nav d-none d-lg-flex">
                            <div class="main-categori-wrap d-none d-lg-block">
                                <div class="categori-button-active"></div>
                                <div class="categori-button-active">
                                    <a
                                        :href="configuracion.facebook"
                                        class="font-lg mx-2"
                                        target="_blank"
                                        ><i class="fab fa-facebook"></i
                                    ></a>
                                    <a
                                        :href="configuracion.instagram"
                                        class="font-lg mx-2"
                                        target="_blank"
                                        ><i class="fab fa-instagram"></i
                                    ></a>
                                    <a
                                        :href="configuracion.twitter"
                                        class="font-lg mx-2"
                                        target="_blank"
                                        ><i class="fab fa-twitter"></i
                                    ></a>
                                    <a
                                        :href="configuracion.youtube"
                                        class="font-lg mx-2"
                                        target="_blank"
                                        ><i class="fab fa-youtube"></i
                                    ></a>
                                </div>
                                <div
                                    class="categori-dropdown-wrap categori-dropdown-active-large"
                                >
                                    <ul>
                                        <li class="has-children">
                                            <a href="shop-grid-right.html"
                                                ><i class="evara-font-dress"></i
                                                >Women's Clothing</a
                                            >
                                            <div class="dropdown-menu">
                                                <ul class="mega-menu d-lg-flex">
                                                    <li
                                                        class="mega-menu-col col-lg-7"
                                                    >
                                                        <ul class="d-lg-flex">
                                                            <li
                                                                class="mega-menu-col col-lg-6"
                                                            >
                                                                <ul>
                                                                    <li>
                                                                        <span
                                                                            class="submenu-title"
                                                                            >Hot
                                                                            &
                                                                            Trending</span
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Dresses</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Blouses
                                                                            &
                                                                            Shirts</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Hoodies
                                                                            &
                                                                            Sweatshirts</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Women's
                                                                            Sets</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Suits
                                                                            &
                                                                            Blazers</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Bodysuits</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Tanks
                                                                            &
                                                                            Camis</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Coats
                                                                            &
                                                                            Jackets</a
                                                                        >
                                                                    </li>
                                                                </ul>
                                                            </li>
                                                            <li
                                                                class="mega-menu-col col-lg-6"
                                                            >
                                                                <ul>
                                                                    <li>
                                                                        <span
                                                                            class="submenu-title"
                                                                            >Bottoms</span
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Leggings</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Skirts</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Shorts</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Jeans</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Pants
                                                                            &
                                                                            Capris</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Bikini
                                                                            Sets</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Cover-Ups</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Swimwear</a
                                                                        >
                                                                    </li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    <li
                                                        class="mega-menu-col col-lg-5"
                                                    >
                                                        <div
                                                            class="header-banner2"
                                                        >
                                                            <img
                                                                src="assets/imgs/banner/menu-banner-2.jpg"
                                                                alt="menu_banner1"
                                                            />
                                                            <div
                                                                class="banne_info"
                                                            >
                                                                <h6>10% Off</h6>
                                                                <h4>
                                                                    New Arrival
                                                                </h4>
                                                                <a href="#"
                                                                    >Shop now</a
                                                                >
                                                            </div>
                                                        </div>
                                                        <div
                                                            class="header-banner2"
                                                        >
                                                            <img
                                                                src="assets/imgs/banner/menu-banner-3.jpg"
                                                                alt="menu_banner2"
                                                            />
                                                            <div
                                                                class="banne_info"
                                                            >
                                                                <h6>15% Off</h6>
                                                                <h4>
                                                                    Hot Deals
                                                                </h4>
                                                                <a href="#"
                                                                    >Shop now</a
                                                                >
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                        <li class="has-children">
                                            <a href="shop-grid-right.html"
                                                ><i
                                                    class="evara-font-tshirt"
                                                ></i
                                                >Men's Clothing</a
                                            >
                                            <div class="dropdown-menu">
                                                <ul class="mega-menu d-lg-flex">
                                                    <li
                                                        class="mega-menu-col col-lg-7"
                                                    >
                                                        <ul class="d-lg-flex">
                                                            <li
                                                                class="mega-menu-col col-lg-6"
                                                            >
                                                                <ul>
                                                                    <li>
                                                                        <span
                                                                            class="submenu-title"
                                                                            >Jackets
                                                                            &
                                                                            Coats</span
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Down
                                                                            Jackets</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Jackets</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Parkas</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Faux
                                                                            Leather
                                                                            Coats</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Trench</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Wool
                                                                            &
                                                                            Blends</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Vests
                                                                            &
                                                                            Waistcoats</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Leather
                                                                            Coats</a
                                                                        >
                                                                    </li>
                                                                </ul>
                                                            </li>
                                                            <li
                                                                class="mega-menu-col col-lg-6"
                                                            >
                                                                <ul>
                                                                    <li>
                                                                        <span
                                                                            class="submenu-title"
                                                                            >Suits
                                                                            &
                                                                            Blazers</span
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Blazers</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Suit
                                                                            Jackets</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Suit
                                                                            Pants</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Suits</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Vests</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Tailor-made
                                                                            Suits</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Cover-Ups</a
                                                                        >
                                                                    </li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    <li
                                                        class="mega-menu-col col-lg-5"
                                                    >
                                                        <div
                                                            class="header-banner2"
                                                        >
                                                            <img
                                                                src="assets/imgs/banner/menu-banner-4.jpg"
                                                                alt="menu_banner1"
                                                            />
                                                            <div
                                                                class="banne_info"
                                                            >
                                                                <h6>10% Off</h6>
                                                                <h4>
                                                                    New Arrival
                                                                </h4>
                                                                <a href="#"
                                                                    >Shop now</a
                                                                >
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                        <li class="has-children">
                                            <a href="shop-grid-right.html"
                                                ><i
                                                    class="evara-font-smartphone"
                                                ></i>
                                                Cellphones</a
                                            >
                                            <div class="dropdown-menu">
                                                <ul class="mega-menu d-lg-flex">
                                                    <li
                                                        class="mega-menu-col col-lg-7"
                                                    >
                                                        <ul class="d-lg-flex">
                                                            <li
                                                                class="mega-menu-col col-lg-6"
                                                            >
                                                                <ul>
                                                                    <li>
                                                                        <span
                                                                            class="submenu-title"
                                                                            >Hot
                                                                            &
                                                                            Trending</span
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Cellphones</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >iPhones</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Refurbished
                                                                            Phones</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Mobile
                                                                            Phone</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Mobile
                                                                            Phone
                                                                            Parts</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Phone
                                                                            Bags
                                                                            &
                                                                            Cases</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Communication
                                                                            Equipments</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Walkie
                                                                            Talkie</a
                                                                        >
                                                                    </li>
                                                                </ul>
                                                            </li>
                                                            <li
                                                                class="mega-menu-col col-lg-6"
                                                            >
                                                                <ul>
                                                                    <li>
                                                                        <span
                                                                            class="submenu-title"
                                                                            >Accessories</span
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Screen
                                                                            Protectors</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Wire
                                                                            Chargers</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Wireless
                                                                            Chargers</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Car
                                                                            Chargers</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Power
                                                                            Bank</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Armbands</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Dust
                                                                            Plug</a
                                                                        >
                                                                    </li>
                                                                    <li>
                                                                        <a
                                                                            class="dropdown-item nav-link nav_item"
                                                                            href="#"
                                                                            >Signal
                                                                            Boosters</a
                                                                        >
                                                                    </li>
                                                                </ul>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    <li
                                                        class="mega-menu-col col-lg-5"
                                                    >
                                                        <div
                                                            class="header-banner2"
                                                        >
                                                            <img
                                                                src="assets/imgs/banner/menu-banner-5.jpg"
                                                                alt="menu_banner1"
                                                            />
                                                            <div
                                                                class="banne_info"
                                                            >
                                                                <h6>10% Off</h6>
                                                                <h4>
                                                                    New Arrival
                                                                </h4>
                                                                <a href="#"
                                                                    >Shop now</a
                                                                >
                                                            </div>
                                                        </div>
                                                        <div
                                                            class="header-banner2"
                                                        >
                                                            <img
                                                                src="assets/imgs/banner/menu-banner-6.jpg"
                                                                alt="menu_banner2"
                                                            />
                                                            <div
                                                                class="banne_info"
                                                            >
                                                                <h6>15% Off</h6>
                                                                <h4>
                                                                    Hot Deals
                                                                </h4>
                                                                <a href="#"
                                                                    >Shop now</a
                                                                >
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                        <li>
                                            <a href="shop-grid-right.html"
                                                ><i
                                                    class="evara-font-desktop"
                                                ></i
                                                >Computer & Office</a
                                            >
                                        </li>
                                        <li>
                                            <a href="shop-grid-right.html"
                                                ><i class="evara-font-cpu"></i
                                                >Consumer Electronics</a
                                            >
                                        </li>
                                        <li>
                                            <a href="shop-grid-right.html"
                                                ><i
                                                    class="evara-font-diamond"
                                                ></i
                                                >Jewelry & Accessories</a
                                            >
                                        </li>
                                        <li>
                                            <a href="shop-grid-right.html"
                                                ><i class="evara-font-home"></i
                                                >Home & Garden</a
                                            >
                                        </li>
                                        <li>
                                            <a href="shop-grid-right.html"
                                                ><i
                                                    class="evara-font-high-heels"
                                                ></i
                                                >Shoes</a
                                            >
                                        </li>
                                        <li>
                                            <a href="shop-grid-right.html"
                                                ><i
                                                    class="evara-font-teddy-bear"
                                                ></i
                                                >Mother & Kids</a
                                            >
                                        </li>
                                        <li>
                                            <a href="shop-grid-right.html"
                                                ><i class="evara-font-kite"></i
                                                >Outdoor fun</a
                                            >
                                        </li>
                                        <li>
                                            <ul
                                                class="more_slide_open"
                                                style="display: none"
                                            >
                                                <li>
                                                    <a
                                                        href="shop-grid-right.html"
                                                        ><i
                                                            class="evara-font-desktop"
                                                        ></i
                                                        >Beauty, Health</a
                                                    >
                                                </li>
                                                <li>
                                                    <a
                                                        href="shop-grid-right.html"
                                                        ><i
                                                            class="evara-font-cpu"
                                                        ></i
                                                        >Bags and Shoes</a
                                                    >
                                                </li>
                                                <li>
                                                    <a
                                                        href="shop-grid-right.html"
                                                        ><i
                                                            class="evara-font-diamond"
                                                        ></i
                                                        >Consumer Electronics</a
                                                    >
                                                </li>
                                                <li>
                                                    <a
                                                        href="shop-grid-right.html"
                                                        ><i
                                                            class="evara-font-home"
                                                        ></i
                                                        >Automobiles &
                                                        Motorcycles</a
                                                    >
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                    <div class="more_categories">
                                        Show more...
                                    </div>
                                </div>
                            </div>
                            <div
                                class="main-menu main-menu-padding-1 main-menu-lh-2 d-none d-lg-block"
                            >
                                <nav>
                                    <ul>
                                        <li v-for="item in listMenu">
                                            <router-link
                                                :exact="
                                                    item.ruta == 'portal.inicio'
                                                "
                                                :to="{ name: item.ruta }"
                                                >{{ item.label }}</router-link
                                            >
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                        <!-- <div class="hotline d-none d-lg-block">
                            <p>
                                <i class="fi-rs-headset"></i
                                ><span>Hotline</span> 1900 - 888
                            </p>
                        </div> -->
                        <p class="mobile-promotion">
                            Happy <span class="text-brand">Mother's Day</span>.
                            Big Sale Up to 40%
                        </p>
                        <div class="header-action-right d-block d-lg-none">
                            <div class="header-action-2">
                                <div class="header-action-icon-2">
                                    <a href="shop-wishlist.html">
                                        <img
                                            alt="Evara"
                                            src="assets/imgs/theme/icons/icon-heart.svg"
                                        />
                                        <span class="pro-count white">4</span>
                                    </a>
                                </div>
                                <div class="header-action-icon-2">
                                    <a
                                        class="mini-cart-icon"
                                        href="shop-cart.html"
                                    >
                                        <img
                                            alt="Evara"
                                            src="assets/imgs/theme/icons/icon-cart.svg"
                                        />
                                        <span class="pro-count white">2</span>
                                    </a>
                                    <div
                                        class="cart-dropdown-wrap cart-dropdown-hm2"
                                    >
                                        <ul>
                                            <li>
                                                <div class="shopping-cart-img">
                                                    <a
                                                        href="shop-product-right.html"
                                                        ><img
                                                            alt="Evara"
                                                            src="assets/imgs/shop/thumbnail-3.jpg"
                                                    /></a>
                                                </div>
                                                <div
                                                    class="shopping-cart-title"
                                                >
                                                    <h4>
                                                        <a
                                                            href="shop-product-right.html"
                                                            >Plain Striola
                                                            Shirts</a
                                                        >
                                                    </h4>
                                                    <h3>
                                                        <span>1 × </span>$800.00
                                                    </h3>
                                                </div>
                                                <div
                                                    class="shopping-cart-delete"
                                                >
                                                    <a href="#"
                                                        ><i
                                                            class="fi-rs-cross-small"
                                                        ></i
                                                    ></a>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="shopping-cart-img">
                                                    <a
                                                        href="shop-product-right.html"
                                                        ><img
                                                            alt="Evara"
                                                            src="assets/imgs/shop/thumbnail-4.jpg"
                                                    /></a>
                                                </div>
                                                <div
                                                    class="shopping-cart-title"
                                                >
                                                    <h4>
                                                        <a
                                                            href="shop-product-right.html"
                                                            >Macbook Pro 2022</a
                                                        >
                                                    </h4>
                                                    <h3>
                                                        <span>1 × </span
                                                        >$3500.00
                                                    </h3>
                                                </div>
                                                <div
                                                    class="shopping-cart-delete"
                                                >
                                                    <a href="#"
                                                        ><i
                                                            class="fi-rs-cross-small"
                                                        ></i
                                                    ></a>
                                                </div>
                                            </li>
                                        </ul>
                                        <div class="shopping-cart-footer">
                                            <div class="shopping-cart-total">
                                                <h4>
                                                    Total <span>$383.00</span>
                                                </h4>
                                            </div>
                                            <div class="shopping-cart-button">
                                                <a href="shop-cart.html"
                                                    >View cart</a
                                                >
                                                <a href="shop-checkout.html"
                                                    >Checkout</a
                                                >
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div
                                    class="header-action-icon-2 d-block d-lg-none"
                                >
                                    <div class="burger-icon burger-icon-white">
                                        <span class="burger-icon-top"></span>
                                        <span class="burger-icon-mid"></span>
                                        <span class="burger-icon-bottom"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="mobile-header-active mobile-header-wrapper-style">
            <div class="mobile-header-wrapper-inner">
                <div class="mobile-header-top">
                    <div class="mobile-header-logo">
                        <a href="/"
                            ><img :src="configuracion.path_image" alt="logo"
                        /></a>
                    </div>
                    <div
                        class="mobile-menu-close close-style-wrap close-style-position-inherit"
                    >
                        <button class="close-style search-close">
                            <i class="icon-top"></i>
                            <i class="icon-bottom"></i>
                        </button>
                    </div>
                </div>
                <div class="mobile-header-content-area">
                    <div class="mobile-menu-wrap mobile-header-border">
                        <!-- mobile menu start -->
                        <nav>
                            <ul class="mobile-menu">
                                <li v-for="item in listMenu">
                                    <router-link :to="item.ruta">{{
                                        item.label
                                    }}</router-link>
                                </li>
                            </ul>
                        </nav>
                        <!-- mobile menu end -->
                    </div>
                    <div class="mobile-header-info-wrap mobile-header-border">
                        <div class="single-mobile-header-info mt-30">
                            <span>{{ configuracion.dir }} </span>
                        </div>
                        <div class="single-mobile-header-info">
                            <a
                                href="/administracion/inicio"
                                v-if="oUser && oUser.id"
                                ><i class="fi-rs-user"></i>
                                {{ oUser.full_name }}</a
                            >
                            <a href="/administracion" v-else>Ingresar </a>
                        </div>
                        <div class="single-mobile-header-info">
                            <a href="#">{{ configuracion.fono }} </a>
                        </div>
                    </div>
                    <div class="mobile-social-icon">
                        <h5 class="mb-15 text-grey-4">Siguenos</h5>
                        <a :href="configuracion.facebook" target="_blank"
                            ><img
                                :src="
                                    url_assets +
                                    '/imgs/theme/icons/icon-facebook.svg'
                                "
                                alt=""
                        /></a>
                        <a :href="configuracion.twitter" target="_blank"
                            ><img
                                :src="
                                    url_assets +
                                    '/imgs/theme/icons/icon-twitter.svg'
                                "
                                alt=""
                        /></a>
                        <a :href="configuracion.instagram" target="_blank"
                            ><img
                                :src="
                                    url_assets +
                                    '/imgs/theme/icons/icon-instagram.svg'
                                "
                                alt=""
                        /></a>
                        <a :href="configuracion.youtube" target="_blank"
                            ><img
                                :src="
                                    url_assets +
                                    '/imgs/theme/icons/icon-youtube.svg'
                                "
                                alt=""
                        /></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import { RouterLink } from "vue-router";

export default {
    props: {
        configuracion: {
            type: Object,
            default: {
                razon_social: "",
            },
        },
    },
    data() {
        return {
            fullscreenLoading: false,
            listMenu: [
                {
                    label: "Inicio",
                    ruta: "portal.inicio",
                },
                {
                    label: "Nosotros",
                    ruta: "portal.nosotros",
                },
                {
                    label: "Productos",
                    ruta: "portal.productos",
                },
                {
                    label: "Tú carrito",
                    ruta: "portal.carrito",
                },
                {
                    label: "Guía de Compra",
                    ruta: "portal.guia",
                },
                {
                    label: "Contactos",
                    ruta: "portal.contactos",
                },
            ],
            cantidad_carrito: 0,
            carrito: [],
            oUser: null,
            url_assets: url_asset,
            total: "0.00",
        };
    },
    mounted() {
        this.getAuth();
        this.animacionHeader();
        this.getCarrito();
        EventBus.$on("producto_agregado", () => {
            this.getCarrito();
        });
        let self = this;
    },
    methods: {
        getAuth() {
            axios.get(main_url + "/auth").then((response) => {
                this.oUser = response.data;
            });
        },
        getCarrito() {
            if (localStorage.getItem("carrito_siscrm")) {
                this.carrito = JSON.parse(
                    localStorage.getItem("carrito_siscrm")
                );
                this.cantidad_carrito = this.carrito.length;
            } else {
                this.carrito = [];
                this.cantidad_carrito = 0;
            }
            this.getTotal();
        },

        getTotal() {
            if (localStorage.getItem("carrito_siscrm")) {
                this.carrito = JSON.parse(
                    localStorage.getItem("carrito_siscrm")
                );
                let sum_total = this.carrito.reduce(function (
                    acumulador,
                    objeto
                ) {
                    return acumulador + parseFloat(objeto.precio_total);
                },
                0);
                this.total = parseFloat(sum_total).toFixed(2);
            } else {
                this.total = "0.00";
            }
        },
        eliminarProducto(index) {
            let nombre = this.carrito[index].producto.nombre;
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
                    this.carrito.splice(index, 1);
                    localStorage.setItem(
                        "carrito_siscrm",
                        JSON.stringify(this.carrito)
                    );
                    this.getCarrito();
                    EventBus.$emit("producto_agregado");
                }
            });
        },
        animacionHeader() {
            /*-----------------
                Menu Stick
            -----------------*/
            var header = $(".sticky-bar");
            var win = $(window);
            win.on("scroll", function () {
                var scroll = win.scrollTop();
                if (scroll < 200) {
                    header.removeClass("stick");
                    $(
                        ".header-style-2 .categori-dropdown-active-large"
                    ).removeClass("open");
                    $(".header-style-2 .categori-button-active").removeClass(
                        "open"
                    );
                } else {
                    header.addClass("stick");
                }
            });

            /*====== Sidebar menu Active ======*/
            function mobileHeaderActive() {
                var navbarTrigger = $(".burger-icon"),
                    endTrigger = $(".mobile-menu-close"),
                    container = $(".mobile-header-active"),
                    wrapper4 = $("body");

                wrapper4.prepend('<div class="body-overlay-1"></div>');

                navbarTrigger.on("click", function (e) {
                    e.preventDefault();
                    container.addClass("sidebar-visible");
                    wrapper4.addClass("mobile-menu-active");
                });

                endTrigger.on("click", function () {
                    container.removeClass("sidebar-visible");
                    wrapper4.removeClass("mobile-menu-active");
                });

                $(".body-overlay-1").on("click", function () {
                    container.removeClass("sidebar-visible");
                    wrapper4.removeClass("mobile-menu-active");
                });
            }
            mobileHeaderActive();
        },
    },
};
</script>
