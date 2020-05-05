<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Auth::routes(['register' => false]);
/*
Route::get('mail', function () {
    $user = App\User::find(1);
    return new App\Mail\RecuperarSenha($user, '52df03de6b5b35245738df98f63ebfe048c499f26229be6730cdebbff1a73447');
});
*/

Route::get('/', function () {
    return view('template');
});


Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');
