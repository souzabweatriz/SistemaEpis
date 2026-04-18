<template>
    <footer v-if="showFooter" class="app-footer">
        <div class="footer-shell">
            <div class="footer-top">
                <section class="brand-column">
                    <div class="brand-row">
                        <img src="/Image/logo.png" alt="Logo do EPICloud" class="brand-icon" />
                        <p class="brand-title">EPICloud</p>
                    </div>
                    <p class="brand-copy">
                        Infraestrutura de alto nivel para aplicacoes criticas.
                        Onde a performance encontra a confiabilidade.
                    </p>
                </section>

                <section class="links-column">
                    <div class="links-group">
                        <h4 class="group-title">PRODUTO</h4>
                        <a href="#" class="footer-link">EPI Cloud</a>
                        <a href="#" class="footer-link">Recursos</a>
                        <a href="#" class="footer-link">Tecnologias</a>
                    </div>

                    <div class="links-group">
                        <h4 class="group-title">EMPRESA</h4>
                        <a href="#" class="footer-link">Equipe</a>
                        <a href="#" class="footer-link">Contato</a>
                    </div>

                    <div class="links-group">
                        <h4 class="group-title">SUPORTE</h4>
                        <a href="mailto:contato@epicloud.com.br" class="footer-link">contato@epicloud.com.br</a>
                    </div>
                </section>
            </div>
            <div class="footer-bottom">
                <p>EPICloud © 2026. O futuro e agora.</p>
                <p>Construido com precisao. Escalado com proposito.</p>
            </div>
        </div>
    </footer>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

const showFooter = computed(() => {
    const currentPath = route.path.toLowerCase()
    return !currentPath.startsWith('/dashboard') && !currentPath.startsWith('/app')
})
</script>

<style scoped>
:root {
    --azul-profundo-seguranca: #1A535C;
    --ciano-suave: #4ECDC4;
    --cinza-neutro-claro: #6C757D;
    --fundo-minimalista: #F4F7F6;
    --preto-tipografico: #343A40;
}

.app-footer {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
    min-height: 14rem;
    color: #ecf2f6;
    background: linear-gradient(135deg, #162330 0%, #223443 52%, #2a4850 100%);
}

.footer-shell {
    display: flex;
    flex-direction: column;
    justify-content: center;
    width: 90%;
    height: 100%;
    min-height: 12rem;
    padding: 1.5rem 0;
    gap: 2rem;
}

.footer-top {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    min-height: 8rem;
    gap: 3.5rem;
    flex-wrap: wrap;
}

.brand-column {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
}

.brand-row {
    display: flex;
    align-items: center;
    gap: 0.7rem;
}

.brand-icon {
    width: 1.55rem;
    height: 1.55rem;
    object-fit: contain;
    opacity: 0.92;
}

.brand-title {
    margin: 0;
    font-size: 1.2rem;
    font-weight: 700;
    letter-spacing: 0.02em;
    color: #f7fafc;
}

.brand-copy {
    margin: 0;
    color: #b8c7d1;
    font-size: 0.84rem;
    line-height: 1.45;
    width: 100%;
    max-width: 24rem;
}

.email-form {
    width: 100%;
}


.email-icon {
    color: #aab8c2;
    font-size: 0.82rem;
    line-height: 1;
}

.email-input {
    flex: 1;
    border: none;
    outline: none;
    background: transparent;
    color: #ecf2f6;
    font-size: 0.84rem;
}

.email-input::placeholder {
    color: #aab8c2;
}

.links-column {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    width: 52%;
    gap: 2rem;
    flex-wrap: wrap;
}

.links-group {
    display: flex;
    flex-direction: column;
    gap: 0.7rem;
}

.group-title {
    margin: 0;
    color: #b4c2cb;
    letter-spacing: 0.06em;
    font-size: 0.86rem;
    font-weight: 700;
}

.footer-link {
    color: #d1dbe2;
    text-decoration: none;
    font-size: 0.84rem;
    transition: color 0.25s ease;
}

.footer-link:hover {
    color: #f8fbfd;
}

.footer-bottom {
    border-top: 0.0625rem solid rgba(255, 255, 255, 0.14);
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    height: 22%;
    min-height: 2.5rem;
    gap: 1rem;
    flex-wrap: wrap;
    color: #aebcc5;
    font-size: 0.72rem;
}

@media (max-width: 767px) {
    .app-footer {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .footer-shell {
        display: flex;
        flex-direction: column;
        justify-content: center;
        width: 92%;
        min-height: 20rem;
        gap: 1.5rem;
    }

    .footer-top {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        gap: 1.5rem;
        text-align: center;
    }

    .brand-column {
        width: 100%;
        align-items: center;
    }

    .brand-copy {
        max-width: 100%;
    }

    .links-column {
        width: 100%;
        justify-content: center;
        gap: 1.2rem;
    }

    .links-group {
        width: 100%;
        align-items: center;
    }

    .footer-bottom {
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 3.2rem;
        gap: 0.6rem;
        text-align: center;
    }
}

@media (min-width: 768px) and (max-width: 1023px) {
    .app-footer {
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .footer-shell {
        width: 92%;
        min-height: 13.5rem;
        padding: 1.7rem 0.4rem;
        gap: 1.2rem;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .footer-top {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        flex-wrap: nowrap;
        gap: 1.15rem;
        text-align: center;
    }

    .brand-column {
        width: min(100%, 30rem);
        align-items: center;
        text-align: center;
    }

    .brand-copy {
        max-width: 28rem;
    }

    .links-column {
        width: min(100%, 42rem);
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 1rem 1.25rem;
        justify-content: center;
        align-items: start;
        justify-items: center;
        text-align: center;
    }

    .links-group {
        width: 100%;
        align-items: center;
        gap: 0.55rem;
    }

    .footer-bottom {
        min-height: 2.5rem;
        width: min(100%, 38rem);
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 0.45rem;
        text-align: center;
    }
}

@media (min-width: 1024px) and (max-width: 1439px) {
    .app-footer {
        min-height: 14rem;
    }

    .footer-shell {
        width: 86%;
        min-height: 12rem;
    }

    .brand-column {
        width: 38%;
    }

    .links-column {
        width: 56%;
        gap: 2.4rem;
    }
}

@media (min-width: 1440px) {
    .app-footer {
        min-height: 16rem;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .footer-shell {
        width: 74%;
        min-height: 14rem;
        gap: 2.4rem;
    }

    .footer-top {
        gap: 4.5rem;
    }

    .brand-column {
        width: 34%;
    }

    .brand-copy {
        max-width: 28rem;
    }

    .links-column {
        width: 58%;
        gap: 3.2rem;
    }

    .footer-bottom {
        min-height: 3rem;
        font-size: 0.8rem;
    }
}
</style>
