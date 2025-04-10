import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

export default new Router({
    routes: [
        /* ************************* *
         *       PORTAL
         * ************************* */
        // INICIO
        {
            path: "/",
            name: "portal.inicio",
            component: require("./portal/Inicio.vue").default,
        },
        // NOSOTROS
        {
            path: "/nosotros",
            name: "portal.nosotros",
            component: require("./portal/Nosotros.vue").default,
        },
        // PRODUCTOS
        {
            path: "/productos",
            name: "portal.productos",
            component: require("./portal/Productos.vue").default,
        },

        // CARRITO
        {
            path: "/carrito",
            name: "portal.carrito",
            component: require("./portal/Carrito.vue").default,
        },
        // GUIA
        {
            path: "/guia",
            name: "portal.guia",
            component: require("./portal/Guia.vue").default,
        },
        // CONTACTOS
        {
            path: "/contactos",
            name: "portal.contactos",
            component: require("./portal/Contactos.vue").default,
        },

        /* ************************* *
         *     ADMINISTRACIÓN
         * ************************* */
        // INICIO
        {
            path: "/administracion",
            name: "inicio",
            component: require("./components/Inicio.vue").default,
        },

        // LOGIN
        {
            path: "/administracion/login",
            name: "login",
            component: require("./Auth.vue").default,
        },

        // Usuarios
        {
            path: "/administracion/usuarios/perfil/:id",
            name: "usuarios.perfil",
            component: require("./components/modulos/usuarios/perfil.vue")
                .default,
            props: true,
        },
        {
            path: "/administracion/usuarios",
            name: "usuarios.index",
            component: require("./components/modulos/usuarios/index.vue")
                .default,
        },

        // proveedores
        {
            path: "/administracion/proveedors",
            name: "proveedors.index",
            component: require("./components/modulos/proveedors/index.vue")
                .default,
        },

        // productos
        {
            path: "/administracion/productos",
            name: "productos.index",
            component: require("./components/modulos/productos/index.vue")
                .default,
        },

        // configuracion_pagos
        {
            path: "/administracion/configuracion_pagos",
            name: "configuracion_pagos.index",
            component:
                require("./components/modulos/configuracion_pagos/index.vue")
                    .default,
        },

        // orden_pedidos
        {
            path: "/administracion/orden_pedidos",
            name: "orden_pedidos.index",
            component: require("./components/modulos/orden_pedidos/index.vue")
                .default,
        },
        {
            path: "/administracion/orden_pedidos/show/:id",
            name: "orden_pedidos.show",
            component: require("./components/modulos/orden_pedidos/show.vue")
                .default,
            props: true,
        },

        // categorias
        {
            path: "/administracion/categorias",
            name: "categorias.index",
            component: require("./components/modulos/categorias/index.vue")
                .default,
        },

        // cupons
        {
            path: "/administracion/cupons",
            name: "cupons.index",
            component: require("./components/modulos/cupons/index.vue").default,
        },

        // tipo ingresos
        {
            path: "/administracion/tipo_ingresos",
            name: "tipo_ingresos.index",
            component: require("./components/modulos/tipo_ingresos/index.vue")
                .default,
        },

        // ingreso productos
        {
            path: "/administracion/ingreso_productos",
            name: "ingreso_productos.index",
            component:
                require("./components/modulos/ingreso_productos/index.vue")
                    .default,
        },

        // tipo salidas
        {
            path: "/administracion/tipo_salidas",
            name: "tipo_salidas.index",
            component: require("./components/modulos/tipo_salidas/index.vue")
                .default,
        },

        // salida productos
        {
            path: "/administracion/salida_productos",
            name: "salida_productos.index",
            component:
                require("./components/modulos/salida_productos/index.vue")
                    .default,
        },

        // Clientes
        {
            path: "/administracion/clientes",
            name: "clientes.index",
            component: require("./components/modulos/clientes/index.vue")
                .default,
        },

        // Ventas
        {
            path: "/administracion/ventas",
            name: "ventas.index",
            component: require("./components/modulos/ventas/index.vue").default,
        },

        {
            path: "/administracion/ventas/create",
            name: "ventas.create",
            component: require("./components/modulos/ventas/create.vue")
                .default,
        },

        {
            path: "/administracion/ventas/:id",
            name: "ventas.edit",
            props: true,
            component: require("./components/modulos/ventas/edit.vue").default,
        },

        {
            path: "/administracion/ventas/ticket_orden/:id",
            name: "ventas.ticket",
            props: true,
            component: require("./components/modulos/ventas/Ticket.vue")
                .default,
        },

        // Configuración
        {
            path: "/administracion/configuracion",
            name: "configuracion",
            component: require("./components/modulos/configuracion/index.vue")
                .default,
            props: true,
        },

        // Otra Configuración
        {
            path: "/administracion/otra_configuracion",
            name: "otra_configuracion",
            component:
                require("./components/modulos/otra_configuracion/index.vue")
                    .default,
            props: true,
        },

        // catalogos
        {
            path: "/administracion/catalogos",
            name: "catalogos.index",
            component: require("./components/modulos/catalogos/index.vue")
                .default,
        },
        {
            path: "/administracion/catalogos/create",
            name: "catalogos.create",
            component: require("./components/modulos/catalogos/create.vue")
                .default,
        },
        {
            path: "/administracion/catalogos/edit/:id",
            name: "catalogos.edit",
            component: require("./components/modulos/catalogos/edit.vue")
                .default,
            props: true,
        },

        // campanias
        {
            path: "/administracion/campanias",
            name: "campanias.index",
            component: require("./components/modulos/campanias/index.vue")
                .default,
        },
        {
            path: "/administracion/campanias/create",
            name: "campanias.create",
            component: require("./components/modulos/campanias/create.vue")
                .default,
        },
        {
            path: "/administracion/campanias/edit/:id",
            name: "campanias.edit",
            component: require("./components/modulos/campanias/edit.vue")
                .default,
            props: true,
        },

        // campania_automaticas
        {
            path: "/administracion/campania_automaticas",
            name: "campania_automaticas.index",
            component:
                require("./components/modulos/campania_automaticas/index.vue")
                    .default,
        },

        // Analisis inventarios
        {
            path: "/administracion/analisis_inventarios",
            name: "analisis_inventarios.index",
            component:
                require("./components/modulos/analisis_inventarios/index.vue")
                    .default,
        },

        // Analisis proveedors
        {
            path: "/administracion/analisis_proveedors",
            name: "analisis_proveedors.index",
            component:
                require("./components/modulos/analisis_proveedors/index.vue")
                    .default,
        },

        // Analisis ventas
        {
            path: "/administracion/analisis_ventas",
            name: "analisis_ventas.index",
            component: require("./components/modulos/analisis_ventas/index.vue")
                .default,
        },

        // Analisis clientes
        {
            path: "/administracion/analisis_clientes",
            name: "analisis_clientes.index",
            component:
                require("./components/modulos/analisis_clientes/index.vue")
                    .default,
        },

        // Reportes
        {
            path: "/administracion/reportes/usuarios",
            name: "reportes.usuarios",
            component: require("./components/modulos/reportes/usuarios.vue")
                .default,
            props: true,
        },
        {
            path: "/administracion/reportes/kardex",
            name: "reportes.kardex",
            component: require("./components/modulos/reportes/kardex.vue")
                .default,
            props: true,
        },
        {
            path: "/administracion/reportes/ventas",
            name: "reportes.ventas",
            component: require("./components/modulos/reportes/ventas.vue")
                .default,
            props: true,
        },
        {
            path: "/administracion/reportes/stock_productos",
            name: "reportes.stock_productos",
            component:
                require("./components/modulos/reportes/stock_productos.vue")
                    .default,
            props: true,
        },
        {
            path: "/administracion/reportes/historial_acciones",
            name: "reportes.historial_acciones",
            component:
                require("./components/modulos/reportes/historial_acciones.vue")
                    .default,
            props: true,
        },
        {
            path: "/administracion/reportes/grafico_ingresos",
            name: "reportes.grafico_ingresos",
            component:
                require("./components/modulos/reportes/grafico_ingresos.vue")
                    .default,
            props: true,
        },
        {
            path: "/administracion/reportes/grafico_orden",
            name: "reportes.grafico_orden",
            component:
                require("./components/modulos/reportes/grafico_orden.vue")
                    .default,
            props: true,
        },
        {
            path: "/administracion/reportes/ventas_fecha",
            name: "reportes.ventas_fecha",
            component: require("./components/modulos/reportes/ventas_fecha.vue")
                .default,
            props: true,
        },
        {
            path: "/administracion/reportes/compras_fecha",
            name: "reportes.compras_fecha",
            component:
                require("./components/modulos/reportes/compras_fecha.vue")
                    .default,
            props: true,
        },
        {
            path: "/administracion/reportes/ventas_promedio",
            name: "reportes.ventas_promedio",
            component:
                require("./components/modulos/reportes/ventas_promedio.vue")
                    .default,
            props: true,
        },
        {
            path: "/administracion/reportes/envios_campania",
            name: "reportes.envios_campania",
            component:
                require("./components/modulos/reportes/envios_campania.vue")
                    .default,
            props: true,
        },

        // PÁGINA NO ENCONTRADA
        {
            path: "*",
            component: require("./components/modulos/errors/404.vue").default,
        },
    ],
    mode: "history",
    linkActiveClass: "active",
});
