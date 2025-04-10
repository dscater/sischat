<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Configuración</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-3">
                                        <button
                                            v-if="
                                                permisos.includes(
                                                    'configuracion.edit'
                                                )
                                            "
                                            class="btn btn-primary btn-flat btn-block"
                                            @click="muestra_modal = true"
                                        >
                                            <i class="el-icon-edit-outline"></i>
                                            Actualizar información
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="col-md-12">
                                    <el-descriptions
                                        class="mt-3"
                                        title="Información"
                                        :column="1"
                                        border
                                        :labelStyle="{
                                            background: 'rgb(0, 123, 255)',
                                            width: '180px',
                                            color: 'white',
                                        }"
                                    >
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i class="el-icon-document"></i>
                                                Nombre del sistema
                                            </template>
                                            {{ oConfiguracion.nombre_sistema }}
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i class="el-icon-document"></i>
                                                Alias
                                            </template>
                                            {{ oConfiguracion.alias }}
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i class="el-icon-document"></i>
                                                Razón Social
                                            </template>
                                            {{ oConfiguracion.razon_social }}
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i class="el-icon-document"></i>
                                                NIT
                                            </template>
                                            {{ oConfiguracion.nit }}
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i
                                                    class="el-icon-map-location"
                                                ></i>
                                                Dirección
                                            </template>
                                            {{ oConfiguracion.dir }}
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i class="el-icon-phone"></i>
                                                Teléfono
                                            </template>
                                            {{ oConfiguracion.fono }}
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i class="el-icon-link"></i>
                                                Web
                                            </template>
                                            {{ oConfiguracion.web }}
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i class="el-icon-document"></i>
                                                Actividad Económica
                                            </template>
                                            {{ oConfiguracion.actividad }}
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i class="el-icon-message"></i>
                                                Correo
                                            </template>
                                            {{ oConfiguracion.correo }}
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i
                                                    class="el-icon-picture-outline-round"
                                                ></i>
                                                Logo
                                            </template>
                                            <el-avatar
                                                shape="square"
                                                :size="120"
                                                :fit="'fill'"
                                                :src="oConfiguracion.path_image"
                                            ></el-avatar>
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i
                                                    class="el-icon-document"
                                                ></i>
                                                Servicios
                                            </template>
                                            <p>
                                                {{ oConfiguracion.servicios }}
                                            </p>
                                            <el-avatar
                                                shape="square"
                                                :size="120"
                                                :fit="'cover'"
                                                :src="
                                                    oConfiguracion.url_servicios_img
                                                "
                                            ></el-avatar>
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i
                                                    class="el-icon-document"
                                                ></i>
                                                Misión
                                            </template>
                                            <p>
                                                {{ oConfiguracion.mision }}
                                            </p>
                                            <el-avatar
                                                shape="square"
                                                :size="120"
                                                :fit="'cover'"
                                                :src="
                                                    oConfiguracion.url_mision_img
                                                "
                                            ></el-avatar>
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i
                                                    class="el-icon-document"
                                                ></i>
                                                Visión
                                            </template>
                                            <p>
                                                {{ oConfiguracion.vision }}
                                            </p>
                                            <el-avatar
                                                shape="square"
                                                :size="120"
                                                :fit="'cover'"
                                                :src="
                                                    oConfiguracion.url_vision_img
                                                "
                                            ></el-avatar>
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i
                                                    class="el-icon-document"
                                                ></i>
                                                Nosotros
                                            </template>
                                            <p>
                                                {{ oConfiguracion.nosotros }}
                                            </p>
                                            <el-avatar
                                                shape="square"
                                                :size="120"
                                                :fit="'cover'"
                                                :src="
                                                    oConfiguracion.url_nosotros_img
                                                "
                                            ></el-avatar>
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i
                                                    class="el-icon-document"
                                                ></i>
                                                Facebook
                                            </template>
                                            <p>
                                                {{ oConfiguracion.facebook }}
                                            </p>
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i
                                                    class="el-icon-document"
                                                ></i>
                                                Instagram
                                            </template>
                                            <p>
                                                {{ oConfiguracion.instagram }}
                                            </p>
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i
                                                    class="el-icon-document"
                                                ></i>
                                                Twitter
                                            </template>
                                            <p>
                                                {{ oConfiguracion.twitter }}
                                            </p>
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i
                                                    class="el-icon-document"
                                                ></i>
                                                Youtube
                                            </template>
                                            <p>
                                                {{ oConfiguracion.youtube }}
                                            </p>
                                        </el-descriptions-item>
                                        <el-descriptions-item>
                                            <template slot="label">
                                                <i
                                                    class="el-icon-document"
                                                ></i>
                                                Ubicación
                                            </template>
                                            <div
                                                class="w-100"
                                                v-html="
                                                    oConfiguracion.ubicacion
                                                "
                                            ></div>
                                        </el-descriptions-item>
                                    </el-descriptions>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div
            class="modal fade"
            :class="{ show: muestra_modal }"
            id="modal-default"
            aria-modal="true"
            role="dialog"
            @click.self="cierraModal"
        >
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <h4 class="modal-title" v-text="tituloModal"></h4>
                        <button
                            type="button"
                            class="close"
                            data-dismiss="modal"
                            aria-label="Close"
                            @click="cierraModal"
                        >
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger':
                                                errors.nombre_sistema,
                                        }"
                                        >Nombre del Sistema*</label
                                    >
                                    <input
                                        type="text"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.nombre_sistema,
                                        }"
                                        placeholder="Nombre del sistema"
                                        v-model="oConfiguracion.nombre_sistema"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.nombre_sistema"
                                        v-text="errors.nombre_sistema[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{ 'text-danger': errors.alias }"
                                        >Alias*</label
                                    >
                                    <input
                                        type="text"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.alias,
                                        }"
                                        placeholder="Alias"
                                        v-model="oConfiguracion.alias"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.alias"
                                        v-text="errors.alias[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.razon_social,
                                        }"
                                        >Razón Social*</label
                                    >
                                    <input
                                        type="text"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.razon_social,
                                        }"
                                        placeholder="Razon Social"
                                        v-model="oConfiguracion.razon_social"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.razon_social"
                                        v-text="errors.razon_social[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.nit,
                                        }"
                                        >NIT*</label
                                    >
                                    <input
                                        type="text"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.nit,
                                        }"
                                        placeholder="Razon Social"
                                        v-model="oConfiguracion.nit"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.nit"
                                        v-text="errors.nit[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.ciudad,
                                        }"
                                        >Ciudad*</label
                                    >
                                    <input
                                        type="email"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.ciudad,
                                        }"
                                        placeholder="Ciudad"
                                        v-model="oConfiguracion.ciudad"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.ciudad"
                                        v-text="errors.ciudad[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.dir,
                                        }"
                                        >Dirección*</label
                                    >
                                    <input
                                        type="text"
                                        class="form-control"
                                        :class="{ 'is-invalid': errors.dir }"
                                        placeholder="Dirección"
                                        v-model="oConfiguracion.dir"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.dir"
                                        v-text="errors.dir[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{ 'text-danger': errors.fono }"
                                        >Teléfono*</label
                                    >
                                    <input
                                        type="text"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.fono,
                                        }"
                                        placeholder="Teléfono"
                                        v-model="oConfiguracion.fono"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.fono"
                                        v-text="errors.fono[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{ 'text-danger': errors.web }"
                                        >Web</label
                                    >
                                    <input
                                        type="text"
                                        class="form-control"
                                        :class="{ 'is-invalid': errors.web }"
                                        placeholder="Web"
                                        v-model="oConfiguracion.web"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.web"
                                        v-text="errors.web[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.actividad,
                                        }"
                                        >Actividad*</label
                                    >
                                    <input
                                        type="text"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.actividad,
                                        }"
                                        placeholder="Actividad"
                                        v-model="oConfiguracion.actividad"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.actividad"
                                        v-text="errors.actividad[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.correo,
                                        }"
                                        >Correo</label
                                    >
                                    <input
                                        type="text"
                                        class="form-control"
                                        :class="{ 'is-invalid': errors.correo }"
                                        placeholder="Correo"
                                        v-model="oConfiguracion.correo"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.correo"
                                        v-text="errors.correo[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{ 'text-danger': errors.logo }"
                                        >Logo</label
                                    >
                                    <input
                                        type="file"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.logo,
                                        }"
                                        ref="input_file"
                                        @change="getFile"
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.logo"
                                        v-text="errors.logo[0]"
                                    ></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.servicios,
                                        }"
                                        >Servicios</label
                                    >
                                    <el-input
                                        type="textarea"
                                        placeholder="Servicios"
                                        :class="{
                                            'is-invalid': errors.servicios,
                                        }"
                                        autosize
                                        v-model="oConfiguracion.servicios"
                                        clearable
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.servicios"
                                        v-text="errors.servicios[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.servicios_img,
                                        }"
                                        >Imagen Servicios</label
                                    >
                                    <input
                                        type="file"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.servicios_img,
                                        }"
                                        ref="file_servicios"
                                        @change="
                                            cargarFile($event, 'servicios_img')
                                        "
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.servicios_img"
                                        v-text="errors.servicios_img[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.mision,
                                        }"
                                        >Misión</label
                                    >
                                    <el-input
                                        type="textarea"
                                        placeholder="Misión"
                                        :class="{
                                            'is-invalid': errors.mision,
                                        }"
                                        autosize
                                        v-model="oConfiguracion.mision"
                                        clearable
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.mision"
                                        v-text="errors.mision[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.mision_img,
                                        }"
                                        >Imagen Misión</label
                                    >
                                    <input
                                        type="file"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.mision_img,
                                        }"
                                        ref="file_mision"
                                        @change="
                                            cargarFile($event, 'mision_img')
                                        "
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.mision_img"
                                        v-text="errors.mision_img[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.vision,
                                        }"
                                        >Visión</label
                                    >
                                    <el-input
                                        type="textarea"
                                        placeholder="Visión"
                                        :class="{
                                            'is-invalid': errors.vision,
                                        }"
                                        autosize
                                        v-model="oConfiguracion.vision"
                                        clearable
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.vision"
                                        v-text="errors.vision[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.vision_img,
                                        }"
                                        >Imagen Visión</label
                                    >
                                    <input
                                        type="file"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.vision_img,
                                        }"
                                        ref="file_vision"
                                        @change="
                                            cargarFile($event, 'vision_img')
                                        "
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.vision_img"
                                        v-text="errors.vision_img[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.nosotros,
                                        }"
                                        >Nosotros</label
                                    >
                                    <el-input
                                        type="textarea"
                                        placeholder="Nosotros"
                                        :class="{
                                            'is-invalid': errors.nosotros,
                                        }"
                                        autosize
                                        v-model="oConfiguracion.nosotros"
                                        clearable
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.nosotros"
                                        v-text="errors.nosotros[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.nosotros_img,
                                        }"
                                        >Imagen Nosotros</label
                                    >
                                    <input
                                        type="file"
                                        class="form-control"
                                        :class="{
                                            'is-invalid': errors.nosotros_img,
                                        }"
                                        ref="file_nosotros"
                                        @change="
                                            cargarFile($event, 'nosotros_img')
                                        "
                                    />
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.nosotros_img"
                                        v-text="errors.nosotros_img[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.facebook,
                                        }"
                                        >Facebook</label
                                    >
                                    <el-input
                                        type="textarea"
                                        placeholder="Facebook"
                                        :class="{
                                            'is-invalid': errors.facebook,
                                        }"
                                        autosize
                                        v-model="oConfiguracion.facebook"
                                        clearable
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.facebook"
                                        v-text="errors.facebook[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.instagram,
                                        }"
                                        >Instagram</label
                                    >
                                    <el-input
                                        type="textarea"
                                        placeholder="Instagram"
                                        :class="{
                                            'is-invalid': errors.instagram,
                                        }"
                                        autosize
                                        v-model="oConfiguracion.instagram"
                                        clearable
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.instagram"
                                        v-text="errors.instagram[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.twitter,
                                        }"
                                        >Twitter</label
                                    >
                                    <el-input
                                        type="textarea"
                                        placeholder="Twitter"
                                        :class="{
                                            'is-invalid': errors.twitter,
                                        }"
                                        autosize
                                        v-model="oConfiguracion.twitter"
                                        clearable
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.twitter"
                                        v-text="errors.twitter[0]"
                                    ></span>
                                </div>
                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.youtube,
                                        }"
                                        >Youtube</label
                                    >
                                    <el-input
                                        type="textarea"
                                        placeholder="Youtube"
                                        :class="{
                                            'is-invalid': errors.youtube,
                                        }"
                                        autosize
                                        v-model="oConfiguracion.youtube"
                                        clearable
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.youtube"
                                        v-text="errors.youtube[0]"
                                    ></span>
                                </div>

                                <div class="form-group col-md-6">
                                    <label
                                        :class="{
                                            'text-danger': errors.ubicacion,
                                        }"
                                        >Ubicación (Iframe)</label
                                    >
                                    <el-input
                                        type="textarea"
                                        placeholder="Ubicación (Iframe)"
                                        :class="{
                                            'is-invalid': errors.ubicacion,
                                        }"
                                        autosize
                                        v-model="oConfiguracion.ubicacion"
                                        clearable
                                    >
                                    </el-input>
                                    <span
                                        class="error invalid-feedback"
                                        v-if="errors.ubicacion"
                                        v-text="errors.ubicacion[0]"
                                    ></span>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button
                            type="button"
                            class="btn btn-default"
                            data-dismiss="modal"
                            @click="cierraModal"
                        >
                            Cerrar
                        </button>
                        <el-button
                            type="primary"
                            class="bg-primary"
                            :loading="enviando"
                            @click="setRegistroModal()"
                            >{{ textoBtn }}</el-button
                        >
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            muestra_modal: false,
            // config table
            loading: false,
            // Fin config table

            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            // config modal
            tituloModal: "ACTUALIZAR INFORMACIÓN",
            accion: "edit",
            textoBtn: "Actualizar",
            enviando: false,
            oConfiguracion: {
                id: 0,
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
            errors: [],
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getConfiguracion();
    },
    methods: {
        getFile(e) {
            this.oConfiguracion.logo = e.target.files[0];
        },
        cargarFile(e, index) {
            this.oConfiguracion[index] = e.target.files[0];
        },
        // Listar Usuarios
        getConfiguracion() {
            this.loading = true;
            let url = "/configuracion/getConfiguracion";
            axios.get(url).then((res) => {
                this.oConfiguracion = res.data.configuracion;
            });
        },
        // Dialog/modal
        cierraModal() {
            this.muestra_modal = false;
            this.getConfiguracion();
        },
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/configuracion/update";
                let formdata = new FormData();
                formdata.append(
                    "nombre_sistema",
                    this.oConfiguracion.nombre_sistema
                );
                formdata.append("alias", this.oConfiguracion.alias);
                formdata.append(
                    "razon_social",
                    this.oConfiguracion.razon_social
                );
                formdata.append("nit", this.oConfiguracion.nit);
                formdata.append("ciudad", this.oConfiguracion.ciudad);
                formdata.append("dir", this.oConfiguracion.dir);
                formdata.append("fono", this.oConfiguracion.fono);
                formdata.append(
                    "web",
                    this.oConfiguracion.web ? this.oConfiguracion.web : ""
                );
                formdata.append("actividad", this.oConfiguracion.actividad);
                formdata.append(
                    "correo",
                    this.oConfiguracion.correo ? this.oConfiguracion.correo : ""
                );
                formdata.append("logo", this.oConfiguracion.logo);

                formdata.append(
                    "servicios",
                    this.oConfiguracion.servicios
                        ? this.oConfiguracion.servicios
                        : ""
                );
                formdata.append(
                    "servicios_img",
                    this.oConfiguracion.servicios_img
                        ? this.oConfiguracion.servicios_img
                        : ""
                );
                formdata.append(
                    "mision",
                    this.oConfiguracion.mision ? this.oConfiguracion.mision : ""
                );
                formdata.append(
                    "mision_img",
                    this.oConfiguracion.mision_img
                        ? this.oConfiguracion.mision_img
                        : ""
                );
                formdata.append(
                    "vision",
                    this.oConfiguracion.vision ? this.oConfiguracion.vision : ""
                );
                formdata.append(
                    "vision_img",
                    this.oConfiguracion.vision_img
                        ? this.oConfiguracion.vision_img
                        : ""
                );
                formdata.append(
                    "nosotros",
                    this.oConfiguracion.nosotros
                        ? this.oConfiguracion.nosotros
                        : ""
                );
                formdata.append(
                    "nosotros_img",
                    this.oConfiguracion.nosotros_img
                        ? this.oConfiguracion.nosotros_img
                        : ""
                );
                formdata.append(
                    "facebook",
                    this.oConfiguracion.facebook
                        ? this.oConfiguracion.facebook
                        : ""
                );
                formdata.append(
                    "instagram",
                    this.oConfiguracion.instagram
                        ? this.oConfiguracion.instagram
                        : ""
                );
                formdata.append(
                    "twitter",
                    this.oConfiguracion.twitter
                        ? this.oConfiguracion.twitter
                        : ""
                );
                formdata.append(
                    "youtube",
                    this.oConfiguracion.youtube
                        ? this.oConfiguracion.youtube
                        : ""
                );
                formdata.append(
                    "ubicacion",
                    this.oConfiguracion.ubicacion
                        ? this.oConfiguracion.ubicacion
                        : ""
                );

                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };

                axios
                    .post(url, formdata, config)
                    .then((res) => {
                        this.getConfiguracion();
                        this.enviando = false;
                        this.muestra_modal = false;
                        // emitir evento
                        EventBus.$emit(
                            "configuracionActualizada",
                            JSON.stringify(res.data.configuracion)
                        );
                        Swal.fire({
                            icon: "success",
                            title: res.data.msj,
                            showConfirmButton: false,
                            timer: 1500,
                        });

                        this.limpiarConfiguracion();
                        this.errors = [];
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Actualizar";
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Actualizar";
                        }
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
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        limpiarConfiguracion() {
            this.accion = "create";
            this.textoBtn = "Actualizar";
            this.oConfiguracion.nombre_sistema = "";
            this.oConfiguracion.alias = "";
            this.oConfiguracion.razon_social = "";
            this.oConfiguracion.nit = "";
            this.oConfiguracion.ciudad = "";
            this.oConfiguracion.dir = "";
            this.oConfiguracion.fono = "";
            this.oConfiguracion.web = "";
            this.oConfiguracion.actividad = "";
            this.oConfiguracion.correo = "";
            this.oConfiguracion.logo = "";
            this.$refs.input_file.value = null;
            this.$refs.servicios_img.value = null;
            this.$refs.mision_img.value = null;
            this.$refs.vision_img.value = null;
            this.$refs.nosotros_img.value = null;
        },
    },
};
</script>

<style>
.el-descriptions-item__cell.el-descriptions-item__label.is-bordered-label {
    background: var(--primary) !important;
}
</style>
