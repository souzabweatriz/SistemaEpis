<template>
<header class="header">
    <div class="header-content">
    <div class="header-spacer">
    <img src="/Image/epicloud.png" alt="Logo do EpiCloud" class="logo" />
    <p class="app-title">EPI<span class="app-title-span">Cloud</span></p>
    </div>
    <nav class="nav">
        <router-link class="nav-link" to="/">Home</router-link>
        <router-link class="nav-link" to="/setores">Setores</router-link>
        <router-link class="nav-link" to="/epis">EPIs</router-link>
        <router-link class="nav-link" to="/sobre">Sobre</router-link>
    </nav>
    <button class="login-button" @click="router.push('/login')">Entrar</button>
    </div>
</header>
</template>

<script setup>
import { useRouter } from 'vue-router'
const router = useRouter()
</script>

<style>
@import url("https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap");
.header {
    box-shadow:
        5px 5px 10px #d9d9d9,
        -5px -5px 10px #ffffff;
    width: 100%;
    height: 7rem;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    position: sticky;
    top: 0;
    z-index: 1000;
    background-color: #000000;
    display: flex;
    justify-content: center;
    align-items: center;
}

.logo {
    width: 8rem;
    height: 8rem;
}

.header-spacer {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.app-title{
    font-size: 1.5rem;
    color: #E1D3E3;
    font-weight: bolder;
}

.app-title-span {
    color: #ffffff;
    font-weight: 500;
}

.header-content {
    display: flex;
    align-items: center;
    justify-content: space-around;
}

.nav{
    display: flex;
    align-items: center;
    gap: 2rem;
}

.nav-link {
    text-decoration: none;
    color: rgb(255, 255, 255);
    font-size: 1rem;
    font-weight: 500;
    margin-right: 1rem;
}

.nav-link:hover {
    color: rgb(212, 193, 219);
}

.login-button{
    font-weight: 500;
    width: 8rem;
    height: 3rem;
    border-radius: 1rem;
    background: linear-gradient(90deg, #E1D3E3 0%, #E1D3E3 40%, #7C747D 100%);
    background-size: 200% 200%;
    background-position: 0% 50%;
    border: none;
    color: black;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.341);
    cursor: pointer;
    transition: transform 0.2s ease;
}

.login-button:hover {
    animation: gradientMove 2s linear infinite;
    transform: translateY(-1px);
}

@keyframes gradientMove {
    0% {
        background-position: 0% 50%;
    }
    50% {
        background-position: 100% 50%;
    }
    100% {
        background-position: 0% 50%;
    }
}</style>
