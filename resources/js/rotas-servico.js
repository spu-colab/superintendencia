export default {
  base () {
    return '/api'
  },
  rotas () {
    return {
      atendimento: {
        listar: this.base() + '/atendimento',
        criar: this.base() + '/atendimento',
        editar: this.base() + '/atendimento/',
        assunto: {
          listar: this.base() + '/atendimento/assunto',
        },
        comentario: {
          criar: this.base() + '/atendimento/comentario',
        }
      },

      demarcacao: {
        listar: this.base() + '/demarcacao/demarcacao',
        criar: this.base() + '/demarcacao/demarcacao',
        editar: this.base() + '/demarcacao/demarcacao/',
        tipo: {
          listar: this.base() + '/demarcacao/tipo'
        },
        situacao: {
          listar: this.base() + '/demarcacao/situacao'
        },
        trecho: {
          listar: this.base() + '/demarcacao/trecho'
        },
      },

      autenticacao: {
        login: this.base() + '/user/login', //jwt.auth
        recuperarSenha: '/password/email',
        refresh: this.base() + '/user/refresh'
      },
      
      demanda: {
        listar: this.base() + '/demanda',
        listarPorProcedimentoExterno: this.base() + '/demanda/procedimento/',
        criar: this.base() + '/demanda',
        editar: this.base() + '/demanda/',
        obter: this.base() + '/demanda/',
        consultar: this.base() + '/demanda/',
        cancelar: this.base() + '/demanda/cancelar',
        resolver: this.base() + '/demanda/resolver',
        aguardarAssinatura: this.base() + '/demanda/aguardar-assinatura',
        aguardarAR: this.base() + '/demanda/aguardar-AR',
        entidadeAtribuivel: this.base() + '/demanda/entidadeAtribuivel',
        distribuicao: this.base() + '/demanda/distribuicao',
        pdf: this.base() + '/demanda/pdf/',
        relatorio: {
          entradaSaidaDiaria: this.base() + '/demanda/relatorio/entrada-saida-diaria',
          abertasPorNaturezaOrgao: this.base() + '/demanda/relatorio/abertas-natureza',
          abertasPorSituacao: this.base() + '/demanda/relatorio/estatistica-periodo',
          abertasPorDistribuicao: this.base() + '/demanda/relatorio/abertas-distribuicao',
          abertasPorDemandante: this.base() + '/demanda/relatorio/abertas-demandante',
          abertasPorDivisaoOrganograma: this.base() + '/demanda/relatorio/acompanhamento',
        }
      },
      
      autorDemanda: {
        listar: this.base() + '/autorDemanda',
        criar: this.base() + '/autorDemanda',
        editar: this.base() + '/autorDemanda/',
      },
      
      cargo: {
        listar: this.base() + '/cargo',
        criar: this.base() + '/cargo',
        editar: this.base() + '/cargo/'
      },
      
      geo: {
        camada: {
          listar: this.base() + '/geo/camada',
          referencia: {
            listar: this.base() + '/geo/camada/[idCamada]/referencia',
            obter: this.base() + '/geo/camada/[tabelaReferenciaCamada]/referencia/[idReferenciado]',
            criar: this.base() + '/geo/referencia',
            editar: this.base() + '/geo/referencia/',
          }
        }
      },
      
      orgao: {
        listar: this.base() + '/orgao',
        listarNaturezas: this.base() + '/natureza-orgao',
        criar: this.base() + '/orgao',
        editar: this.base() + '/orgao/'
      },
      
      tipoDocumento: {
        listar: this.base() + '/tipoDocumento'
        
      },
      situacaoDemanda: {
        listar: this.base() + '/situacaoDemanda'
      },
      
      procedimentoExterno: {
        listar: this.base() + '/procedimentoExterno',
        buscar: this.base() + '/procedimentoExterno/',
        criar: this.base() + '/procedimentoExterno',
        editar: this.base() + '/procedimentoExterno/'
      },

      tipoProcedimentoExterno: {
        listar: this.base() + '/tipoProcedimentoExterno'
      },

      poloProcedimentoExterno: {
        listar: this.base() + '/poloProcedimentoExterno'
      },

      /* ---- CONFIGURAÇÔES ---- */

      usuario: {
        listar: this.base() + '/usuario',
        criar: this.base() + '/usuario',
        editar: this.base() + '/usuario/',
      },
      
      permissao: {
        listar: this.base() + '/permissao',
        criar: this.base() + '/permissao',
        editar: this.base() + '/permissao/',
        usuario: this.base() + '/permissao/usuario/[permissao]'
      },
      correspondencia: {
        listar: this.base() + '/correspondencia',
        setores: this.base() + '/correspondencia/setores',
        tipos: this.base() + '/correspondencia/tipos',
        logradouros: this.base() + '/correspondencia/logradouros',
        pesquisaMunicipio: this.base() + '/correspondencia/pesquisaMunicipio',
        autocomplete:this.base() + '/correspondencia/autocomplete',
        descartaCorresp: this.base() + '/correspondencia/descartaCorresp/',
        descartaDest: this.base() + '/correspondencia/descartaDest/',
        criarDestinatario: this.base() + '/correspondencia/criarDestinatario',
        criarCorrespondencia: this.base() + '/correspondencia/criarCorrespondencia', 
        inserirLista: this.base() + '/correspondencia/inserirLista',
        postagem: this.base() + '/correspondencia/postagem/', 
        gerarLista:this.base() + '/correspondencia/gerarLista', 
        gerarEtiqueta: this.base() + '/correspondencia/gerarEtiqueta/',
        concluirLista: this.base() + '/correspondencia/concluirLista',
        receberAR:this.base() + '/correspondencia/receberAR/',
        descartaDest: this.base() + '/correspondencia/descartaDest/',
        descartarDestLista:this.base() + '/correspondencia/descartarDestLista/',
      },      
      organograma: {
        listar: this.base() + '/divisao-organograma',
        criar: this.base() + '/divisao-organograma',
        editar: this.base() + '/divisao-organograma/',
      },
      

      /*
      
      arquivo: {
        listar: this.base() + '/arquivo',
        upload: this.base() + '/arquivo'
      },
      
      conteudo: {
        consultar: this.base() + '/conteudo/',
        criar: this.base() + '/conteudo',
        editar: this.base() + '/conteudo/',
        upload: ':8000/ckfinder/connector?command=QuickUpload&type=Images&responseType=json'
      },

      */

    }
  }
}
