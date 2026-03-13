<template>
    <div>
        <AppHeader />
    </div>
    <div class="home-container">
        <nav class="home-nav">
            <h1 class="home-title">Proteção em cada detalhe, controle em cada entrega.</h1>
            <img class="nav-image" src="/Image/Capacete.png" alt="Capacete roxo e laranja" />
        </nav>
    </div>
</template>


<script setup>
import AppHeader from '/components/Header/AppHeader.vue'
</script>

<style scoped>
.home-container{
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 2rem;
}
.home-nav {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-around;
    height: 30rem;
    background: radial-gradient(
    circle at center,
    #f0eef1 0%,
    #e6ddea 45%,
    #c4b1ce 100%
);

}
.home-title{
    max-width: 25rem;
    font-size: 3.4rem;
    background: linear-gradient(190deg, #3A004F 0%, #3A004F 20%, #F25D27 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}
.nav-image{
    display: flex;
    width: 30rem;
    height: 20rem;
}
</style>

<script>
export default {
    name: 'Home'
}
</script>