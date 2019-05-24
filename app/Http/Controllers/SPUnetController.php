<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

define("COOKIE_FILE", "cookie.txt");

class SPUnetController extends Controller
{

    public function login() {
        $this->cookies = [];
        $login = "";
        $senha = "";

       //*
        //POST que retorna samlrequest
        $url = 'http://spunet.planejamento.gov.br/integrador/api/';
        $parametros = [
        ];
        $resposta = $this->curl(0, $url, $parametros);
        $samlRequest = $this->getSAMLRequest($resposta);


        //* post que retorna o formulario que é submetido no onload...
        // obtem sessionDataKey
        $url = 'https://is.planejamento.gov.br/samlsso';
        $parametros = [
            'SAMLRequest'      => $samlRequest,
            'Upgrade-Insecure-Requests' =>	1
        ];
        $resposta = $this->curl(1, $url, $parametros);
        var_dump($resposta);
        exit();
        $sessionDataKey = $this->getSessionDataKey($resposta);


        $url = "https://is.planejamento.gov.br/authenticationendpoint/login.do?commonAuthCallerPath=/samlsso&forceAuth=false&passiveAuth=false&tenantDomain=carbon.super&sessionDataKey=$sessionDataKey&relyingParty=spunet.planejamento.gov.br&type=samlsso&sp=SPU-INTEGRADOR-PROD&isSaaSApp=false&authenticators=BasicAuthenticator:LOCAL";
        $resposta = $this->curl(0, $url, []);       
        $jSESSIONID = $this->cookies['JSESSIONID'];
        // return $jSESSIONID;

        //submete o formulario de login

        $url = 'https://is.planejamento.gov.br/samlsso';
        $parametros = [
            'sessionDataKey'    => $sessionDataKey,
            'password'          => $senha,
            'tocommonauth'      => true,
            'username'          => $login
        ];
        $opcoes = [
            CURLOPT_HTTPHEADER => [
                'Host' => 'is.planejamento.gov.br',
                'Accept' => ' text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
                'Referer' => ': https://is.planejamento.gov.br/authenticationendpoint/login.do?commonAuthCallerPath=%2Fsamlsso&forceAuth=false&passiveAuth=false&tenantDomain=carbon.super&sessionDataKey=3c48e86f-c0c4-4588-b97e-e5fb300a682a&relyingParty=spunet.planejamento.gov.br&type=samlsso&sp=SPU-INTEGRADOR-PROD&isSaaSApp=false&authenticators=BasicAuthenticator:LOCAL',
                'Content-Type' => 'application/x-www-form-urlencoded',
                // 'Content-Length' => ': 112',
                'Cookie' => ": JSESSIONID=$jSESSIONID",
                    // commonAuthId=8fa32353-e14e-4d6c-b2ed-8f20bdd8f357; samlssoTokenId=81e607f9-1688-4969-85bb-a1a14af7cefa',
                'Connection' => 'keep-alive',
                'Upgrade-Insecure-Requests' => 1
            ]
        ];
        $resposta = $this->curl(1, $url, $parametros, $opcoes);
        // var_dump($this->cookies);

        //*/
        var_dump($resposta);
    }

    function getSAMLRequest($resposta) {
        preg_match_all(
            '/<input type="hidden" name="SAMLRequest" value="(?<valor>.*)"\/>/',
            $resposta,
            $matches,
            PREG_PATTERN_ORDER
        );
        echo "samlRequest: ".$matches['valor'][0]."<br>";
        return $matches['valor'][0];
    }

    function getSessionDataKey($resposta) {
        preg_match_all(
            '/&sessionDataKey=(?<valor>([a-zA-Z0-9_-]*))/',
            $resposta,
            $matches,
            PREG_PATTERN_ORDER
        );
        echo "sessionDataKey: ".$matches['valor'][0]."<br>";
        return $matches['valor'][0];
    }

    /**
    * Send a POST requst using cURL
    * @param string $url to request
    * @param array $post values to send
    * @param array $options for cURL
    * @return string
    */
    function curl($isPost, $url, array $post = NULL, array $options = array())
    {
        $defaults = array(
            CURLOPT_POST => $isPost,
            CURLOPT_HEADER => 1,
            CURLOPT_URL => $url,
            CURLOPT_FRESH_CONNECT => 1,
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_FORBID_REUSE => 1,
            CURLOPT_TIMEOUT => 4,
            CURLOPT_POSTFIELDS => http_build_query($post),
            CURLOPT_SSL_VERIFYHOST => 0,
            CURLOPT_SSL_VERIFYPEER => 0,
            CURLOPT_COOKIESESSION => true,
            CURLOPT_COOKIEJAR => COOKIE_FILE, 
            CURLOPT_COOKIEFILE => COOKIE_FILE
        );

        $ch = curl_init();
        curl_setopt_array($ch, ($options + $defaults));
        if( ! $result = curl_exec($ch)) {  
            $result = curl_error($ch);
        }
        preg_match_all('/^Set-Cookie:\s*([^;]*)/mi', $result, $matches);
        $cookies = array();
        foreach($matches[1] as $item) {
            parse_str($item, $cookie);
             $cookies = array_merge($cookies, $cookie);
        }
        $this->cookies = array_merge($this->cookies, $cookies);
        curl_close($ch);
        return $result;
    } 
}
