<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\User;
class PopulaBensSalaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::table('bens_sala')->insert(
            [
                ['id'=>7,'idDivisaoOrganograma'=>13,'descricao'=>'DIRFH','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>18,'idDivisaoOrganograma'=>13,'descricao'=>'COCAI/COCAI','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>19,'idDivisaoOrganograma'=>13,'descricao'=>'CODES','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>29,'idDivisaoOrganograma'=>13,'descricao'=>'COCAI/DIINC','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>30,'idDivisaoOrganograma'=>13,'descricao'=>'COCAI/DIIUP','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>75,'idDivisaoOrganograma'=>13,'descricao'=>'COCAI/SALA URGEO-SUL','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>102,'idDivisaoOrganograma'=>13,'descricao'=>'COCAI/ARMARIO D','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>108,'idDivisaoOrganograma'=>13,'descricao'=>'COCAI/COPA','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>119,'idDivisaoOrganograma'=>9,'descricao'=>'NUFIS','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>107,'idDivisaoOrganograma'=>11,'descricao'=>'NUGEO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>1,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ARQ ADM','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>2,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/PROTOCOLO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>4,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ASSESSORIA','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>8,'idDivisaoOrganograma'=>2,'descricao'=>'SEAPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>9,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ARQUIVO  01-1970/1996','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>10,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ARQUIVO  02-1997/2016','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>11,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/RECURSOS INTERNOS','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>13,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/COFRE','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>14,'idDivisaoOrganograma'=>2,'descricao'=>'LOCALIZAR','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>15,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/DATA CENTER ','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>20,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/CORREDOR TERREO-SEAPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>21,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/COPA','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>22,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/SALA DE TELEFONISTAS','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>25,'idDivisaoOrganograma'=>2,'descricao'=>'EM DESFAZIMENTO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>26,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/GERAL','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>28,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/NUCLEO DE DIGITALIZAÇAO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>31,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/SALA DOS MOTORISTAS/ ARMÁRIO "B"','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>32,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/SALA DE DIGITALIZAÇAO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>34,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/PROTOCOLO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>36,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/CORREDOR TERREO DIREP','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>37,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 87','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>38,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/TRE','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>39,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>40,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/GUARITA DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>41,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 86','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>42,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/EMPRESTIMO SAMF','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>43,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/TUBARAO DNIT DOAÇAO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>44,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 86 ANEXO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>45,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 74 - TRE','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>46,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 52 A/B DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>47,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 50 A DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>48,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 60 B DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>49,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/AUD.TRE','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>50,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 73/AUD.TRE','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>51,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 37 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>52,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 26 A DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>53,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 27','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>54,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 07 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>55,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/PORTAO DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>56,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 64 A','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>57,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 62 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>58,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 65 B DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>59,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 35 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>60,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 41 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>61,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 38 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>62,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 24 A DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>63,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 03 C DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>64,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 06 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>65,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 22 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>66,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 77 TRE','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>67,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 61 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>68,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 19 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>70,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 17 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>71,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 14 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>72,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/PORTA DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>73,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/RECEPCAO SEAPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>74,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/HALL/ARMÁRIO "A"','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>76,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/HALL ESCADA','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>77,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/HALL/ARMÁRIO "B"','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>78,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/DATA CENTER/ARMÁRIO "C"','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>79,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/HALL EM BAIXO DA ESCADA - CAIXA DE PAPELÃO/POSITIVO  Nº 12','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>80,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/RECEPÇÃO SEAPU/TV','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>81,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/HALL EM BAIXO DA ESCADA PRÓXIMO SALA DOS MOTORISTAS','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>82,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/RECURSOS INTERNO/ARMÁRIO ','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>83,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/BANHEIRO FEMININO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>84,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/CASA DE MÁQUINAS','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>85,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/SALA AR CONDICIONADO - 1º ANDAR','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>86,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ 1° ANDAR','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>87,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/TÉRREO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>88,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/SALA DE ALTA TENSÃO(CELESC)','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>89,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 18','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>90,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/ARQUIVO 01 SALA 12','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>91,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES-BV/SALA 55 DPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>92,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/SM/SISREF','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>93,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/SALA 60','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>94,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/CORREDOR 1º ANDAR','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>95,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ARQ/ADM','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>96,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/RECEPÇÃO GAB','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>97,'idDivisaoOrganograma'=>2,'descricao'=>'NUJUC','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>98,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ ARQUIVO 02','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>101,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/SALA DOS MOTORISTAS/ARMÁRIO "5"','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>103,'idDivisaoOrganograma'=>2,'descricao'=>'SALA DOS MOTORISTAS','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>104,'idDivisaoOrganograma'=>2,'descricao'=>'NUJUC/ARMÁRIO E','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>105,'idDivisaoOrganograma'=>2,'descricao'=>'NUJUC/ARMÁRIO F','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>106,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/SALA DOS MOTORISTAS','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>109,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ RECUSOS INTERNOS','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>110,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ ATENDIMENTO AO PÚBLICO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>111,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ PROTOCOLO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>112,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ ARQUIVO 01','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>113,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ ARQ. ADM','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>114,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ DIGITALIZAÇÃO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>115,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ VIGILANTES','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>116,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ RECEPÇÃO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>117,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ COPA','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>118,'idDivisaoOrganograma'=>2,'descricao'=>'NUGES/ SALA MOTORISTA','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>120,'idDivisaoOrganograma'=>17,'descricao'=>'NUINC','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>16,'idDivisaoOrganograma'=>6,'descricao'=>'NUREP/DIREP','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>24,'idDivisaoOrganograma'=>6,'descricao'=>'NUREP/SEGES','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>99,'idDivisaoOrganograma'=>6,'descricao'=>'NUREP','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>3,'idDivisaoOrganograma'=>1,'descricao'=>'SPU-SC/GABINETE','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>5,'idDivisaoOrganograma'=>1,'descricao'=>'SPU-SC/GARAGEM','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>6,'idDivisaoOrganograma'=>1,'descricao'=>'SPU-SC/RECEPÇÃO','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>131,'idDivisaoOrganograma'=>2,'descricao'=>'HOME OFFICE','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>132,'idDivisaoOrganograma'=>13,'descricao'=>'COORD/NUAVA','created_at' => date("Y-m-d H:i:s"),'idUser'=>15],
                ['id'=>35,'idDivisaoOrganograma'=>1,'descricao'=>'SPU-SC/SEAPU','created_at' => date("Y-m-d H:i:s"),'idUser'=>15]            
            ]
        );
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
            //
    }
}
