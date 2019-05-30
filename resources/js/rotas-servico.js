export default {
  base () {
    return '/api'
  },
  rotas () {
    return {
      autenticacao: {
        login: this.base() + '/user/login', //jwt.auth
        // login: this.base() + '/login', //auth
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
        relatorio: {
          entradaSaidaDiaria: this.base() + '/demanda/relatorio/entrada-saida-diaria',
          abertasPorSituacao: this.base() + '/demanda/relatorio/abertas-situacao',
          abertasPorDistribuicao: this.base() + '/demanda/relatorio/abertas-distribuicao',
          abertasPorDemandante: this.base() + '/demanda/relatorio/abertas-demandante'
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
      orgao: {
        listar: this.base() + '/orgao',
        criar: this.base() + '/orgao',
        editar: this.base() + '/orgao/'
      },
      tipoDocumento: {
        listar: this.base() + '/tipoDocumento'
      },
      situacaoDemanda: {
        listar: this.base() + '/situacaoDemanda'
      },
      divisaoOrganograma: {
        listar: this.base() + '/divisaoOrganograma'
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
      arquivo: {
        listar: this.base() + '/arquivo',
        upload: this.base() + '/arquivo'
      }
    }
  }
}
