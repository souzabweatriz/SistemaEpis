import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import { useSupabase } from '../composables/useSupabase.js'
import Dashboard from '../views/Dashboard.vue'
import CadastroFunc from '../views/CadastroFunc.vue'
import EPIs from '../views/EPIs.vue'
import Setores from '../views/Setores.vue'
import Sobre from '../views/Sobre.vue'
import CadastroEpi from '../views/CadastroEpi.vue'


const { supabase } = useSupabase()

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
        component: () => import('../views/CadastroFunc.vue')
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
        component: () => import('../views/Setores.vue'),
        meta: { requiresAuth: true }
    },
    {
        path: '/sobre',
        name: 'sobre',
        alias: '/Sobre',
        component: Sobre
    },
    {
        path: '/dashboard',
        name: 'dashboard',
        alias: '/Dashboard',
        component: Dashboard,
        meta: { requiresAuth: true },

        children: [
            { path: '', redirect: '/dashboard/funcionario' },
            { path: 'entregas', name: 'entregas', component: EPIs },
            { path: 'relatorio', name: 'relatorio', component: Setores },
            { path: 'cadastro', name: 'cadastroEpi', component: CadastroEpi },
            { path: 'funcionario', name: 'funcionario', component: CadastroFunc }
        ]
    }
]

const router = createRouter({ history: createWebHistory(), routes })

router.beforeEach(async (to) => {
    const requiresAuth = to.matched.some(r => r.meta.requiresAuth)
    const { data: { session } } = await supabase.auth.getSession()

    if (requiresAuth && !session) {
        return '/login'
    }

    return true
})

export default router