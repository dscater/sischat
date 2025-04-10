@inject('configuracion', 'App\Models\Configuracion')
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>{{ $configuracion->first()->alias }}</title>
    <style>
        #app {
            background-color: none;
            background-image: url("/imgs/fondologin.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }
    </style>

    <link rel="stylesheet" href="{{ mix('css/app.css') }}">
    <link rel="stylesheet" href="{{ mix('css/plantilla.css') }}">
    <script>
        var main_url = "{{ url('') }}";
        var mapa_id = "MAP_ID";
        var interval_notificacions = null;
        // 1fb896f332f7b53c
    </script>
    @php
        $api = App\Models\ApiMap::first();
        $configuracion = App\Models\Configuracion::first();
    @endphp
    @if ($api)
        <script>
            mapa_id = "{{ $api->map_id }}";
            key_captcha_local = "{{ $configuracion->captcha_local }}";
        </script>
        <script src="https://maps.googleapis.com/maps/api/js?key={{ $api->google_maps }}"></script>
    @else
        <script src="https://maps.googleapis.com/maps/api/js?key=INSERT_YOUR_API_KEY"></script>
    @endif
</head>

<body class="sidebar-mini layout-fixed control-sidebar-slide-open layout-navbar-fixed text-sm">
    <div id="app">
        @if (Auth::check())
            @if (Auth::user()->tipo == 'CAJA')
                <App ruta="{{ route('base_path') }}" configuracion="{{ $configuracion->first() }}"
                    user="{{ Auth::user()->load('caja_usuario') }}"></App>
            @else
                <App ruta="{{ route('base_path') }}" configuracion="{{ $configuracion->first() }}"
                    user="{{ Auth::user() }}"></App>
            @endif
        @else
            <Auth ruta="{{ route('base_path') }}" logo="{{ asset('imgs/' . $configuracion->first()->logo) }}"
                empresa="{{ $configuracion->first()->razon_social }}" configuracion="{{ $configuracion->first() }}"
                url_registro="{{ route('registro') }}"
                url_olvide_mi_contrasenia="{{ route('olvide_mi_contrasenia') }}">
            </Auth>
        @endif
    </div>
    <script src="{{ asset('js/jquery.js') }}"></script>
    <script src="{{ mix('js/app.js') }}"></script>
    <script src="{{ mix('js/plantilla.js') }}"></script>
    <script>
        $(document).ready(function() {
            $(document).on("click", "aside nav ul li a", function() {
                if ($("body").hasClass("sidebar-open") && !$(this).parent().hasClass("menu")) {
                    $("body").addClass("sidebar-collapse");
                    $("body").addClass("sidebar-close");
                    $("body").removeClass("sidebar-open");
                }
            });
        });
    </script>
</body>

</html>
