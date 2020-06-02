<!DOCTYPE html>
<html >
    <head>
        <!-- <link href="{{ asset('css/app.css') }}" rel="stylesheet"> -->
        <title>TERMO RESPONSABILIDADE</title>
    </head>
    <body>
@php
    $pagina = 0;
    $linhas = 0;
    $data = date("d/m/Y H:i");
@endphp
@foreach ($bens['item'] as $bem)
    @if($linhas > 29)
        @php
            $linhas = 0;
        @endphp
            </table >
        </div>
        <div style='margin-top:5px;margin-left:0px; border: 0px solid red;height: 162px; width: 100%;'>
            <div align=center style='margin:0px ;border: 1px solid black;height: 160px; width: 340px;float: left;'>
                <table >
                <tr >
                    <td align=justify style='height:65px;'>Atesto que recebi os bens patrimoniais constantes neste, assumindo total responsabilidade pela guarda e zelo dos mesmos.</td>
                </tr>
                <tr >
                    <td style='height:40px;vertical-align:top;font-size: 13px;'><b>DATA:___/___/______</b></td>
                </tr>
                <tr >
                    <td align=center style=' border: 0px solid black;  height:5px;'>___________________________________ </td>
                </tr>
                <tr >
                    <td align=center style=' border: 0px solid black; height:5px;'>Assinatura do Servidor</td>
                </tr>
                
                </table>
            </div>
            <div style='margin:0px;margin-left:-1px;height: 160px; width: 355px; border: 1px solid black;float: right;'> 
                <table >
                <tr >
                    <td align=justify style='height:65px;'></td>
                </tr>
                <tr >
                    <td style='height:40px;vertical-align:top;font-size: 13px;'><b>DATA:___/___/______</b></td>
                </tr>
                <tr >
                    <td align=center style=' border: 0px solid black;  height:5px;'><b>___________________________________</b></td>
                </tr>
                <tr>
                    <td align=center style=' border: 0px solid black; width: 355px;height:5px;font-size: 13px;'>Assinatura da Chefia Imediata</td>
                </tr>
                </table>
            </div>
            <p style='font-size: 9px;'><?php echo $_SERVER['REMOTE_ADDR']." ". date("d/m/Y");?></p>
        </div>
        <h1></h1>
    @endif
    @if($linhas == 0)
        @php
            $pagina++;
        @endphp
        <div style='height: 100px;' >
            <table >
                <tr >
                    <td style='height:18px;width: 550px;font-size: 15px;'>
                        <b>Ministério da Economia</b>
                    </td>
                    <td align=right style='width: 140px; border: 0px solid black;height:15px;font-size: 11px;'>
                        Página:<b> {{$pagina}}</b>
                    </td>
                </tr>
                <tr >
                    <td style='height:18px;font-size: 14px;'>
                        <b>Secretaria Especial de Desestatização e Desinvestimento</b>
                    </td>
                </tr>
                <tr ><td style='height:18px;font-size: 14px;'><b>Secretaria de Coordenação e Governança do Patrimônio da União</b></td></tr>			
                <tr >
                    <td style='height:18px;font-size: 14px;'>
                        <b>Superintendência do Patrimônio da União em Santa Catarina</b>
                    </td>
                    <td align=right style=' border: 0px solid black;height:15px;font-size: 11px;'>
                        Em:<b> {{$data}}</b>
                    </td>
                </tr>
            </table >
        </div>
        <div style='height: 56px;' >
            <div  style='margin-top:1px; border: 1px solid black;height: 55px; width: 30%; float: left'>
                <table align=center>
                    <tr >
                    <td align=center style='align:center;height:20px;vertical-align:middle;'>
                        <b>TERMO DE</b>
                    </td>
                    </tr>
                    <tr >
                    <td style='align:center; height:20px;vertical-align:middle;'>
                        <b>RESPONSABILIDADE</b>
                    </td>
                    </tr>
                </table>
            </div>   
            <div style='margin-top:0px;margin-left:0px;height: 55px; width: 69.2%; border: 1px solid black; float: right'> 
                <table class="termo" style='margin-left:10px;'>
                    <tr>
                        <td>
                            Responsável: <b>{{$bens['responsavel']}}</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Setor: <b>{{$bens['divisao']}}</b>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div style='margin-left:0px;margin-top:5px;border: 1px solid black;height:20px;' >
            <table class="termo" style='margin-top:0px;width:100%;'>
                <tr >
                    <td align=right style='width:70px;height:15px;'>
                        <b>Patrimônio</b>
                    </td>
                    <td align=center style='height:15px;'>
                        <b>Descrição</b>
                    </td>
                    <td align=right style='width:100px;height:15px;'>
                        <b>Valor (R$)</b>
                    </td>
                </tr>
            </table >
        </div>
        <div style='margin-left:0px;margin-top:1px;border: 1px solid black;height:600px;'>
            <table class="termo" style='margin-top:0px;width:100%;'>
    @endif
    @php
        $tamanho = strlen($bem->descricao) + strlen($bem->categoria);
        if($tamanho> 69){
            $linhas = $linhas + (intdiv($tamanho, 70) +1);
        }
        else{
            $linhas ++;
            }
    @endphp
                <tr style='padding-top:10px;'>
                    <td align=right style='width:70px;height:15px;vertical-align:top;'>
                        <b>{{number_format($bem->codigo,0,',','.')}}</b>
                    </td>
                    <td style='height:15px;'>
                        {{$bem->categoria}}-{{$bem->descricao}}
                    </td>
                    <td align=right style='width:100px;height:15px;vertical-align:top;'>
                        <b>{{number_format($bem->preco,2,',','.')}}</b>
                    </td>
                </tr>
@endforeach
        </table >
        </div>
        <div style='margin-top:5px;margin-left:0px; border: 0px solid red;height: 162px; width: 100%;'>
            <div align=center style='margin:0px ;border: 1px solid black;height: 160px; width: 340px;float: left;'>
                <table >
                <tr >
                    <td align=justify style='height:65px;'>Atesto que recebi os bens patrimoniais constantes neste, assumindo total responsabilidade pela guarda e zelo dos mesmos.</td>
                </tr>
                <tr >
                    <td style='height:40px;vertical-align:top;font-size: 13px;'><b>DATA:___/___/______</b></td>
                </tr>
                <tr >
                    <td align=center style=' border: 0px solid black;  height:5px;'>___________________________________ </td>
                </tr>
                <tr >
                    <td align=center style=' border: 0px solid black; height:5px;'>Assinatura do Servidor</td>
                </tr>
                
                </table>
            </div>
            <div style='margin:0px;margin-left:-1px;height: 160px; width: 355px; border: 1px solid black;float: right;'> 
                <table >
                <tr >
                    <td align=justify style='height:65px;'></td>
                </tr>
                <tr >
                    <td style='height:40px;vertical-align:top;font-size: 13px;'><b>DATA:___/___/______</b></td>
                </tr>
                <tr >
                    <td align=center style=' border: 0px solid black;  height:5px;'><b>___________________________________</b></td>
                </tr>
                <tr>
                    <td align=center style=' border: 0px solid black; width: 355px;height:5px;font-size: 13px;'>Assinatura da Chefia Imediata</td>
                </tr>
                </table>
            </div>
            <p style='font-size: 9px;'><?php echo $_SERVER['REMOTE_ADDR']." ". date("d/m/Y");?></p>
        </div>
    </body>
</html>
<style>
p.quebra    { page-break-after: always }
table.termo {
	margin:0px;
	padding:0px;	
	border: 0px solid silver;
	font-family: Verdana;  
	font-size: 13px;
}
body {
	font-family: Verdana; 
	font-size: 13px;
	padding:0px;
	margin: 0px;
	margin-left:0px;
} 
h1 {page-break-before:always;}
</style>
