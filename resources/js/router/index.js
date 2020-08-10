import Vue from 'vue'
import money from 'v-money'
import Router from 'vue-router'
import Home from './../components/Home'
import Login from './../components/Login'
import RecuperarSenha from './../components/RecuperarSenha'
import PainelJudiciais from './../components/judicial/PainelJudiciais'
import DemandaCrud from './../components/judicial/Demanda'
import AutorDemandaCrud from './../components/judicial/Demandante'
import OrgaoCrud from './../components/judicial/Orgao'
import ProcedimentoExternoCrud from './../components/judicial/ProcedimentoExterno'
import Atendimento from './../components/atendimento/Atendimento'
import Demarcacao from './../components/demarcacao/Demarcacao'
import Governanca from './../components/governanca/Governanca'
import Conteudo from './../components/Conteudo'
import Usuario from './../components/permissoes/Usuario'
import Perfil from './../components/permissoes/Perfil'
import Correspondencia  from './../components/correspondencia/Correspondencia'

// Patrimonio
import Patrimonio       from './../components/patrimonio/Patrimonio'
import Locais       from './../components/patrimonio/Localizacao'
import Organograma from './../components/permissoes/Organograma'

// GEO
import GeoVisualizador from './../../../Modules/Geo/Resources/assets/js/GeoVisualizador'
import GeoCamada from './../../../Modules/Geo/Resources/assets/js/GeoCamada'

// Laboratório
import Laboratorio from './../components/Laboratorio'

import store from './../store'

Vue.use(Router)
Vue.use(money, {precision: 4})
let router = new Router({
  routes: [
    {
      path: '/',
      name: 'Inicio',
      component: Home,
      meta: {
        breadcrumb: [
          {
            text: 'Início'
          }
        ]
      }
    },
    {
      path: '/login',
      name: 'Login',
      component: Login,
      meta: {
        guest: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Login'
          },
        ]
      }
    },
    {
      path: '/recuperar-senha',
      name: 'RecuperarSenha',
      component: RecuperarSenha,
      meta: {
        guest: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Recuperar Senha'
          },
        ]
      }
    },
    {
      path: '/atendimento',
      name: 'Atendimento',
      component: Atendimento,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Atendimento'
          },
        ]
      }
    },
    {
      path: '/demarcacao',
      name: 'Demarcacao',
      component: Demarcacao,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Demarcação'
          },
        ]
      }
    },
    {
      path: '/demarcacao/:id',
      name: 'DemarcacaoEditor',
      component: Demarcacao,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Demarcação'
          }
        ]
      }
    },
    {
      path: '/conteudo/:id',
      name: 'Conteudo',
      component: Conteudo,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Conteúdo'
          },
        ]
      }            
    },
    {
      path: '/nujuc',
      name: 'Nujuc',
      component: PainelJudiciais,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Demandas Judiciais'
          },
        ]
      }
    },
    {
      path: '/demanda',
      name: 'Demanda',
      component: DemandaCrud,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Demandas Judiciais',
            href: '/#/nujuc'
          },
          {
            text: 'Demandas'
          },
        ]
      }
    },
    {
      path: '/demanda/:id',
      name: 'DemandaEditor',
      component: DemandaCrud,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Demandas Judiciais',
            href: '/#/nujuc'
          },
          {
            text: 'Demanda'
          },
        ]
      }
    },
    {
      path: '/demandante',
      name: 'Demandante',
      component: AutorDemandaCrud,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Demandas Judiciais',
            href: '/#/nujuc'
          },
          {
            text: 'Demandantes'
          },
        ]
      }
    },
    {
      path: '/orgao',
      name: 'Orgao',
      component: OrgaoCrud,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Demandas Judiciais',
            href: '/#/nujuc'
          },
          {
            text: 'Órgãos'
          },
        ]
      }
    },
    
    {
      path: '/governanca',
      name: 'Governança',
      component: Governanca,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Governança'
          },
        ]
      }
    },
    {
      path: '/procedimento',
      name: 'ProcedimentoExterno',
      component: ProcedimentoExternoCrud,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Demandas Judiciais',
            href: '/#/nujuc'
          },
          {
            text: 'Procedimentos Externos'
          },
        ]
      }
    },
    {
      path: '/procedimento/:id',
      name: 'ProcedimentoExternoEditor',
      component: ProcedimentoExternoCrud,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Demandas Judiciais',
            href: '/#/nujuc'
          },
          {
            text: 'Procedimentos Externos'
          },
        ]
      }
    },
    {
      path: '/geo/visualizador',
      name: 'GeoVisualizador',
      component: GeoVisualizador,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Geo Informação',
          },
          {
            text: 'Visualizador',
          }
        ]
      }
    },
    {
      path: '/geo/camadas',
      name: 'GeoCamadas',
      component: GeoCamada,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Geo Informação',
          },
          {
            text: 'Camadas',
          }
        ]
      }
    },
    {
      path: '/permissao',
      name: 'Usuário',
      component: Usuario,
      meta: {
        guest: false,
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Usuário',
          }
        ]
      }
    },

    {
      path: '/perfil',
      name: 'Perfil',
      component: Perfil,
      meta: {
        guest: false,
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Permissão',
          }
        ]
      }
    },

    {
      path: '/correspondencia',
      name: 'Correspondência',
      component: Correspondencia,
      meta: {
        guest: false,
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Correspondência',
          }
        ]
      }
    },
    {
      path: '/patrimonio',
      name: 'Patrimônio',
      component: Patrimonio,
      meta: {
        guest: false,
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Patrimônio',
          }
        ]
      }
    },
    {
    path: '/locais',
    name: 'Local',
    component: Locais,
    meta: {
      guest: false,
      requiresAuth: true,
      breadcrumb: [
        {
          text: 'Início',
          href: '/#/'
        },
        {
          text: 'Locais',
        }
      ]
    }
  },

    {
      path: '/organograma',
      name: 'Organograma',
      component: Organograma,
      meta: {
        guest: false,
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Divisões/Organograma',
          }
        ]
      }
    },
    {
      path: '/lab',
      name: 'Laboratorio',
      component: Laboratorio,
      meta: {
        requiresAuth: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Laboratório'
          },
        ]
      }
    },
    /*
    {
      path: '/arquivo',
      name: 'Arquivo',
      component: FileUpload,
      meta: {
        guest: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Arquivo (teste)'
          },
        ]
      }
    }
    */
  ]
})

router.beforeEach((to, from, next) => {
  let tokenArmazenado = store.getters['auth/token']

  if(to.matched.some(record => record.meta.requiresAuth)) {
    if(tokenArmazenado == null) {
      next({
        path: '/login',
        query: {
          redirect: to.fullPath
        }
      })
    } else {
      next()
    }

  } else if(to.matched.some(record => record.meta.guest)) {
      next()
  } else {
    next()
  }
})

export default router