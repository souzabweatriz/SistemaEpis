<template>
<header class="header">
    <div class="header-spacer">
        <div class="logo">
            <img src="/Image/logo.png" alt="Logo do EpiCloud" class="image-logo" />
            <p class="app-title">EPI<span class="app-title-span">Cloud</span></p>
        </div>
    </div>
    <nav class="nav">
        <router-link class="nav-link" to="/">Início</router-link>
        <router-link class="nav-link" to="/contato">Contato</router-link>
        <router-link class="nav-link" to="/sobre">Sobre</router-link>
    </nav>
    <button class="login-button" @click="router.push('/Login')">Entrar</button>
</header>
</template>

<script setup>
import { useRouter } from 'vue-router'
const router = useRouter()
</script>

<style>
:root {
    --azul-profundo-seguranca: #1A535C;
    --ciano-suave: #4ECDC4;
    --cinza-neutro-claro: #6C757D;
    --fundo-minimalista: #F4F7F6;
    --preto-tipografico: #343A40;
}

.header{
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 1rem;
    padding: 0.72rem 1.05rem;
    width: min(85%, 900px);
    height: 3.5rem;
    position: fixed;
    top: 1rem;
    left: 50%;
    transform: translateX(-50%);
    z-index: 1100;
    border-radius: 1rem;
    background: rgba(244, 247, 246, 0.76);
    box-shadow: 0 10px 24px rgba(52, 58, 64, 0.16);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
}

.image-logo{
    width: 4rem;
    height: 2.5rem;
}

.logo{
    display: flex;
    align-items: center;
    gap: 0.45rem;
}

.header-spacer {
    display: flex;
    align-items: center;
}

.app-title {
    color: var(--azul-profundo-seguranca);
    font-weight: 800;
    font-size: 1.08rem;
    line-height: 1;
}

.app-title-span {
    color: var(--preto-tipografico);
}

.nav{
    display: flex;
    gap: 1rem;
}

.nav-link {
    text-decoration: none;
    color: var(--preto-tipografico);
    font-weight: 600;
    font-size: 0.92rem;
    transition: color 0.2s ease;
}

.nav-link:hover {
    color: var(--ciano-suave);
}

.login-button {
    border: none;
    border-radius: 0.4rem;
    width: 5rem;
    height: 2rem;
    background: var(--azul-profundo-seguranca);
    color: var(--fundo-minimalista);
    font-weight: 700;
    font-size: 0.84rem;
    cursor: pointer;
    transition: background 0.2s ease, opacity 0.2s ease;
}

.login-button:hover {
    background: var(--azul-profundo-seguranca);
    opacity: 0.92;
}

@media (max-width: 760px) {
    .header {
        width: 90%;
        height: 2.5rem;
        top: 0.55rem;
        padding: 0.58rem 0.72rem;
        gap: 0.55rem;
    }

    .image-logo {
        width: 2.5rem;
        height: 1.65rem;
    }

    .app-title {
        font-size: 0.8rem;
    }

    .nav {
        gap: 0.5rem;
    }

    .nav-link {
        font-size: 0.74rem;
    }

    .login-button {
        height: 1.5rem;
        font-size: 0.68rem;
    }
}
</style>
