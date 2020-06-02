<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset=utf-8>
        <meta name=viewport content="width=device-width,initial-scale=1">
        <!-- <link href="{{ asset('css/app.css') }}" rel="stylesheet"> -->
        <title>SPU-SC</title>
    </head>
    <body>
<!--  Começa Aqui -->    
    @php
        $bgcolor ='';
        $cont = 0;
        $data = date("d/m/Y");
        $pagina = 1;
        $rodape =  $_SERVER['REMOTE_ADDR']." ". date("d/m/Y") ." - ". $postagens[0]->tec_resp->nome;
        $cb = $postagens[0]->ano . $postagens[0]->codigo;
    @endphp
    
    @foreach ($postagens[0]->destPost as $postagem)
    @if($cont > 29)
        </div>
        <table style="table-layout: fixed; width: 100%; margin-left:3px;border: 0px solid red;" class="principal">
            <tr>
                <td style="border: 1px solid black;" width=460px >TOTAL DE OBJETOS: {{$cont}}</td>
                <td style="border: 1px solid black;" width=230px>VALOR TOTAL: </td>	
            </tr>
        </table>
        <table style="table-layout: fixed; width: 100%; margin-left:3px;border: 0px solid green;" class="principalx">        
            <tr>
                <td align=center valign="bottom" style="border: 1px solid black;font-size: 9px;" height=200px width=230px>Assinatura do responsável pela postagem </td>	
                <td align=center valign="bottom" style="border: 1px solid black;font-size: 9px;" height=200px width=230px>Assinatura/Matrícula do funcionário da ECT</td>	
                <td align=center valign="bottom" style="border: 1px solid black;font-size: 9px;" height=200px width=230px>Carimbo da Unidade de Postagem</td>	
            </tr>
        </table>
        <table style=" width: 100%; margin-left:3px;border: 0px solid green;" class="principal">
            <tr>
                <td  valign="top"  style="font-size: 9px;">{{$rodape}}</td>
                <td  width=100px>  
                <div align="center" >                
                    {!!DNS1D::getBarcodeHTML($cb, 'C128', 1, 20)!!}
                    {{'*'.$cb.'*'}}
                </div>
                </td>
            </tr> 
        </table>
        <div class="breakNow"></div>
    @endif
    @php
        if ($cont > 29){
            $cont = 0;
            $pagina++;
        }
    @endphp
    @if($cont == 0)
        <div style='border: 0px solid green; ' >
            <table style='table-layout: auto; width: 100%; border: 0px solid red;'>
                <tr >
                    <td style='height:14px;width: 520px;font-size: 12px;'>
                        <b>MINISTÉRIO DO PLANEJAMENTO, DESENVOLVIMENTO E GESTÃO</b>
                    </td>
                    <td align=right style='font-size: 11px; border: 0px solid black;height:14px;'>
                        CONTRATO ECT - MP 9912366622
                    </td>
                </tr>
                <tr >
                    <td style='height:14px;font-size: 12px;'>
                        <b>SECRETARIA DO PATRIMÔNIO DA UNIÃO</b>
                    </td>
                    <td></td>
                </tr>
                <tr ><td style='height:5px;'></td></tr>
                <tr >
                    <td style='height:14px;font-size: 11px;'>
                        Postagem para os Correios efetuada pela SPU/SC em {{$data}}
                    </td>
                    <td align=right style='font-size: 11px; border: 0px solid black;height:15px;'>
                        LISTA NÚMERO: {{$postagens[0]->ano."/".$postagens[0]->codigo}}
                    </td>				
                </tr>
                <tr >
                    <td style='height:14px;font-size: 11px;'>
                        Praça XV de Novembro, 336
                    </td>
                    <td align=right style='font-size: 11px; border: 0px solid black;height:15px;'>
                        CARTÃO: 0070499020
                    </td>
                </tr>
                <tr >
                    <td style='height:14px;font-size: 11px;'>
                        CENTRO
                    </td>
                    <td align=right style='font-size: 11px; border: 0px solid black;height:15px;'>
                        CÓD.ADM.: 14504847
                    </td>
                </tr>
                <tr >
                    <td style='height:14px;font-size: 11px;'>
                        88.010-400 FLORIANÓPOLIS SC
                    </td>
                    <td align=right style='font-size: 11px; border: 0px solid black;height:15px;'>
                        Página: @php echo str_pad($pagina,3,"0",STR_PAD_LEFT); @endphp
                    </td>					
                </tr>
            </table >       
    	    <table class="termo" style='font-size: 11px;margin-top:0px;margin-bottom:2px;margin-top:20px;border: 1px solid black; width: 100%;'>
            <tr >
                <td align=center style='vertical-align: bottom; width:80px;height:15px;'>
                    <b>Registro</b>
                </td>
                <td  style='text-align:center; width:45px;height:15px;'>
                    <b>Peso/ Serviço</b>
                </td>
                <td  style='width:175px;height:15px; vertical-align: bottom;'>
                    <b>Documento</b>
                </td>
                <td  style='vertical-align: bottom; width:230px;height:15px;'>
                    <b>Destinatário</b>
                </td>
                <td  style='vertical-align: bottom; width:65px;height:15px;'>
                    <b>CEP/UF</b>
                </td>
                <td  style='vertical-align: bottom; width:10px;height:15px;'>
                    <b>AR</b>
                </td>
                <td  style='vertical-align: bottom; height:20px;'>
                    <b>Vlr (R$)</b>
                </td>			
            </tr>
        </table >
    </div>
    <div style='width: 700px;height: 560px; border: 0px solid yellow;'>
    @endif    
    @php
        $cont++;
        $bgcolor = strlen($bgcolor)> 0 ? "" : "background-color: #FAF8F8;";
        $codECT =   substr($postagem->codcorreio,0,2)." ".
                    substr($postagem->codcorreio,2,8)." ".
                    substr($postagem->codcorreio,10,1)." ".
                    substr($postagem->codcorreio,11,2);
        $tipo = strlen($postagem->documento->dsctipo->descricao) > 16 ? 
                $postagem->documento->dsctipo->abr : $postagem->documento->dsctipo->descricao;
        $documento =  str_pad($postagem->documento->sequencia,4,"0",STR_PAD_LEFT)."/".$postagem->documento->ano;
        $cep =  $postagem->destinatario->enderecoDest->CEP > 0 ? substr($postagem->destinatario->enderecoDest->CEP,0,5)."-".
                substr($postagem->destinatario->enderecoDest->CEP,5,3)."/".
                $postagem->destinatario->enderecoDest->municipio->estado->descricao : '';
        $nome = strlen($postagem->destinatario->nome) > 35 ? 
                substr($postagem->destinatario->nome,0,35) : $postagem->destinatario->nome;
	
    @endphp    
    <table class="linha"  style=' width: 100%; {{$bgcolor}}'>    
        <tr>
            <td valign="top" style='width:130px;'>{{$codECT}}</td>
            
            <td  valign="top" style='border: 0px solid red; width:105px; text-align:justify; text-justify: inter-word;'>
            {{$tipo}} 
            </td>
            <td  valign="top" style='border: 0px solid green;width:65px; text-align:right; '>
            {{$documento}}
            </td>
            <td valign="top" style='width:230px;'>{{$nome}}</td>
            <td valign="top" style='width:70px;'>{{$cep}}</td>
            <td valign="top" style='width:25px;'>S</td>
            <td valign="top" ></td>
        </tr>
    </table>
@endforeach
@if($cont > 0)
    </div>
        <table style="table-layout: fixed; width: 100%; margin-left:3px;border: 0px solid red;" class="principal">
            <tr>
                <td style="border: 1px solid black;" width=460px >TOTAL DE OBJETOS: {{$cont}}</td>
                <td style="border: 1px solid black;" width=230px>VALOR TOTAL: </td>	
            </tr>
        </table>
        <table style="table-layout: fixed; width: 100%; margin-left:3px;border: 0px solid green;" class="principalx">
            <tr>
                <td align=center valign="bottom" style="border: 1px solid black;font-size: 9px;" height=200px width=230px>Assinatura do responsável pela postagem </td>	
                <td align=center valign="bottom" style="border: 1px solid black;font-size: 9px;" height=200px width=230px>Assinatura/Matrícula do funcionário da ECT</td>	
                <td align=center valign="bottom" style="border: 1px solid black;font-size: 9px;" height=200px width=230px>Carimbo da Unidade de Postagem</td>	
            </tr>
        </table>
        <table style=" width: 100%; margin-left:3px;border: 0px solid green;" class="principal">
            <tr>
                <td  valign="top"  style="font-size: 9px;">{{$rodape}}</td>
                <td  width=100px>  
                <div align="center" >                
                    {!!DNS1D::getBarcodeHTML($cb, 'C128', 1, 20)!!}
                    {{'*'.$cb.'*'}}
                </div>
                </td>
            </tr> 
        </table>
    @endif
    </body>
</html>
<style>
div.breakNow { 
    page-break-inside:avoid; page-break-after:always; 
}

table.termo {
	margin:0px;
	padding:0px;	
	border: 1px solid red;
	font-family: "verdana";  
	font-size: 13px;
}

table.principal {
	margin:0px;
//	background-color:#FCFCF8;
	padding:0px;	
	border: 0px solid silver;
	font-family: Verdana;  
	font-size: 10px;
}
table.principal tr{
	height: 16px;
	padding:0px;	

}	
	
table.simples {
	margin:0px;
	background-color:#EFF5FB;
	padding:0px;	
	border: 0px solid red;
	font-family: "verdana";  
	font-size: 9px;
}
table.linha {
//	border: 1px solid red;
	margin-top:-1px;
//	border-bottom:1px solid black;
	font-family: Verdana;  
	font-size: 11px;
	
}
p {
	background-color:#FCFCF8;
	margin:0px;
	padding:0px;	
	border: 0px;
	font-family: "verdana";  
	font-size: 11px;
}	
.justifyText{
    text-align:justify; 
    text-justify: inter-word;    
}
</style>