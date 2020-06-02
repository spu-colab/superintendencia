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
        $linhas = 0;
        $totbens = 0;
        $pag = 0;
		$data = date("d/m/Y H:i");
        $situacao = $bens['situacao'];
        $conservacao = $bens['conservacao'];
        $levantamento = $bens['levantamento'];
        $agrupamento = $bens['agrupamento'];
		$dscDivisao = $bens['divisao'];
    @endphp
    @foreach ($bens['item'] as $bem)

	@if($linhas > 48)
		</table >		
		<p align="right">Situação: 1-Não localizado / 2-Em mau estado / 3-Furtado</p>
		<h1></h1>
		@php
			$linhas = 0;
		@endphp
	@endif
	@if($linhas == 0)
		@php
			$pag++;
			$dscHeader = ($situacao == 9) ? 'Relação dos Bens Patrimoniais Descartados' :
						(($situacao == 2) ? 'Relação dos Bens Patrimoniais em Desfazimento':
						(($agrupamento == 3) ? 'Relação Geral dos Bens Patrimoniais' :
						(($agrupamento == 2) ? 'Relação dos Bens Patrimoniais por Técnico Responsável':
						(($dscDivisao) ? 'Relação dos Bens Patrimoniais Cadastrados em '. $dscDivisao:
						'Relação Geral dos Bens Patrimoniais' ))));
		@endphp
	<table style="font-family: verdana;" >
			<tr >
				<td style='height:14px;width: 550px;font-size: 14px;'>
					<b>Ministério da Economia</b>
				</td>
				<td align=right style='width: 140px;font-size: 12px; height:15px;'>
					Página:<b> {{$pag}}</b>
				</td>
			</tr>
			<tr >
				<td style='height:14px;font-size: 14px;'>
					<b>Secretaria Especial de Desestatização e Desinvestimento</b>
				</td>				
				<td align=right style='font-size: 14px; height:15px;'>
				</td>
			</tr>
			<tr >
			<td style='height:14px;font-size: 14px;'><b>Secretaria de Coordenação e Governança do Patrimônio da União</b></td>
			<td></td>
			</tr>
			<tr >
				<td style='height:14px;font-size: 14px;'>
					<b>SUPERINTENDÊNCIA DO PATRIMÔNIO DA UNIÃO EM SANTA CATARINA</b>
				</td>
				<td  align=right style='height:12px;font-size: 12px;'></b></td>
			</tr>
			<tr >
				<td style='height:14px;font-size: 14px;'>
					<b>{{$dscHeader}}</b>
				</td>
				<td  align=right style='height:12px;font-size: 12px;'> Em:<b> {{$data}}</b></td>
			</tr>
			
		</table >
		<table class="termo" style='margin-top:0px;border: 0px solid black;font-family: verdana;'>
		<tr >		
			<td align=right style='width:70px;height:15px;border-bottom: 1px solid #BDBDBD;'>
				<b>Código</b>
			</td>
			<td align=center style='width:500px;height:15px;border-bottom: 1px solid #BDBDBD;'>
				<b>Descrição</b>
			</td>
			<td  style='width:120px;height:15px;border-bottom: 1px solid #BDBDBD;'>
				<b>Local</b>
			</td>
		</tr>
	@endif
        @php
			if(strlen($bem->descricao)> 65){
				$linhas = $linhas + (intdiv(strlen($bem->descricao), 66) +3);
			}
			else{
				$linhas = $linhas + 4;
			}
            $cont++;
            $totbens++;
			$sitest = 	($bem->idLevantamento == 2 && $bem->idConservacao ==2) ? "* Sit.(1/2)" : 
						(($bem->idLevantamento == 2 ) ? "*** Sit.(1)" : 
						(($bem->idConservacao == 2) ? "*** Sit.(2)" : 
						(($bem->idLevantamento == 3) ? "*** Sit.(3)" : " ")));
			$descarte = $situacao == 9 ? 'Descartado' : $bem->situacao;
			$responsavel =  ($situacao == 9 || $bem->situacao == 2) ? 
				$bem->destino ." ".$bem->processo." ".$bem->oficio." ". $bem->despacho." ".$bem->observacoes : 
				$bem->responsavel." - ". "R\$ ".number_format($bem->preco,2,',','.');

        @endphp
        <tr style='height:35px;vertical-align:top;'>
		<td align=right style='width:70px;vertical-align:top;'>
			@php
				if ($bem->codigo < 1000000){ 
					echo "<b>".number_format($bem->codigo,0,',','.')."</b>";
				}
				else{
					echo "<b>".number_format(substr($bem->codigo,1,6),0,',','.')."*</b>";
					$totbens --;
				}
				echo "<br><p align=right>".str_pad($cont,4,"0",STR_PAD_LEFT)."</p>";
			@endphp
		</td>
		<td style='width:500px;vertical-align:top;'>{{$bem->categoria. " - ". $bem->descricao}}</td>
		<td style='width:120px;vertical-align:top;font-size: 10px;'>{{$bem->localizacao}}</td>
	</tr>
    
	<tr style='height:12px;vertical-align:top; '>
		<td style='width:70px; border-bottom: 1px solid #BDBDBD;' align="right">{{$sitest}}</td>
		<td style='width:500px; border-bottom: 1px solid #BDBDBD;'>
            {{$responsavel}}</td>
		<td style='width:120px; border-bottom: 1px solid #BDBDBD;'>
			<b>
            @php 
				if ($bem->codigo>1000000){ 
					echo "Uso Compartilhado";
				}
				else{
					echo $descarte;			
				}		
			@endphp
			</b>
		</td>
	</tr>
    @endforeach
    </table>
	<p align="right">Situação: 1-Não localizado / 2-Em mau estado / 3-Furtado</p>
</body>
<style>

xhr {
      border: 0px solid #000000;
      color: #000000;
      background-color: #000000;
      height: 2px;
    }
    
table.termo {
	margin:0px;
	padding:0px;	
	border: 0px solid silver;
	font-family: "verdana";  
	font-size: 13px;
}
#divprn {
	width: 830px;
	border: 1px solid #c0c0c0;
	overflow:hidden;
}
table.principal{
	margin:0px;
	height: 8px;
	background-color:#FCFCF8;
	padding:0px;	
	border: 0px solid silver;
	font-family: "verdana";  
	font-size: 11px;
}	
table.principal td{
	valign:"middle";
}	
table.simples {
	margin:0px;
	background-color:#EFF5FB;
	padding:0px;	
	border: 0px solid silver;
	font-family: "verdana";  
	font-size: 9px;
}

p {
	
	margin:0px;
	padding:0px;	
	border: 0px;
	font-family: "verdana";  
	font-size: 9px;
}	
px {
	margin:0px;
	padding:0px;	
	border: 0px;
	font-family: "verdana";  
	font-size: 11px;
}		
body {
	font-family: Verdana; 
	font-size: 11px;
	padding:0px;
	margin: 0px;
	margin-left:0px;
}
#divprn {
	width: 830px;
	border: 1px solid #c0c0c0;
	overflow:hidden;
}

h1 {page-break-before:always;}

</style>

</html>
