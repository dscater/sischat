<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Campañas - <span>Editar</span></h1>
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
                                    :campania="oCampania"
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
            oCampania: {
                id: 0,
                nombre: "",
                campania_detalles: [],
            },
        };
    },
    mounted() {
        this.getCampania();
        this.loadingWindow.close();
    },
    methods: {
        recargaFormulario(id) {
            this.$router.push({
                name: "campanias.index",
            });
            // location.reload();
        },
        getCampania() {
            axios.get("/admin/campanias/" + this.id).then((response) => {
                this.oCampania = response.data.campania;
            });
        },
    },
};
</script>
<style></style>
