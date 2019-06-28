import Vue from 'vue'
import Router from 'vue-router'
import Home from './../components/Home'
import Login from './../components/Login'
import PainelJudiciais from './../components/PainelJudiciais'
import DemandaCrud from './../components/DemandaCrud'
import AutorDemandaCrud from './../components/AutorDemandaCrud'
import OrgaoCrud from './../components/OrgaoCrud'
import ProcedimentoExternoCrud from './../components/ProcedimentoExternoCrud'
import Conteudo from './../components/Conteudo'
import GeoReferenciamento from './../components/GeoReferenciamento'
import FileUpload from './../components/FileUpload'
import store from './../store'

Vue.use(Router)

let router = new Router({
  routes: [
    {
      path: '/',
      name: 'Inicio',
      component: PainelJudiciais
    },
    {
      path: '/login',
      name: 'Login',
      component: Login,
      meta: {
        guest: true
      }
    },
    {
      path: '/conteudo/:id',
      name: 'Conteudo',
      component: Conteudo,
      meta: {
        requiresAuth: true,
      }            
    },
    {
      path: '/nujuc',
      name: 'Nujuc',
      component: PainelJudiciais
    },
    {
      path: '/demanda',
      name: 'Demanda',
      component: DemandaCrud,
      meta: {
        requiresAuth: true,
      }
    },
    {
      path: '/demanda/:id',
      name: 'DemandaEditor',
      component: DemandaCrud,
      meta: {
        requiresAuth: true,
      }
    },
    {
      path: '/demandante',
      name: 'Demandante',
      component: AutorDemandaCrud,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/orgao',
      name: 'Orgao',
      component: OrgaoCrud,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/procedimento',
      name: 'ProcedimentoExterno',
      component: ProcedimentoExternoCrud,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/geo',
      name: 'Geo',
      component: GeoReferenciamento,
      meta: {
        guest: true
      }
    },

    {
      path: '/arquivo',
      name: 'Arquivo',
      component: FileUpload,
      meta: {
        guest: true
      }
    }
  ]
})

router.beforeEach((to, from, next) => {
  let tokenArmazenado = store.getters['auth/token']
  // console.log(tokenArmazenado)

  if(to.matched.some(record => record.meta.requiresAuth)) {

    if(tokenArmazenado == null) {
      next({
        path: '/login',
        params: { nextUrl: to.fullPath }
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
