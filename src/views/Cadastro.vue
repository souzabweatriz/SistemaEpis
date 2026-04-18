<template>
    <main class="auth-page">
        <section class="auth-card">
            <p class="eyebrow">Primeiro acesso</p>
            <h1>Criar conta</h1>
            <p class="subtitle">Cadastre seu usuario para iniciar a gestao de EPIs em poucos passos.</p>

            <form class="auth-form" @submit.prevent="register">
                <label>
                    E-mail
                    <input v-model="email" type="email" placeholder="seuemail@empresa.com" required />
                </label>

                <label>
                    Senha
                    <input v-model="password" type="password" placeholder="Minimo 6 caracteres" required minlength="6" />
                </label>

                <button type="submit" :disabled="loading">
                    {{ loading ? 'Criando conta...' : 'Cadastrar' }}
                </button>
            </form>

            <p v-if="message" class="status-message">{{ message }}</p>

            <p class="cta-register">
                Ja possui cadastro?
                <button type="button" class="link-button" @click="router.push('/login')">Entrar</button>
            </p>
        </section>
    </main>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useSupabase } from '../composables/useSupabase.js'

const { supabase } = useSupabase()

const router = useRouter()
const email = ref('')
const password = ref('')
const loading = ref(false)
const message = ref('')

async function register() {
    loading.value = true
    message.value = ''

    const { error } = await supabase.auth.signUp({
        email: email.value,
        password: password.value
    })

    loading.value = false

    if (error) {
        message.value = 'Nao foi possivel concluir o cadastro. Tente novamente.'
        return
    }

    message.value = 'Cadastro realizado. Verifique seu e-mail para confirmar a conta.'
    setTimeout(() => {
        router.push('/login')
    }, 1000)
}
</script>

<style scoped>
</style>
