/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');

import VueResource from 'vue-resource'
window.Vue.use(VueResource)

import router from './router'
import store from './store'

import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import 'material-icons'
import '@mdi/font/css/materialdesignicons.css' 
window.Vue.use(Vuetify)

// import CKEditor from '@ckeditor/ckeditor5-vue';
// window.Vue.use( CKEditor );

/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

const files = require.context('./', true, /\.vue$/i)
files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default))

const moduleVueFiles = require.context('../../Modules', true, /\.vue$/i);
moduleVueFiles.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], moduleVueFiles(key).default));
// Vue.component('example-component', require('./components/ExampleComponent.vue').default);

Vue.http.interceptors.push((request) => {
    // console.log(request)
    let token = store.getters['auth/token']
    request.headers.set('Accept', 'application/json')
    request.headers.set('Authorization', 'Bearer ' + token)

    request.headers.set('X-CSRF-TOKEN', $('meta[name="csrf-token"]').attr('content'));
  
    return function(response) {
      if(response.headers.get('authorization') != null) {
        let newToken = response.headers.get('authorization');
        newToken = newToken.substring("Bearer ".length)
        // console.log('Atualizando o token para: ' + newToken) // 'Bearer '
        store.commit('auth/setToken', newToken)
      }
      
      switch (response.status) {
        case 401:
          store.commit('auth/sair', null)
          break;
  
        case 501:
          this.$store.commit('sistema/alerta', 'O serviço da aplicação está indisponível')
          break;
  
        case 503:
          this.$store.commit('sistema/alerta', 'Ocorreu um erro interno no serviço da aplicação')
          break;
      
        default:
          break;
      }
      
      return response;
    }
  })

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */
const app = new Vue({
    icons: {
      iconfont: 'mdi'
    },
    el: '#app',
    vuetify: new Vuetify(),
    router,
    store,
    components: {
      'spu-menu': require('./components/layout/Menu')
    }
});