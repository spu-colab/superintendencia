import Vue from 'vue'
import Router from 'vue-router'
import Home from './../components/Home'
import Login from './../components/Login'
import DemandaCRUD from './../components/DemandaCRUD'
import AutorDemandaCRUD from './../components/AutorDemandaCRUD'
import OrgaoCRUD from './../components/OrgaoCRUD'
import ProcedimentoExternoCRUD from './../components/ProcedimentoExternoCRUD'
import GeoReferenciamento from './../components/GeoReferenciamento'
import FileUpload from './../components/FileUpload'
import store from './../store'

Vue.use(Router)

let router = new Router({
  routes: [
    {
      path: '/',
      name: 'Inicio',
      component: Home
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
      path: '/demanda',
      name: 'Demanda',
      component: DemandaCRUD,
      meta: {
        requiresAuth: true,
      }
    },
    {
      path: '/demanda/:id',
      name: 'DemandaEditor',
      component: DemandaCRUD,
      meta: {
        requiresAuth: true,
      }
    },
    {
      path: '/demandante',
      name: 'Demandante',
      component: AutorDemandaCRUD,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/orgao',
      name: 'Orgao',
      component: OrgaoCRUD,
      meta: {
        requiresAuth: true
      }
    },
    {
      path: '/procedimento',
      name: 'ProcedimentoExterno',
      component: ProcedimentoExternoCRUD,
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
