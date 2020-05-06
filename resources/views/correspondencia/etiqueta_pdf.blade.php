<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset=utf-8>
        <meta name=viewport content="width=device-width,initial-scale=1">
        <!-- <link href="{{ asset('css/app.css') }}" rel="stylesheet"> -->
        <title>SPU-SC</title>
    </head>
    <body>
        @php
            $cont = 0;           
        @endphp
        @foreach ($correspondencia['destinatarios'] as $dest)
            @php
                $CEP = str_pad($dest->destinatario->enderecoDest->CEP,8,"0",STR_PAD_LEFT);
                $strCEP = substr($CEP,0,5)."-".substr($CEP,5,3);
                if( $cont > 6 ) { echo '<div class="breakNow"></div>'; $cont=0; }
            @endphp
            @for ($i = 0; $i < 2; $i++)
            <div style="padding:1px; margin-left:8px;margin-bottom:1px;margin-top:0px;  border: 1px dotted silver; width:480px;">
                <table width=475px  style="padding:2px;">
                    <tr  style='height:8px;font-size: 8px;color: silver;'>
                        <td width=315px style='font-size: 10px;color:#585858;'>
                            {{$correspondencia->dscTipo->descricao. ' '.$correspondencia->dscSetor->descricao. ' '. 
                            $correspondencia->sequencia.'/'.$correspondencia->ano}}
                        </td>
                        <td style='font-size: 10px;color:#585858;text-align:right;'>
                            {{'Ref. '. $correspondencia->referencia}}
                        </td>
                    </tr>
                    <tr  style='font-size: 14px;'>
                        <td colspan="2">
                            <b>{{$dest->destinatario->nome}}</b><br>                    
                            @php      
                                $dest->destinatario->enderecoDest->complemento = $dest->destinatario->enderecoDest->complemento == 'null' ? 
                                    '':$dest->destinatario->enderecoDest->complemento;
                                echo strlen($dest->destinatario->orgao)? $dest->destinatario->orgao.'<br>':'';
                                $br = strlen($dest->destinatario->orgao)? '': "<br>";
                                echo strlen($dest->destinatario->setor)? $dest->destinatario->setor.'<br>':'';
                                $br = strlen($dest->destinatario->setor)? '': "<br>";
                                echo $br;
                            @endphp                    
                            {{$dest->destinatario->enderecoDest->tipologradouro->descricao}} 
                            {{$dest->destinatario->enderecoDest->logradouro}}
                            {{strlen($dest->destinatario->enderecoDest->numero)>0 ? ", ".$dest->destinatario->enderecoDest->numero:""}}
                            {{strlen($dest->destinatario->enderecoDest->complemento) > 0 ? "- ".$dest->destinatario->enderecoDest->complemento:""}}
                            <br>
                            {{$dest->destinatario->enderecoDest->bairro}}
                        </td>
                    </tr>
                </table>
                <table  width=465px style="padding:2px;margin-top:-25px;">
                    <tr style='font-size: 14px;'>
                        <td style='width:380px;vertical-align:bottom'>
                            <b>{{$strCEP}}</b> {{" - ".$dest->destinatario->enderecoDest->municipio->cidade . " /".
                                $dest->destinatario->enderecoDest->municipio->estado->descricao}}
                        </td>
                        <td style="text-align:center; font-size: 10px; ">
                        @php
                            $cont++;
                            $cb = substr($correspondencia->ano,2,2) . str_pad($dest->codigo,6,"0",STR_PAD_LEFT);
                        @endphp
                        {!!DNS1D::getBarcodeHTML($cb, 'C128', 1, 20)!!}{{'*'.$cb.'*'}}
                        </td>
                    </tr>
                </table>
            </div>            
            @endfor
            <br>
        @endforeach     
    </body>
</html>
<style>
div.breakNow { page-break-inside:avoid; page-break-after:always; }
table td tr {
	margin-top:-1px;
	padding:0px;	
	height:7px;
    font-family: "Helvetica";  
}
table{
	margin:0px;
	padding:0px;	
	border: 0px solid silver;
	font-family: "Helvetica";  
	font-size: 13px;
}
body {
	font-family:"Helvetica"; 
	font-size: 11px;
	padding:0px;
	margin: 0px;
	margin-left:0px;
}
</style>