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

// Auth::routes();
Auth::routes(['register' => false]);
/*
Route::post('/password/email', '\App\Http\Controllers\Auth\ForgotPasswordController@sendResetLinkEmail')
    ->name('password.email');

Route::get('/password/reset', '\App\Http\Controllers\Auth\ResetPasswordController@showResetForm')
    ->name('password.reset');

Route::get('/password/reset/{token}', '\App\Http\Controllers\Auth\ResetPasswordController@showResetForm')
    ->name('password.reset');

Route::post('/password/reset', '\App\Http\Controllers\Auth\ResetPasswordController@reset')
    ->name('password.update');

Route::login()
*/

Route::get('/', function () {
    return view('template');
});

