<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class PopulaBensCategoriaTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        DB::table('bens_categoria')->insert(
            [
                ['id'=>1,'descricao'=>'TECLADO PARA MICRO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>2,'descricao'=>'MICROCOMPUTADOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>3,'descricao'=>'MONITOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>4,'descricao'=>'MESA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>5,'descricao'=>'CADEIRA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>6,'descricao'=>'TELEFONE COM FIO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>7,'descricao'=>'ARMÁRIO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>12,'descricao'=>'GAVETEIRO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>13,'descricao'=>'SUPORTE PARA CPU','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>14,'descricao'=>'AR CONDICIONADO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>15,'descricao'=>'MÓDULOS','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>16,'descricao'=>'HUB','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>17,'descricao'=>'NOTEBOOK','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>18,'descricao'=>'PORTA CHAPÉU','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>19,'descricao'=>'APARELHO DE SOM','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>20,'descricao'=>'TELEFONE SEM FIO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>21,'descricao'=>'SWITCH','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>22,'descricao'=>'TELA PROJETORA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>23,'descricao'=>'LEITORA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>24,'descricao'=>'NOBREAK','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>25,'descricao'=>'FITA BACKUP','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>26,'descricao'=>'SERVIDOR DE REDE','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>27,'descricao'=>'TV','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>28,'descricao'=>'ARQUIVO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>29,'descricao'=>'FICHÁRIO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>30,'descricao'=>'CÂMERA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>31,'descricao'=>'CONEXÃO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>32,'descricao'=>'LIVRO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>33,'descricao'=>'TACH DE AÇO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>34,'descricao'=>'SCANNER','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>35,'descricao'=>'FRAGMENTADORA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>36,'descricao'=>'CARRINHO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>37,'descricao'=>'CENTRAL TELEFÔNICA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>38,'descricao'=>'CADEIRA LONGARINA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>39,'descricao'=>'FOGÃO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>40,'descricao'=>'REFRIGERADOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>41,'descricao'=>'RADIO AM/FM','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>42,'descricao'=>'FURADEIRA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>43,'descricao'=>'CIRCULADOR DE AR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>44,'descricao'=>'COLETOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>45,'descricao'=>'GPS','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>46,'descricao'=>'BANCO DE BATERIAS','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>47,'descricao'=>'LIQUIDIFICADOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>48,'descricao'=>'ROTEADOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>49,'descricao'=>'RELÓGIO DE PONTO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>50,'descricao'=>'ESTABILIZADOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>51,'descricao'=>'FAC SÍMILE - FAX','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>52,'descricao'=>'QUADRO MAGNÉTICO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>53,'descricao'=>'ESCADA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>54,'descricao'=>'ESTEREOSCÓPIO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>55,'descricao'=>'PANTÓGRAFO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>57,'descricao'=>'BEBEDOURO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>58,'descricao'=>'PERFURADOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>59,'descricao'=>'VENTILADOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>62,'descricao'=>'ESTANTE','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>63,'descricao'=>'MASTRO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>64,'descricao'=>'PERSIANA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>65,'descricao'=>'AUTOMÓVEL','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>66,'descricao'=>'BALCÃO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>67,'descricao'=>'APARELHO DE VÍDEO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>68,'descricao'=>'FONE DE OUVIDO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>69,'descricao'=>'PROJETOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>70,'descricao'=>'ESCRIVANINHA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>71,'descricao'=>'SOFÁ','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>72,'descricao'=>'UNIDADE WINCHESTER','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>73,'descricao'=>'IMPRESSORA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>74,'descricao'=>'PLANÍMETRO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>75,'descricao'=>'DISTANCIÔMETRO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>76,'descricao'=>'TABLET','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>77,'descricao'=>'AUTOMATIZADOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>78,'descricao'=>'COFRE','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>80,'descricao'=>'TRANSFORMADOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>81,'descricao'=>'DVD PLAYER','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>82,'descricao'=>'CONVERSOR DE VÍDEO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>83,'descricao'=>'CARPET','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>84,'descricao'=>'EXTINTOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>85,'descricao'=>'TOLDO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>86,'descricao'=>'MANGUEIRA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>87,'descricao'=>'FORNO','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>88,'descricao'=>'EXAUSTOR','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>89,'descricao'=>'CODEC VIDEOCONFERENCIA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>90,'descricao'=>'DRONE','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>91,'descricao'=>'JARRA ELÉTRICA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>94,'descricao'=>'TAPETE','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>95,'descricao'=>'SOFTWARE','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>96,'descricao'=>'POLTRONA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>97,'descricao'=>'CASE','idUser'=>15,'created_at' => date("Y-m-d H:i:s")],
                ['id'=>98,'descricao'=>'BATERIA','idUser'=>15,'created_at' => date("Y-m-d H:i:s")]
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
