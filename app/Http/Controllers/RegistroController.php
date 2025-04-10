<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class RegistroController extends Controller
{
    public function registro()
    {
        return view("registro");
    }

    public function store(Request $request)
    {
        $request->validate(
            [
                "captcha" => "required",
                'nombre' => 'required',
                'apellidos' => 'required',
                'ci' => 'required',
                'ci_exp' => 'required',
                'correo' => 'required|unique:clientes,correo',
                'password' => 'required|string|min:8|confirmed'
            ],
            [
                "captcha.required" => "Este campo es obligatorio",
                "nombre.required" => "Este campo es obligatorio",
                "apellidos.required" => "Este campo es obligatorio",
                "ci.required" => "Este campo es obligatorio",
                "ci_exp.required" => "Este campo es obligatorio",
                "correo.required" => "Este campo es obligatorio",
                "correo.unique" => "Este correo ya se encuentra registrado",
                "password.required" => "Este campo es obligatorio",
                "password.min" => "Debes ingresar como minimo 8 caracteres",
            ]
        );

        $aux_pass = $request->password;
        $request['fecha_registro'] = date('Y-m-d');
        $request['usuario'] = $request->correo;
        $request['acceso'] = 1;
        $request["tipo"] = "ECOMMERCE";
        DB::beginTransaction();
        try {

            // crear el cliente
            $nuevo_cliente = Cliente::create(array_map('mb_strtoupper', $request->all()));
            $nuevo_cliente->correo = $request->correo;
            $nuevo_cliente->save();

            $user = User::create(array_map("mb_strtoupper", [
                "usuario" => $nuevo_cliente->correo,
                "nombre" => $nuevo_cliente->nombre,
                "apellidos" => $nuevo_cliente->apellidos,
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

            Auth::login($user);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'user' => $user,
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
}
