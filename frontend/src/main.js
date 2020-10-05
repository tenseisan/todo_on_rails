import '@mdi/font/css/materialdesignicons.css'
import Vue from 'vue'
import App from './App.vue'
import router from './router/index'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import Notifications from "vt-notifications";
import store from './store/index'


import ApolloClient from "apollo-boost";
import VueApollo from "vue-apollo";
import i18n from './i18n'

const credentials = store.state.credentials;
const headers = {
  "uid": credentials.uid,
  "client": credentials.client,
  "token-type": credentials.tokenType,
  "expiry": credentials.expiry,
  "access-token": credentials.accessToken
}

const client = new ApolloClient({
  uri: "http://localhost:3000/graphql",
  headers: headers
});

const auth = new ApolloClient({
  uri: "http://localhost:3000/graphql_auth",
  headers: headers
});

const apolloProvider = new VueApollo({
  clients: {
    client,
    auth
  },
  defaultClient: client
});

Vue.use(VueApollo);
Vue.use(Vuetify);
Vue.use(Notifications);

Vue.config.productionTip = false;

new Vue({
  store,
  vuetify : new Vuetify(),
  apolloProvider,
  router,
  i18n,
  render: h => h(App)
}).$mount('#app')
