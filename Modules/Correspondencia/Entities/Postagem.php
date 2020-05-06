<?php

namespace Modules\Correspondencia\Entities;

use Illuminate\Database\Eloquent\Model;

class Postagem extends Model
{
    protected $connection = 'spuadmin';
    protected $table = "corresp_dest";
    protected $primaryKey = 'codigo';
        
    public function __invoke()
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://www2.correios.com.br/sistemas/rastreamento/resultado_semcontent.cfm");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    
        $result = CorrespDest::selectRaw('codigo, codcorreio')->whereRaw('tipo_dev=5 and dtpost > "2020-01-01"')->get();
        foreach ($result as $corresp) {
            $rastro = $this->consultaEct($corresp->codcorreio, $ch);
            $correspDest = new CorrespDest;
            $correspDest = $corresp;
            $correspDest->timestamps = false;
            $correspDest->rastro = $rastro[0];
            if ($rastro[2] > 0){
                $correspDest->dtdev = $rastro[1];
                $correspDest->tipo_dev = $rastro[2];
            }
//            echo "\n";
//            echo($corresp->codcorreio . " " . $rastro[2]);
            $correspDest->update();
        }
    }

    public function consultaEct($obj, $ch){
        $dtevento = '';
        $tipo_dev = 0;
        $post = array('Objetos' => $obj);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST,  2);                
        $str = curl_exec($ch);

        $pos_ini = strpos($str,'<table ');
        $pos_fim = strpos($str,'</table>');
        $pos_fim_lin = strpos($str,'</tr>');
        $str2 = substr($str, $pos_ini, $pos_fim - $pos_ini +8 );
        
        $str2 = utf8_encode ( $str2 );
        $str2 = str_replace('"',"",$str2);
        
        $strlin = substr($str, $pos_ini, $pos_fim_lin);
        $strlin = utf8_encode ( $strlin );

        $str2 = preg_replace('/\s\s+/', ' ', $str2);
        $respevento = $str2;
        if (strpos ($str,"tente novamente mais tarde")){
            $respevento = "Objeto não encontrado na base dos correios";
        }
        else{
            if (strpos ($strlin,"entregue ao dest")){
                $tipo_dev = 6;
                $dtevento = $this->dt_event($str2);	}
            else{
                if (strpos ($strlin,"devolvido ao remetente")){
                    $tipo_dev = 9;
                    $dtevento = $this->dt_event($str2);	}
                else{
                    if (strpos ($strlin,"em devolução ao remetente")){
                        $tipo_dev = 9;
                        $dtevento = $this->dt_event($str2);	}
                }
            }
        }
        return [$respevento, $dtevento, $tipo_dev];        
    }

    function dt_event($str){
        $posaux = strpos($str, "/");
        $dt_event = substr($str, $posaux -2, 10);	
        $dd = explode("/", $dt_event);
        $dtinv =$dd[2]."-".$dd[1]."-".$dd[0]; 
        return $dtinv;
    }		
}