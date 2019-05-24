<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SituacaoDemanda extends Model
{
    const NOVA = 1;
    const EM_ANALISE = 2;
    const RESOLVIDA = 3;
    const CANCELADA = 4;
    const PRONTA = 5;
    const AGUARDANDO_ASSINATURA = 6;
    const AGUARDANDO_AR = 7;

    protected $table = 'situacaodemanda';
}
