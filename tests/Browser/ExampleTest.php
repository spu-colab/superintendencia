<?php

namespace Tests\Browser;

use Tests\DuskTestCase;
use Laravel\Dusk\Browser;
use Illuminate\Foundation\Testing\DatabaseMigrations;

class ExampleTest extends DuskTestCase
{
    /**
     * A basic browser test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $this->browse(function (Browser $browser) {

            /*                    
            $browser->visit('http://spunet.planejamento.gov.br')
                    ->waitForText('VOCÊ ESTÁ AQUI')
                    ->clickLink('SERVIÇOS')
                    ->pause(2000)
                    ->clickLink('Em Análise Técnica');
                    */
            $browser->visit('https://is.planejamento.gov.br/authenticationendpoint/login.do?commonAuthCallerPath=%2Fsamlsso&forceAuth=false&passiveAuth=false&tenantDomain=carbon.super&sessionDataKey=92797e65-453a-49d7-a20e-54e89bd72e44&relyingParty=spunet.planejamento.gov.br&type=samlsso&sp=SPU-INTEGRADOR-PROD&isSaaSApp=false&authenticators=BasicAuthenticator:LOCAL')
                    ->type('username', '***')
                    ->type('password', '***')
                    ->click('button.wr-btn.grey-bg.col-xs-12.col-md-12.col-lg-12.uppercase.font-extra-large')
                    ->waitForDialog(5)
                    ->acceptDialog()
                    ->waitFor('VOCÊ ESTÁ AQUI');
        });
    }
}
