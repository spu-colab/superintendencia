<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

use \App\User;

class RecuperarSenha extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct(User $user, $token)
    {
        $this->user = $user;
        $this->token = $token;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $link = route('password.reset', ['token' => $this->token]) . '?email=' . $this->user->email;

        return $this->subject('SPU-SC - Recuperação de Senha')
                ->view('auth.recuperar-senha', [
                    'user' => $this->user,
                    'link' => $link
                ]);
    }
}
