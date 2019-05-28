export default {
  base () {
    return ''
  },
  rotas () {
    return {
      autenticacao: {
        login: this.base() + '/api/user/login',
        refresh: this.base() + '/api/user/refresh'
      },
      demanda: {
        listar: this.base() + '/api/demanda',
        listarPorProcedimentoExterno: this.base() + '/api/demanda/procedimento/',
        criar: this.base() + '/api/demanda',
        editar: this.base() + '/api/demanda/',
        obter: this.base() + '/api/demanda/',
        consultar: this.base() + '/api/demanda/',
        cancelar: this.base() + '/api/demanda/cancelar',
        resolver: this.base() + '/api/demanda/resolver',
        aguardarAssinatura: this.base() + '/api/demanda/aguardar-assinatura',
        aguardarAR: this.base() + '/api/demanda/aguardar-AR',
        entidadeAtribuivel: this.base() + '/api/demanda/entidadeAtribuivel',
        distribuicao: this.base() + '/api/demanda/distribuicao',
        relatorio: {
          entradaSaidaDiaria: this.base() + '/api/demanda/relatorio/entrada-saida-diaria',
          abertasPorSituacao: this.base() + '/api/demanda/relatorio/abertas-situacao',
          abertasPorDistribuicao: this.base() + '/api/demanda/relatorio/abertas-distribuicao',
          abertasPorDemandante: this.base() + '/api/demanda/relatorio/abertas-demandante'
        }
      },
      autorDemanda: {
        listar: this.base() + '/api/autorDemanda',
        criar: this.base() + '/api/autorDemanda',
        editar: this.base() + '/api/autorDemanda/',
      },
      cargo: {
        listar: this.base() + '/api/cargo',
        criar: this.base() + '/api/cargo',
        editar: this.base() + '/api/cargo/'
      },
      orgao: {
        listar: this.base() + '/api/orgao',
        criar: this.base() + '/api/orgao',
        editar: this.base() + '/api/orgao/'
      },
      tipoDocumento: {
        listar: this.base() + '/api/tipoDocumento'
      },
      situacaoDemanda: {
        listar: this.base() + '/api/situacaoDemanda'
      },
      divisaoOrganograma: {
        listar: this.base() + '/api/divisaoOrganograma'
      },
      procedimentoExterno: {
        listar: this.base() + '/api/procedimentoExterno',
        buscar: this.base() + '/api/procedimentoExterno/',
        criar: this.base() + '/api/procedimentoExterno',
        editar: this.base() + '/api/procedimentoExterno/'
      },
      tipoProcedimentoExterno: {
        listar: this.base() + '/api/tipoProcedimentoExterno'
      },
      poloProcedimentoExterno: {
        listar: this.base() + '/api/poloProcedimentoExterno'
      },
      arquivo: {
        listar: this.base() + '/api/arquivo',
        upload: this.base() + '/api/arquivo'
      }
    }
  }
}
