@inject('configuracion', 'App\Models\Configuracion')
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>{{ $configuracion->first()->alias }}</title>
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">
    <link rel="stylesheet" href="{{ asset('css/portal.css') }}">
    <style>
    </style>
    <script>
        var mapa_id = "MAP_ID";
        var interval_notificacions = null;
        // 1fb896f332f7b53c
    </script>

    @php
        $api = App\Models\ApiMap::first();
        $configuracion = App\Models\Configuracion::first();
    @endphp
    <script>
        key_captcha_local = "{{ $configuracion->captcha_local }}";
        url_asset = "{{ asset('') }}";
    </script>
    @if ($api)
        <script>
            mapa_id = "{{ $api->map_id }}";
        </script>
        <script src="https://maps.googleapis.com/maps/api/js?key={{ $api->google_maps }}"></script>
    @else
        <script src="https://maps.googleapis.com/maps/api/js?key=INSERT_YOUR_API_KEY"></script>
    @endif
</head>

<body class="sidebar-mini layout-fixed control-sidebar-slide-open layout-navbar-fixed text-sm">
    <div id="app">
        <Portal ruta="{{ route('portal.inicio') }}" logo="{{ asset('imgs/' . $configuracion->first()->logo) }}"
            ruta_asset="{{ asset('') }}" configuracion="{{ $configuracion->first() }}">
        </Portal>
    </div>
    <script>
        var main_url = "{{ url('') }}";
        var app_base = "";
        // var app_base = "siscrm"; //habilitar esta linea si existe la carpeta public en el proyecto con el nombre del sistema
    </script>
    {{-- <script src="https://maps.googleapis.com/maps/api/js?key={{ config('app.google_map_api') }}"></script> --}}
    <script src="{{ asset('js/jquery.js') }}"></script>
    <script src="{{ asset('js/portal.js') }}"></script>
    <script src="{{ asset('js/app.js') }}"></script>
    {{-- <script src="{{ asset('js/portal_custom.js') }}"></script> --}}
    <script>
        /*---------------------
                            Select active
                        --------------------- */
        $('.select-active').select2();

        /*--- VSticker ----*/
        $('#news-flash').vTicker({
            speed: 500,
            pause: 3000,
            animation: 'fade',
            mousePause: false,
            showItems: 1
        });
    </script>
</body>

</html>
