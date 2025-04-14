<template>
    <div class="chat" :class="[abierto ? '' : 'hide']">
        <div class="header">
            <button class="open-chat" v-if="!abierto" @click="abrir">
                <i class="fa fa-comment"></i>
            </button>
            <button class="close-chat" @click="cerrar" v-if="abierto">
                <i class="fa fa-times"></i>
            </button>
        </div>
        <div class="content">
            <div class="title">
                {{ oConfiguracion.razon_social }}
            </div>
            <div class="mensajes" ref="contenedorMensajes">
                <ul>
                    <li class="mensaje sistema">
                        ¡Hola, este es nuestro asistente virtual!<br />Y cada
                        día te mantendremos al día con nuevas sugerencias.
                    </li>

                    <li class="mensaje sistema">
                        Si necesitas encontrar algun producto escribelo en el chat<br/>
                        O puedes usar los siguientes comandos:<br />
                        <strong>
                            /Populares<br />
                            /Sugerencia
                        </strong>
                    </li>
                    <li
                        v-for="item in listRegistros"
                        class="mensaje"
                        :class="[
                            item.tipo == 'sistema' ? 'sistema' : 'usuario',
                        ]"
                    >
                        <p v-html="item.mensaje"></p>
                    </li>
                </ul>
            </div>
        </div>
        <div class="foot">
            <div class="input-group">
                <input
                    type="text"
                    class="form-control"
                    v-model="texto"
                    @keydown.enter="enviarComando"
                />
                <button class="btn bg-blue input-append" @click="enviarComando">
                    <i class="fa fa-paper-plane"></i>
                </button>
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
import ModalProducto from "./ModalProducto.vue";
export default {
    components: {
        ModalProducto,
    },
    data() {
        return {
            abierto: true,
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
            oUser: null,
            listRegistros: [],
            id_seleccionado: 0,
            muestra_modal_producto: false,
            texto: "",
        };
    },
    mounted() {
        this.getConfiguracion();
        this.getAuth();
        console.log("Chat montado");
        this.getSugerencia();
    },
    methods: {
        abrir() {
            this.abierto = true;
        },
        cerrar() {
            this.abierto = false;
        },
        getConfiguracion() {
            axios
                .get(main_url + "/configuracion/getConfiguracion")
                .then((response) => {
                    this.oConfiguracion = response.data.configuracion;
                });
        },
        getAuth() {
            axios.get(main_url + "/auth").then((response) => {
                this.oUser = response.data;
            });
        },
        getSugerencia() {
            axios
                .get(main_url + "/admin/historial_clientes/getRegistros")
                .then((response) => {
                    this.listRegistros = response.data;
                    setTimeout(() => {
                        this.$nextTick(() => {
                            this.scrollAbajo();
                            this.initClickProducto();
                        });
                    }, 300);
                });
        },
        scrollAbajo() {
            this.$nextTick(() => {
                const contenedor = this.$refs["contenedorMensajes"];
                contenedor.scrollTop = contenedor.scrollHeight;
            });
        },
        initClickProducto() {
            const self = this; // guarda el contexto Vue
            $(document).on("click", ".prod_sugerencia", function (e) {
                e.preventDefault();
                const val = $(this).data("producto"); // más limpio que .attr()
                console.log("Producto seleccionado:", val);
                self.id_seleccionado = val;
                self.muestra_modal_producto = true;
            });
        },
        enviarComando() {
            console.log("asda");
            console.log(this.texto);
            if (this.texto.trim() != "") {
                axios
                    .get(main_url + "/admin/historial_clientes/getRegistros", {
                        params: {
                            comando: this.texto,
                        },
                    })
                    .then((response) => {
                        this.listRegistros = response.data;
                        this.texto = "";
                        setTimeout(() => {
                            this.$nextTick(() => {
                                this.scrollAbajo();
                                this.initClickProducto();
                            });
                        }, 300);
                    });
            }
        },
    },
};
</script>
<style>
.chat {
    position: fixed;
    bottom: 10px;
    right: 10px;
    width: 440px;
    max-width: 85%;
    height: 400px;
    max-height: 80%;
    background-color: white;
    border: solid 1px var(--secundario);
    z-index: 10;
}
.chat button.open-chat {
    position: absolute;
    bottom: 20px;
    right: 20px;
    border-radius: 20px;
    font-size: 2.7rem;
    color: white;
}
.chat.hide .content,
.chat.hide .foot {
    display: none;
}
.chat.hide {
    border: none;
    height: 0px;
}

.chat .foot input,
.chat .foot button {
    border-radius: 0;
}

.chat .title {
    padding: 10px;
}

.content {
    height: 348px;
    max-height: 100%;
}

.title {
    font-weight: bold;
    font-size: 1.1rem;
    height: 40px;
}

.mensajes {
    height: calc(100% - 40px);
    width: 100%;
    padding: 10px;
    overflow: auto;
    background-color: rgb(236, 246, 255);
    display: flex;
    flex-direction: column;
}

.mensajes .mensaje {
    background-color: white;
    padding: 10px;
    border-radius: 15px;
    margin-bottom: 7px;
    width: fit-content;
}

.mensajes .usuario {
    margin-left: auto;
}

.close-chat {
    float: right;
    background-color: transparent;
    border: none;
    color: white;
}

.chat button {
    background-color: var(--secundario);
}

.chat small{
    font-size: 0.8rem;
}
</style>
