<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Models\HistorialAccion;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class ClienteController extends Controller
{
    public $validacion = [
        'nombre' => 'required',
        'apellidos' => 'required',
        'ci' => 'required|max:12',
        'ci_exp' => 'required',
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "apellidos.required" => "Este campo es obligatorio",
        "ci.required" => "Este campo es obligatorio",
        "ci_exp.required" => "Este campo es obligatorio",
        "correo.required" => "Este campo es obligatorio",
        "correo.unique" => "Este correo ya se encuentra registrado",
        "correo.regex" => "Formato de correo no valido",
        "password.required" => "Este campo es obligatorio",
        "password.min" => "Debes ingresar como minimo :min caracteres",
        "ci.max" => "Debes ingresar como maximo :max caracteres",
        "nit.max" => "Debes ingresar como maximo :max caracteres",
    ];

    public function index(Request $request)
    {
        $clientes = Cliente::with(["user"])->get();
        return response()->JSON(['clientes' => $clientes, 'total' => count($clientes)], 200);
    }

    public function store(Request $request)
    {
        $this->validacion["correo"] = "required|unique:clientes,correo|regex:/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/";
        $this->validacion["password"] = "required|min:8";

        if (isset($request->nit) && $request->nit != '') {
            $this->validacion["nit"] = "max:12";
        }

        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Cliente
            $request["fecha_registro"] = date("Y-m-d");
            $request["tipo"] = "FISICO";
            $nuevo_cliente = Cliente::create(array_map('mb_strtoupper', $request->all()));
            $nuevo_cliente->correo = $request->correo;
            $nuevo_cliente->save();

            $user = User::create(array_map("mb_strtoupper", [
                "usuario" => $nuevo_cliente->correo,
                "nombre" => $nuevo_cliente->nombre,
                "paterno" => $nuevo_cliente->apellidos,
                "ci" => $nuevo_cliente->ci,
                "ci_exp" => $nuevo_cliente->ci_exp,
                "dir" => $nuevo_cliente->dir,
                "correo" => $nuevo_cliente->correo,
                "fono" => $nuevo_cliente->fono,
                "tipo" => "CLIENTE",
                "password" => Hash::make($request->password),
                "acceso" => $request->acceso,
                "fecha_registro" => date("Y-m-d")
            ]));

            $user->update([
                "usuario" => $nuevo_cliente->correo,
                "correo" => $nuevo_cliente->correo,
                "password" => Hash::make($request->password)
            ]);

            $nuevo_cliente->user_id = $user->id;
            $nuevo_cliente->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_cliente, "clientes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN CLIENTE',
                'datos_original' => $datos_original,
                'modulo' => 'CLIENTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'cliente' => $nuevo_cliente,
                'msj' => 'El registro se realizó de forma correcta',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, Cliente $cliente)
    {

        $this->validacion["correo"] = "required|regex:/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/|unique:clientes,correo," . $cliente->id;
        if (!$cliente->user) {
            $this->validacion["password"] = "required|min:8";
        }

        if (isset($request->password) && $request->password != '') {
            $this->validacion["password"] = "required|min:8";
        }

        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($cliente, "clientes");
            $cliente->update(array_map('mb_strtoupper', $request->all()));
            $cliente->correo = $request->correo;
            $cliente->save();
            if (!$cliente->user) {
                $user = User::create(array_map("mb_strtoupper", [
                    "usuario" => $cliente->correo,
                    "nombre" => $cliente->nombre,
                    "paterno" => $cliente->apellidos,
                    "ci" => $cliente->ci,
                    "ci_exp" => $cliente->ci_exp,
                    "dir" => $cliente->dir,
                    "correo" => $cliente->correo,
                    "fono" => $cliente->fono,
                    "password" => "12345678",
                    "tipo" => "CLIENTE",
                    "acceso" => $request->acceso,
                    "fecha_registro" => date("Y-m-d")
                ]));
                $user->update([
                    "usuario" => $cliente->correo,
                    "correo" => $cliente->correo,
                    "password" => Hash::make($request->password)
                ]);
            } else {
                $user = $cliente->user;
                $cliente->user()->update(array_map("mb_strtoupper", [
                    "usuario" => $cliente->correo,
                    "nombre" => $cliente->nombre,
                    "paterno" => $cliente->apellidos,
                    "ci" => $cliente->ci,
                    "ci_exp" => $cliente->ci_exp,
                    "dir" => $cliente->dir,
                    "correo" => $cliente->correo,
                    "fono" => $cliente->fono,
                    "acceso" => $request->acceso,
                    "tipo" => "CLIENTE",
                ]));;
                $cliente->user->update([
                    "usuario" => $cliente->correo,
                    "correo" => $cliente->correo,
                    "password" => Hash::make($request->password)
                ]);
                if (isset($request->password) && $request->password != '') {
                    $cliente->user()->update([
                        "password" => Hash::make($request->password),
                    ]);
                }
            }
            $cliente->user_id = $user->id;
            $cliente->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($cliente, "clientes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN CLIENTE',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'CLIENTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'cliente' => $cliente,
                'msj' => 'El registro se actualizó de forma correcta'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(Cliente $cliente)
    {
        return response()->JSON([
            'sw' => true,
            'cliente' => $cliente
        ], 200);
    }

    public function destroy(Cliente $cliente)
    {
        DB::beginTransaction();
        try {
            $user = $cliente->user;
            $cliente->delete();
            $user->delete();

            $datos_original = HistorialAccion::getDetalleRegistro($cliente, "clientes");
            $cliente->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN CLIENTE',
                'datos_original' => $datos_original,
                'modulo' => 'CLIENTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'msj' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
