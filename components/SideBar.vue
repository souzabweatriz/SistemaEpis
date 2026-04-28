<template>
    <div class="sidebar">
        <aside class="sidebar">
            <h1 class="logo">
                <i class="fas fa-shield-alt"></i>
                EPICloud
            </h1>
            <nav class="menu">
                <RouterLink to="/dashboard/funcionario" class="menu-item" active-class="active">
                    <i class="fas fa-users"></i>
                    <span>Funcionários</span>
                </RouterLink>
                <RouterLink to="/dashboard/entregas" class="menu-item" active-class="active">
                    <i class="fas fa-box"></i>
                    <span>Entregas de EPI</span>
                </RouterLink>
                <RouterLink to="/dashboard/relatorio" class="menu-item" active-class="active">
                    <i class="fas fa-chart-bar"></i>
                    <span>Relatório</span>
                </RouterLink>
                <RouterLink to="/dashboard/cadastro" class="menu-item" active-class="active">
                    <i class="fas fa-shield-alt"></i>
                    <span>Cadastro de EPI</span>
                </RouterLink>
            </nav>
            <button @click="sair" class="botao-sair">
                <i class="fas fa-sign-out-alt"></i>
                <span>Sair</span>
            </button>
        </aside>

    </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useSupabase } from '../src/composables/useSupabase'

const router = useRouter()
const { supabase } = useSupabase()

async function sair() {
    try {
        await supabase.auth.signOut()
        router.push('/login')
    } catch (error) {
        console.error('Erro ao sair:', error)
    }
}
</script>

<style scoped>
.sidebar {
    width: 100%;
}

.sidebar>.sidebar {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    gap: 1.5rem;
    width: min(100%, 18rem);
    min-height: calc(100vh - 2rem);
    padding: 1.5rem 1.25rem;
    border: 1px solid rgba(18, 55, 82, 0.08);
    border-radius: 1.5rem;
    background:
        linear-gradient(180deg, rgba(255, 255, 255, 0.92) 0%, rgba(243, 248, 252, 0.92) 100%);
    box-shadow: 0 18px 40px rgba(18, 55, 82, 0.12);
    backdrop-filter: blur(14px);
    -webkit-backdrop-filter: blur(14px);
}

.logo {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    margin-bottom: 0.25rem;
    color: var(--text-main);
    font-size: 1.05rem;
    font-weight: 800;
    letter-spacing: 0.01em;
}

.logo i {
    display: grid;
    place-items: center;
    width: 2.6rem;
    height: 2.6rem;
    border-radius: 0.9rem;
    background: linear-gradient(135deg, #123752, #2b8ac8);
    color: #fff;
    box-shadow: 0 10px 22px rgba(18, 55, 82, 0.22);
}

.menu {
    display: flex;
    flex-direction: column;
    gap: 0.65rem;
    flex: 1;
}

.menu-item {
    display: flex;
    align-items: center;
    gap: 0.85rem;
    padding: 0.95rem 1rem;
    border-radius: 1rem;
    text-decoration: none;
    color: var(--text-soft);
    font-weight: 700;
    font-size: 0.95rem;
    line-height: 1;
    background: transparent;
    transition:
        background-color 0.22s ease,
        color 0.22s ease,
        transform 0.22s ease,
        box-shadow 0.22s ease;
}

.menu-item i {
    width: 1.2rem;
    text-align: center;
    font-size: 1rem;
}

.menu-item:hover {
    color: var(--text-main);
    background: rgba(43, 138, 200, 0.08);
    transform: translateX(0.18rem);
}

.menu-item.active,
.menu-item.router-link-active {
    color: #fff;
    background: linear-gradient(135deg, #123752, #2b8ac8);
    box-shadow: 0 12px 24px rgba(18, 55, 82, 0.18);
}

.botao-sair {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 0.75rem;
    width: 100%;
    margin-top: auto;
    padding: 0.95rem 1rem;
    border: 1px solid rgba(18, 55, 82, 0.12);
    border-radius: 1rem;
    background: rgba(255, 255, 255, 0.72);
    color: #a63b3b;
    font-weight: 800;
    font-size: 0.95rem;
    cursor: pointer;
    transition:
        transform 0.22s ease,
        background-color 0.22s ease,
        box-shadow 0.22s ease,
        color 0.22s ease;
}

.botao-sair:hover {
    background: rgba(166, 59, 59, 0.08);
    color: #8e2f2f;
    transform: translateY(-1px);
    box-shadow: 0 10px 20px rgba(18, 55, 82, 0.1);
}

.botao-sair i {
    font-size: 0.98rem;
}

@media (max-width: 900px) {
    .sidebar>.sidebar {
        width: 100%;
        min-height: calc(100vh - 1.6rem);
        padding: 1rem 0.8rem;
    }
}

@media (max-width: 640px) {
    .sidebar>.sidebar {
        border-radius: 1rem;
        padding: 0.8rem 0.45rem;
        gap: 0.8rem;
        align-items: center;
    }

    .logo {
        justify-content: center;
        font-size: 0;
        margin-bottom: 0;
    }

    .logo i {
        width: 2.1rem;
        height: 2.1rem;
        border-radius: 0.7rem;
        margin: 0;
    }

    .menu {
        width: 100%;
        align-items: center;
    }

    .menu-item {
        width: 2.8rem;
        height: 2.8rem;
        justify-content: center;
        padding: 0;
        border-radius: 0.75rem;
        gap: 0;
    }

    .menu-item span {
        display: none;
    }

    .menu-item i {
        width: auto;
        font-size: 1.05rem;
    }

    .botao-sair {
        width: 2.8rem;
        height: 2.8rem;
        padding: 0;
        border-radius: 0.75rem;
        font-size: 0;
        justify-content: center;
    }

    .botao-sair span {
        display: none;
    }

    .botao-sair i {
        font-size: 1rem;
    }
}
</style>