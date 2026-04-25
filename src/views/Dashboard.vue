<template>
    <main class="dashboard-layout">
        <SideBar class="dashboard-sidebar" />
        <section class="dashboard-content">
            <RouterView />
        </section>
    </main>
</template>

<script setup>
import { RouterView } from 'vue-router'
import SideBar from '../../components/SideBar.vue'
</script>

<style scoped>
.dashboard-layout {
    width: 100%;
    min-height: 100vh;
    display: grid;
    grid-template-columns: 19rem 1fr;
    gap: 1.2rem;
    padding: 1rem;
    background: #f3f8fc;
}

.dashboard-content {
    height: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
}

@media (max-width: 1024px) {
    .dashboard-layout {
        grid-template-columns: 14rem 1fr;
        gap: 0.9rem;
        padding: 0.8rem;
    }
}

@media (max-width: 640px) {
    .dashboard-layout {
        grid-template-columns: 5.2rem 1fr;
        gap: 0.6rem;
        padding: 0.5rem;
    }
}
</style>
