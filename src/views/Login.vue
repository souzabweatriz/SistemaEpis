<template>
    <main class="auth-page">
        <section class="hero-panel">
            <div class="hero-content">
                <img src="../../public/Image/logo.png" class="logo" alt="LOGO">
                <p class="hero-eyebrow">EPICloud</p>
                <h2 class="hero-title">Protecao que organiza, controla e inspira.</h2>
                <p class="hero-phrase">Sua operação merece precisão em cada entrega.</p>
                <p class="hero-motion">Segurança. Controle. Evolução.</p>
            </div>
        </section>

        <section class="auth-card">
            <p class="eyebrow">Acesso seguro</p>
            <h1>Entrar na plataforma</h1>
            <p class="subtitle">Use suas credenciais para acessar os modulos de EPIs e setores.</p>
            <form class="auth-form" @submit.prevent="fazerLogin">
                <label class="field-group">
                    <span class="field-label">E-mail</span>
                    <input class="field-input" v-model="email" type="email" placeholder="seuemail@empresa.com" required />
                </label>

                <label class="field-group">
                    <span class="field-label">Senha</span>
                    <input class="field-input" v-model="password" type="password" placeholder="********" required />
                </label>

                <button class="submit-button" type="submit" :disabled="loading">
                    {{ loading ? 'Entrando...' : 'Entrar' }}
                </button>
            </form>

            <p v-if="erro" class="error-message">{{ erro }}</p>
        </section>
    </main>
</template>

<script setup>
import { useSupabase } from '../composables/useSupabase.js'
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const { supabase } = useSupabase()
const router = useRouter()

const email = ref('')
const password = ref('')
const loading = ref(false)
const erro = ref('')

async function fazerLogin() {
    erro.value = ''
    loading.value = true

    try {
        const { error } = await supabase.auth.signInWithPassword({
            email: email.value,
            password: password.value
        })

        if (error) {
            erro.value = 'Falha no login. Verifique suas credenciais.'
            return
        }

        router.push('/dashboard')
    } finally {
        loading.value = false
    }
}
</script>

<style scoped>
.auth-page {
    --bg-soft: #f1f6fb;
    --card-bg: rgba(250, 253, 255, 0.9);
    --ink-strong: #0f3554;
    --ink-mid: #31556f;
    --brand-main: #0b6b7d;
    --brand-deep: #084c5a;
    --accent: #f5a34d;
    --line: #b8d3e4;

    width: 100%;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(160deg, #eaf2f8 0%, var(--bg-soft) 55%, #edf4f9 100%);
}

.logo {
    width: 8rem;
    height: 6rem;
}

.hero-panel {
    width: 50%;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background:
        radial-gradient(circle at 30% 20%, rgba(11, 107, 125, 0.16) 0%, rgba(11, 107, 125, 0) 34%),
        linear-gradient(180deg, #eaf2f8 0%, #edf4f9 100%);
}

.hero-content {
    width: 26rem;
    height: 26rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 1rem;
}

.hero-eyebrow {
    width: fit-content;
    color: var(--brand-main);
    font-size: 0.86rem;
    font-weight: 800;
    letter-spacing: 0.12em;
    text-transform: uppercase;
}

.hero-title {
    color: var(--ink-strong);
    text-align: center;
    font-size: 2.7rem;
    line-height: 1.02;
    width: 100%;
}

.hero-phrase {
    color: var(--ink-mid);
    font-size: 1rem;
    line-height: 1.6;
    width: 100%;
    max-width: 21rem;
}

.hero-motion {
    width: fit-content;
    color: var(--brand-deep);
    font-size: 1rem;
    font-weight: 800;
    letter-spacing: 0.05em;
    animation: phraseShift 2.8s ease-in-out infinite;
}

.auth-card {
    width: 50%;
    height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 2rem;
    background: var(--card-bg);
    border-left: 0.0625rem solid rgba(184, 211, 228, 0.7);
    box-shadow: -0.9rem 0 2rem rgba(22, 58, 83, 0.08);
    backdrop-filter: blur(0.35rem);
    animation: cardRise 0.45s ease-out;
}

.eyebrow {
    margin: 0 0 0.55rem;
    color: var(--brand-main);
    font-size: 0.78rem;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 0.11em;
}

h1 {
    margin: 0;
    color: var(--ink-strong);
    font-family: 'Sora', 'Verdana', sans-serif;
    font-size: clamp(1.65rem, 3.2vw, 2.6rem);
    line-height: 1.05;
}

.subtitle {
    margin: 0.9rem 0 1.25rem;
    color: var(--ink-mid);
    line-height: 1.5;
    font-size: 0.96rem;
}

.auth-form {
    display: flex;
    flex-direction: column;
    gap: 0.9rem;
    width: 100%;
    max-width: 31rem;
}

.field-group {
    display: flex;
    flex-direction: column;
    gap: 0.38rem;
    width: 100%;
}

.field-label {
    color: var(--ink-strong);
    font-size: 0.88rem;
    font-weight: 700;
}

.field-input {
    width: 100%;
    min-height: 2.75rem;
    border-radius: 0.75rem;
    border: 1px solid var(--line);
    padding: 0.65rem 0.78rem;
    background: rgba(255, 255, 255, 0.8);
    color: var(--ink-strong);
    font-size: 0.94rem;
    outline: none;
    transition: border-color 0.18s ease, box-shadow 0.18s ease;
}

.field-input:focus {
    border-color: var(--brand-main);
    box-shadow: 0 0 0 0.2rem rgba(11, 107, 125, 0.15);
}

.field-input::placeholder {
    color: #7590a2;
}

.submit-button {
    margin-top: 0.25rem;
    border: none;
    width: 100%;
    min-height: 2.85rem;
    border-radius: 0.85rem;
    background: linear-gradient(135deg, var(--brand-main) 0%, var(--brand-deep) 100%);
    color: #f7fcff;
    font-weight: 800;
    font-size: 0.95rem;
    letter-spacing: 0.02em;
    cursor: pointer;
    transition: transform 0.15s ease, box-shadow 0.2s ease, filter 0.2s ease;
}

.submit-button:hover:not(:disabled) {
    transform: translateY(-1px);
    box-shadow: 0 0.65rem 1.35rem rgba(8, 76, 90, 0.26);
    filter: saturate(1.08);
}

.submit-button:disabled {
    cursor: not-allowed;
    opacity: 0.72;
}

.error-message {
    margin: 0.9rem 0 0;
    border: 1px solid rgba(179, 74, 45, 0.3);
    border-radius: 0.65rem;
    padding: 0.6rem 0.72rem;
    color: #9f3b20;
    background: rgba(255, 239, 232, 0.8);
    font-size: 0.89rem;
}

.cta-register {
    margin: 1rem 0 0;
    color: var(--ink-mid);
    font-size: 0.92rem;
}

.link-button {
    border: none;
    padding: 0;
    margin-left: 0.28rem;
    font-size: 0.92rem;
    font-weight: 800;
    color: var(--brand-main);
    background: transparent;
    cursor: pointer;
    text-decoration: underline;
    text-decoration-thickness: 0.08rem;
    text-underline-offset: 0.12rem;
}

.link-button:hover {
    color: var(--brand-deep);
}

@keyframes cardRise {
    from {
        opacity: 0;
        transform: translateY(0.7rem) scale(0.99);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}

@keyframes phraseShift {
    0%, 100% {
        transform: translateY(0);
        opacity: 0.9;
    }
    50% {
        transform: translateY(-0.4rem);
        opacity: 1;
    }
}

@media (max-width: 1023px) {
    .auth-page {
        min-height: 100vh;
    }

    .hero-panel {
        display: none;
    }

    .auth-card {
        width: 100%;
        height: 100vh;
        border-left: none;
        border-top: none;
        box-shadow: none;
        padding: 2rem 1.5rem;
        justify-content: center;
        align-items: center;
    }

    .auth-form {
        max-width: 100%;
    }
}

@media (max-width: 680px) {
    .auth-card {
        padding: 1.25rem 1rem;
    }

    .subtitle {
        font-size: 0.9rem;
        margin-top: 0.75rem;
    }

    .field-input,
    .submit-button {
        min-height: 2.6rem;
    }
}

</style>
