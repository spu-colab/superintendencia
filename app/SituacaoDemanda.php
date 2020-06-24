<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SituacaoDemanda extends Model
{

    public const TABLE_NAME = "situacaodemanda";

    public const NOVA = 1;
    public const NOVA_DESC = "Nova";

    public const EM_ANALISE = 2;
    public const EM_ANALISE_DESC = "Em Análise";

    public const RESOLVIDA = 3;
    public const RESOLVIDA_DESC = "Resolvida";

    public const CANCELADA = 4;
    public const CANCELADA_DESC = "Cancelada";

    public const PRONTA = 5;
    public const PRONTA_DESC = "Pronta";

    public const AGUARDANDO_ASSINATURA = 6;
    public const AGUARDANDO_ASSINATURA_DESC = "Aguardando Assinatura";

    public const AGUARDANDO_AR = 7;
    public const AGUARDANDO_AR_DESC = "Aguardando AR";

    protected $table = SituacaoDemanda::TABLE_NAME;
}
