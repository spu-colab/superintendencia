<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;

class UsuarioController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        //
        $result = User::get();
        // ->paginate($per_page);
        return response()->json($result);
    }



    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
        $user = new User;
        if(@$request->usuario['name']) {
            $user->name = $request->usuario['name'];
        }
        if(@$request->usuario['cpf']) {
            $user->cpf = $request->usuario['cpf'];
        }
        if(@$request->usuario['email']) {
            $user->email = $request->usuario['email'];
        }
        if(@$request->usuario['telefone']) {
            $user->telefone = $request->usuario['telefone'];
        }
        if(@$request->usuario['password']) {
            $user->password = $request->usuario['password'];
        }
        $user = $user->save();
        return response()->json($user);

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
        $user = User::findOrFail($id);
        return response()->json($user);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        // recuperar o usuario do banco
        // fazer as atualizações de valores
        // $user->update();

        $user = User::findOrFail($id);
//        $this->authorize('update', $user);
        if(@$request->usuario['name']) {
            $user->name = $request->usuario['name'];
        }
        if(@$request->usuario['cpf']) {
            $user->cpf = $request->usuario['cpf'];
        }
        if(@$request->usuario['email']) {
            $user->email = $request->usuario['email'];
        }
        if(@$request->usuario['telefone']) {
            $user->telefone = $request->usuario['telefone'];
        }
        $user->update();
        return response()->json($user);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
    
}
