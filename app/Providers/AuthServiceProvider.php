<?php

namespace App\Providers;
use App\User;
use App\Permissao;
use Modules\Auth\Entities\DivisaoOrganograma;
use Modules\Demarcacao\Entities\Demarcacao;

use App\Policies\UserPolicy;
use App\Policies\PermissaoPolicy;
use App\Policies\DivisaoOrganogramaPolicy;
use Modules\Demarcacao\Policies\DemarcacaoPolicy;

//use Illuminate\Support\Facades\Gate;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;

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
        Demarcacao::class => DemarcacaoPolicy::class
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
