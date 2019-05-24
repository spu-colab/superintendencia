<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

// define("COOKIE_FILE", "cookie.txt");

class ImoveisFederaisController extends Controller
{
    public function login() {
        $this->cookies = [];
        $login = "";
        $senha = '';

       //*
        //POST que retorna 
        $url = 'https://imoveisfederais.planejamento.gov.br/spin-web/login';
        $parametros = [
            'j_password' => $senha,
            'j_username' =>	$login
        ];
        $resposta = $this->curl(1, $url, $parametros);
        //var_dump($resposta);
        //var_dump($this->cookies);
        /// ***********************************       
        
        $url = 'https://imoveisfederais.planejamento.gov.br/spin-web/buscar/municipios/simples?codUF=42';
        // https://geoserver.imoveisfederais.planejamento.gov.br/geoserver/ide/ows?service=WFS&request=GetFeature&typeName=ide:imovel_busca&viewparams=p_uf:42;p_mun:4202008&outputFormat=application/json
        // https://geoserver.imoveisfederais.planejamento.gov.br/geoserver/ide/ows?service=WFS&request=GetFeature&typeName=ide:imovel_busca&viewparams=p_uf:42&outputFormat=application/json
        $parametros = [
            'codUF'    => 42
        ];
        /*
        $jSESSIONID = $this->cookies['JSESSIONID'];
        $opcoes = [
            CURLOPT_HTTPHEADER => [
                'Cookie' => ": JSESSIONID=$jSESSIONID"
            ]
        ];
        //*/
        $resposta = $this->curl(false, $url, $parametros); //, $opcoes);
        var_dump($resposta);
        exit();       
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
            CURLOPT_HEADER => 1,
            CURLOPT_URL => $url,
            CURLOPT_FRESH_CONNECT => 1,
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_FORBID_REUSE => 1,
            CURLOPT_TIMEOUT => 4,
            CURLOPT_SSL_VERIFYHOST => 0,
            CURLOPT_SSL_VERIFYPEER => 0,
            CURLOPT_COOKIESESSION => true,
            CURLOPT_COOKIEJAR => COOKIE_FILE, 
            CURLOPT_COOKIEFILE => COOKIE_FILE
        );
        if($isPost) {
            $defaults[CURLOPT_POST] = $isPost;
            $defaults[CURLOPT_POSTFIELDS] = http_build_query($post);
        }

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
