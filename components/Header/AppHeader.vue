<template>
<header class="header">
    <div class="header-content">
    <div class="header-spacer">
    <img src="/Image/EpiCloudLogo.png" alt="Logo do EpiCloud" class="logo" />
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

<style scoped src="./AppHeader.css"></style>
