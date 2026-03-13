import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'


const routes = [
    { 
        path: '/', 
        name: 'home',
        component: Home 
    },
    { 
        path: '/login', 
        name: 'login',
        alias: '/Login',
        component: () => import('../views/Login.vue') 
    },
    { 
        path: '/cadastro', 
        name: 'cadastro',
        alias: '/Cadastro',
        component: () => import('../views/Cadastro.vue') 
    },
    {
        path: '/epis',
        name: 'epis',
        alias: '/EPIs',
        component: () => import('../views/EPIs.vue')
    },
    {
        path: '/setores',
        name: 'setores',
        alias: ['/Setores', '/setors', '/Setors'],
        component: () => import('../views/Setores.vue')
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router