<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Catalogos - <span>Editar</span></h1>
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
                                <Formulario
                                    :catalogo="oCatalogo"
                                    :accion="'edit'"
                                    @envioFormulario="recargaFormulario"
                                ></Formulario>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>
<script>
import Formulario from "./Formulario.vue";
export default {
    components: {
        Formulario,
    },
    props: ["id"],
    data() {
        return {
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oCatalogo: {
                id: 0,
                nombre: "",
                catalogo_detalles: [],
            },
        };
    },
    mounted() {
        this.getCatalogo();
        this.loadingWindow.close();
    },
    methods: {
        recargaFormulario(id) {
            this.$router.push({
                name: "catalogos.index",
            });
            // location.reload();
        },
        getCatalogo() {
            axios.get("/admin/catalogos/" + this.id).then((response) => {
                this.oCatalogo = response.data.catalogo;
            });
        },
    },
};
</script>
<style></style>
