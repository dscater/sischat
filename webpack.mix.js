const mix = require("laravel-mix");

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */
mix.setPublicPath("./")
    .js("resources/js/app.js", "./js")
    .vue()
    .sass("resources/sass/app.scss", "./css")
    .styles(
        [
            "resources/assets/css/all.min.css",
            "resources/assets/css/icheck-bootstrap.css",
            "resources/assets/css/adminlte.css",
            "resources/assets/css/config.css",
        ],
        "./css/plantilla.css"
    )
    .styles(
        [
            "resources/assets/css/portal/normalize.css",
            "resources/assets/css/portal/bootstrap.min.css",
            "resources/assets/css/portal/evara-font.css",
            "resources/assets/css/portal/uicons-regular-straight.css",
            "resources/assets/css/portal/jquery-ui.css",
            "resources/assets/css/portal/magnific-popup.css",
            "resources/assets/css/portal/select2.min.css",
            "resources/assets/css/portal/slick.css",
            "resources/assets/css/portal/perfect-scrollbar.css",
            "resources/assets/css/portal/main.css",
            "resources/assets/css/all.min.css",
            "resources/assets/css/portal.css",
        ],
        "./css/portal.css"
    )
    .scripts(["resources/assets/js/jquery-3.6.0.min.js"], "./js/jquery.js")
    .scripts(
        ["resources/assets/js/adminlte.min.js", "resources/assets/js/demo.js"],
        "./js/plantilla.js"
    )
    .scripts(
        [
            "resources/assets/js/portal/modernizr-3.6.0.min.js",
            "resources/assets/js/portal/jquery-migrate-3.3.0.min.js",
            "resources/assets/js/portal/bootstrap.bundle.min.js",
            "resources/assets/js/portal/slick.js",
            "resources/assets/js/portal/jquery.syotimer.min.js",
            "resources/assets/js/portal/wow.js",
            "resources/assets/js/portal/jquery-ui.js",
            "resources/assets/js/portal/perfect-scrollbar.js",
            "resources/assets/js/portal/magnific-popup.js",
            "resources/assets/js/portal/select2.min.js",
            "resources/assets/js/portal/waypoints.js",
            "resources/assets/js/portal/counterup.js",
            "resources/assets/js/portal/jquery.countdown.min.js",
            "resources/assets/js/portal/images-loaded.js",
            "resources/assets/js/portal/isotope.js",
            "resources/assets/js/portal/select2.min.js",
            "resources/assets/js/portal/scrollup.js",
            "resources/assets/js/portal/jquery.vticker-min.js",
            "resources/assets/js/portal/jquery.theia.sticky.js",
            "resources/assets/js/portal/jquery.elevatezoom.js",
        ],
        "./js/portal.js"
    )
    .scripts(
        [
            "resources/assets/js/portal/main.js",
            "resources/assets/js/portal/shop.js",
        ],
        "./js/portal_custom.js"
    )
    .copy("resources/assets/imgs", "./imgs")
    .copy("resources/assets/images", "./images")
    .copy("resources/assets/webfonts", "./webfonts")
    .copy("resources/assets/webfont", "./webfont")
    .copy("resources/assets/fonts", "./fonts");

// mix.disableNotifications();
