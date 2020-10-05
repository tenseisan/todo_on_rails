import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '../store'

Vue.use(VueRouter);

const routes = [
    {
        path: '/',
        name: 'Home',
        components: {
            default: () => import('../../views/Home.vue')
        },
        meta: { requireGuest: true }
    },
    {
        path: '/signup',
        name: 'SignUp',
        components: {
            default: () => import('../../views/auth/Signup.vue')
        },
        meta: { requireGuest: true }
    },
    {
        path: '/signout',
        name: 'SignOut',
        meta: { requireAuth: true }
    },
    {
        path: '/task_list',
        name: 'taskList',
        components: {
            default: () => import('../../views/task_list/Index.vue')
        },
        meta: { requireAuth: true }
    },
    {
        path: '*',
        components: {
            default: () => import('../../views/PageNotFound.vue')
        }
    }
];

const router = new VueRouter({
    mode: 'history',
    routes
});

router.beforeEach((to, from, next) => {
    const userSignedIn = store.state.signedIn;

    if (to.matched.some((record) => record.meta.requireAuth) && !userSignedIn) {
        next('/') }
    else if (to.matched.some((record) => record.meta.requireGuest) && userSignedIn) {
        next('/task_list') }
    else {
        next() }
});

export default router