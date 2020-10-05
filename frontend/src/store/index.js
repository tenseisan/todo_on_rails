import Vue from "vue";
import Vuex from "vuex";
import createPersistedState from "vuex-persistedstate";
Vue.use(Vuex);

export const store = new Vuex.Store({ plugins: [createPersistedState({
        storage: window.sessionStorage,
    })],
    state: {
        currentUser: {},
        credentials: {},
        signedIn: false
    },
    mutations: {
        setCurrentUser(state, payload) {
            state.currentUser = payload.user;
            state.credentials = payload.credentials;
            state.signedIn = true
        },
        unsetCurrentUser(state) {
            state.currentUser = {};
            state.credentials = {};
            state.signedIn = false
        },
    }
});

export default store;