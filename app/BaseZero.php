<?php
namespace App;

use Illuminate\Support\Facades\DB;

use App\SituacaoDemanda;

class BaseZero
{

    public function inserirRegistros()
    {
        $this->inserirSituacoesDemanda();
        $this->inserirTiposDocumento();
        $this->inserirPermissoes();
    }

    public function removerRegistros()
    {
        DB::table("permissao")->delete();
        DB::table("tipodocumento")->delete();
        DB::table("situacaodemanda")->delete();
        
    }

    private function inserirSituacoesDemanda() {
        /**
         * Inserindo registros em situacaodemanda
         */
        DB::transaction(function () {
            $registrosAInserir = [
                [
                    'id' => SituacaoDemanda::NOVA, 
                    'situacao' => SituacaoDemanda::NOVA_DESC
                ],
                [
                    'id' => SituacaoDemanda::EM_ANALISE, 
                    'situacao' => SituacaoDemanda::EM_ANALISE_DESC
                ],
                [
                    'id' => SituacaoDemanda::RESOLVIDA, 
                    'situacao' => SituacaoDemanda::RESOLVIDA_DESC
                ],
                [
                    'id' => SituacaoDemanda::CANCELADA, 
                    'situacao' => SituacaoDemanda::CANCELADA_DESC
                ],
                [
                    'id' => SituacaoDemanda::PRONTA, 
                    'situacao' => SituacaoDemanda::PRONTA_DESC
                ],
                [
                    'id' => SituacaoDemanda::AGUARDANDO_ASSINATURA, 
                    'situacao' => SituacaoDemanda::AGUARDANDO_ASSINATURA_DESC
                ],
                [
                    'id' => SituacaoDemanda::AGUARDANDO_AR, 
                    'situacao' => SituacaoDemanda::AGUARDANDO_AR_DESC
                ],
            ];
            DB::table('situacaodemanda')->insertOrIgnore($registrosAInserir);
        });
    }

    private function inserirTiposDocumento() {
        DB::transaction(function () {
            $registrosAInserir = [
                [
                    'tipodocumento' => 'Ofício'
                ],
                [
                    'tipodocumento' => 'Despacho'
                ],
                [
                    'tipodocumento' => 'Memorando'
                ],
                [
                    'tipodocumento' => 'E-mail'
                ],
                [
                    'tipodocumento' => 'Carta'
                ]
            ];
            DB::table('tipodocumento')->insertOrIgnore($registrosAInserir);
        });
    }

    private function inserirPermissoes() {
        DB::transaction(function () {
            $registrosAInserir = [
                /**
                 * Atendimento
                 */
                [
                    'permissao' => Permissao::ATENDIMENTO_ATENDIMENTO_CRIAR_PRESENCIAL,
                    'descricao' => 'Permite iniciar/salvar/concluir um atendimento presencial'
                ],
                [
                    'permissao' => Permissao::ATENDIMENTO_ATENDIMENTO_CRIAR_TELEFONICO,
                    'descricao' => 'Permite iniciar/salvar/concluir um atendimento telefônico'
                ],
                [
                    'permissao' => Permissao::ATENDIMENTO_ATENDIMENTO_CRIAR_EMAIL,
                    'descricao' => 'Permite iniciar/salvar/concluir um atendimento por e-mail'
                ],
                [
                    'permissao' => Permissao::ATENDIMENTO_COMENTARIO_CRIAR,
                    'descricao' => 'Permite criar um comentário em um atendimento'
                ],
                /**
                 * Auth
                 */
                [
                    'permissao' => Permissao::AUTH_PERMISSAO_CADASTRAR,
                    'descricao' => 'Permite ao usuário gerir permissões do sistema'
                ],
                [
                    'permissao' => Permissao::AUTH_USUARIO_CADASTRAR,
                    'descricao' => 'Permite ao usuário gerir usuários'
                ],
                [
                    'permissao' => Permissao::AUTH_ORGANOGRAMA_CADASTRAR,
                    'descricao' => 'Permite ao usuário gerir divisões do organograma'
                ],
                /**
                 * Correspondência
                 */
                [
                    'permissao' => Permissao::CORRESPONDENCIA_CORRESPONDENCIA_POSTAR,
                    'descricao' => 'Permite ao usuário da área de apoio gerir postagens'
                ],
                /**
                 * Demandas (Judicial)
                 */
                [
                    'permissao' => Permissao::DEMANDA_DEMANDA_CADASTRAR,
                    'descricao' => 'Permite cadastrar/editar demandas'
                ],
                [
                    'permissao' => Permissao::DEMANDA_DEMANDA_ALTERAR_RESUMO_GERENCIAL,
                    'descricao' => 'Permite ao usuário alterar o campo resumo gerencial'
                ],
                [
                    'permissao' => Permissao::DEMANDA_DEMANDA_ATENDER_DISTRIBUICAO,
                    'descricao' => 'Permite a um usuário atender distruição feita a si próprio ou ao seu núcleo'
                ],
                /**
                 * Demarcação
                 */
                [
                    'permissao' => Permissao::DEMARCACAO_DEMARCACAO_CADASTRAR,
                    'descricao' => 'Permite ao usuário gerenciar demarcações no módulo Demarcação'
                ],
                /**
                 * Patrimônio
                 */
                [
                    'permissao' => Permissao::PATRIMONIO_PATRIMONIO_CADASTRAR,
                    'descricao' => 'Permite ao usuário da área de apoio gerir bens patrimoniais'
                ],
    
            ];
            DB::table('permissao')->insertOrIgnore($registrosAInserir);
        });
    }

}
