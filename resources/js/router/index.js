import Vue from 'vue'
import Router from 'vue-router'
import Home from './../components/Home'
import Login from './../components/Login'
import PainelJudiciais from './../components/judicial/PainelJudiciais'
import DemandaCrud from './../components/judicial/Demanda'
import AutorDemandaCrud from './../components/judicial/Demandante'
import OrgaoCrud from './../components/judicial/Orgao'
import ProcedimentoExternoCrud from './../components/judicial/ProcedimentoExterno'
import Atendimento from './../components/atendimento/Atendimento'
import Governanca from './../components/governanca/Governanca'
import Conteudo from './../components/Conteudo'
import GeoVisualizador from './../components/geo/GeoVisualizador'
import Usuario from './../components/permissoes/Usuario'
import Perfil from './../components/permissoes/Perfil'
import Organograma from './../components/permissoes/Organograma'
// import FileUpload from './../components/FileUpload'
import store from './../store'

Vue.use(Router)

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
        guest: true,
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
      path: '/geo',
      name: 'Geo',
      component: GeoVisualizador,
      meta: {
        guest: true,
        breadcrumb: [
          {
            text: 'Início',
            href: '/#/'
          },
          {
            text: 'Geovisualizador',
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