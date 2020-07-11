<?php

namespace App\Providers;
use App\User;
use App\Permissao;
use Modules\Auth\Entities\DivisaoOrganograma;
use Modules\Demarcacao\Entities\Demarcacao;
use Modules\Correspondencia\Entities\CorrespDest;
use Modules\Correspondencia\Entities\ListaPostagem;
use App\Policies\UserPolicy;
use App\Policies\PermissaoPolicy;
use App\Policies\DivisaoOrganogramaPolicy;
use Modules\Demarcacao\Policies\DemarcacaoPolicy;
use Modules\Correspondencia\Policies\CorrespondenciaPolicy;

//use Illuminate\Support\Facades\Gate;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Modules\Geo\Entities\GeoCamada;
use Modules\Geo\Policies\GeoCamadaPolicy;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
        User::class => UserPolicy::class,
        Permissao::class => PermissaoPolicy::class,
        DivisaoOrganograma::class => DivisaoOrganogramaPolicy::class,
        CorrespDest::class => CorrespondenciaPolicy::class,
        ListaPostagem::class => CorrespondenciaPolicy::class,
        Demarcacao::class => DemarcacaoPolicy::class,
        GeoCamada::class => GeoCamadaPolicy::class
    ];


    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();
        //
    }
}
