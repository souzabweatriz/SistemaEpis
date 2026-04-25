<template>
    <div>
        <AppHeader />
    </div>
    <div class="home-container">
        <div class="banner-wrap">
            <img class="banner" src="../../public/Image/bannerWebsite.png" alt="Banner do Website">
            <div class="banner-text">
                <h2>Gestão em nuvem, segurança em tempo real</h2>
            </div>
        </div>
        <div class="colored-text">
            <div class="carousel-track">
                <p class="carousel-text">Segurança elevada à nuvem</p>
                <p class="carousel-text">Gestão que protege vidas</p>
                <p class="carousel-text">Decisões mais inteligentes</p>
                <p class="carousel-text">Controle em tempo real</p>
                <p class="carousel-text">Eficiência que cresce</p>
                <p class="carousel-text">Processos mais ágeis</p>
            </div>
            <div class="carousel-track" aria-hidden="true">
                <p class="carousel-text">Segurança elevada à nuvem</p>
                <p class="carousel-text">Gestão que protege vidas</p>
                <p class="carousel-text">Decisões mais inteligentes</p>
                <p class="carousel-text">Controle em tempo real</p>
                <p class="carousel-text">Eficiência que cresce</p>
                <p class="carousel-text">Processos mais ágeis</p>
            </div>
        </div>
        <div class="section-epis">
            <img class="section-image" src="../../public/Image/oculos.png" alt="Logo da Empresa">
            <div class="texts">
                <h1 class="title-epis">Controle total do ciclo de vida dos equipamentos de proteção</h1>
                <p class="section-text">Garanta mais segurança, organização e eficiência na gestão de Equipamentos de
                    Proteção Individual da sua empresa. Nosso Sistema de Controle de EPIs foi desenvolvido para
                    facilitar o registro, acompanhamento e gerenciamento de todos os equipamentos fornecidos aos
                    colaboradores.</p>
                <div class="buttons">
                    <button class="sobre-button">Saber mais</button>
                    <button class="sobre-button">Entre em contato</button>
                </div>
            </div>
        </div>
        <div class="section-epis">
            <div class="texts">
                <h2 class="title-epis">Rastreabilidade completa, segurança garantida</h2>
                <p class="section-text">Acompanhe cada etapa do ciclo de vida dos EPIs, desde a aquisição até a entrega
                    e descarte. Nosso sistema oferece rastreabilidade total, garantindo que cada equipamento seja
                    monitorado
                    e gerenciado com precisão, proporcionando mais segurança para seus colaboradores e tranquilidade
                    para
                    sua empresa.</p>
            </div>
            <img class="section-image" src="../../public/Image/capacete.png" alt="Capacete de segurança">
        </div>

        <section class="benefits-section">
            <div class="benefits-header">
                <h2 class="benefits-title">Por que escolher a EPICloud</h2>
                <p class="benefits-subtitle">Beneficios exclusivos para empresas que querem evoluir a gestao de EPIs.
                </p>
            </div>

            <div class="benefits-grid">
                <article class="benefit-card">
                    <div class="benefit-icon"><i class="pi pi-box"></i></div>
                    <h3>Agregacao de Valor</h3>
                    <p>Destaque sua operacao com rastreabilidade inteligente e dados acionaveis.</p>
                </article>

                <article class="benefit-card">
                    <div class="benefit-icon"><i class="pi pi-bolt"></i></div>
                    <h3>Implementacao Rapida</h3>
                    <p>Fluxo de implantacao simples, sem travar a rotina da sua equipe.</p>
                </article>

                <article class="benefit-card">
                    <div class="benefit-icon"><i class="pi pi-chart-line"></i></div>
                    <h3>Escala com Controle</h3>
                    <p>Ganhe visibilidade para crescer sem perder padrao operacional.</p>
                </article>

                <article class="benefit-card">
                    <div class="benefit-icon"><i class="pi pi-users"></i></div>
                    <h3>Suporte Dedicado</h3>
                    <p>Conte com acompanhamento proximo para cada etapa da sua jornada.</p>
                </article>
            </div>
        </section>
    </div>
    <AppFooter />
</template>


<script setup>
import AppHeader from '/components/AppHeader.vue'
import AppFooter from '/components/AppFooter.vue'
</script>

<style scoped>
.home-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: auto;
    background-color: #ffffff;
}

.banner-wrap {
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    width: 100%;
    min-height: 19rem;
    overflow: hidden;
}

.banner-wrap::after {
    content: '';
    position: absolute;
    inset: 0;
    background: rgba(26, 34, 44, 0.716);
    pointer-events: none;
    z-index: 1;
}

.banner {
    width: 100%;
    min-height: 19rem;
    max-height: 35rem;
    object-fit: cover;
    display: block;
}

.banner-text {
    position: absolute;
    inset: 0;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;
    padding: 1.2rem;
    text-align: center;
    z-index: 2;
    color: #f4f7f6;
    text-shadow: 0 4px 16px rgba(0, 0, 0, 0.45);
}

.banner-text h2 {
    font-size: clamp(1.35rem, 2.6vw, 2.4rem);
    line-height: 1.1;
    max-width: 22ch;
}

.sobre-button {
    margin-top: 1.4rem;
    width: 10rem;
    height: 3rem;
    border-radius: 0.85rem;
    background: linear-gradient(135deg, #1A535C 0%, #0f3d47 100%);
    border: none;
    color: #f4f7f6;
    box-shadow: 0px 4px 12px rgba(26, 53, 92, 0.22);
    cursor: pointer;
    transition: background 0.3s ease, box-shadow 0.3s ease;
    font-weight: 700;
    font-size: 0.92rem;
}

.sobre-button:hover {
    background: linear-gradient(135deg, #084f4a 0%, #3db5ac 100%);
    box-shadow: 0px 6px 16px rgba(78, 205, 196, 0.28);
}

.epis-showcase {
    position: relative;
    width: min(100%, 62rem);
    height: 40rem;
    margin-top: 0.4rem;
    display: flex;
    justify-content: center;
    align-items: center;
}

.colored-text {
    display: flex;
    justify-content: center;
    margin-top: 1.4rem;
    align-items: center;
    gap: 1rem;
    overflow: hidden;
    width: 100%;
    padding: 0 0.6rem;
    mask-image: linear-gradient(90deg, transparent 0%, black 10%, black 90%, transparent 100%);
}

.carousel-track {
    display: flex;
    align-items: center;
    gap: 1rem;
    min-width: max-content;
    animation: marquee 26s linear infinite;
}

.carousel-text {
    background-color: #ffffffb0;
    border-radius: 1.2rem;
    border: 1px solid #062a38;
    color: #00454f;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 0.88rem;
    white-space: nowrap;
    flex-shrink: 0;
}

.section-text {
    display: flex;
    flex-direction: column;
    text-align: center;
    justify-content: center;
    align-items: center;
    gap: 0.7rem;
    margin-top: 1.5rem;
    width: 90%;
    max-width: 42rem;
    line-height: 1.65;
    color: var(--text-soft);
}


.section-epis {
    display: flex;
    justify-content: center;
    flex-direction: row;
    width: 100%;
    max-width: 72rem;
    min-height: 26rem;
    align-items: center;
    gap: 2rem;
    margin: 3rem 0 1.5rem;
    padding: 2rem;
    border-radius: 2rem;
    border: none;
    background: linear-gradient(135deg, rgba(243, 248, 252, 0.96) 0%, rgba(255, 255, 255, 0.98) 55%, rgba(234, 242, 248, 0.95) 100%);
    box-shadow: 0 18px 42px rgba(18, 55, 82, 0.08);
}

.texts {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 58%;
    height: auto;
    gap: 0.5rem;
}


.title-epis {
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    color: var(--text-main);
    font-size: clamp(1.55rem, 2vw, 2.2rem);
    line-height: 1.15;
    margin: 0;
    width: 100%;
}

.section-image {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 38%;
    max-width: 24rem;
    height: 100%;
    object-fit: contain;
    filter: drop-shadow(0 14px 18px rgba(18, 55, 82, 0.12));
}

.buttons {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
    gap: 1rem;
    margin-top: 1rem;
}

@media (max-width: 900px) {
    .section-epis {
        flex-direction: column;
        width: 92%;
        min-height: auto;
        padding: 1.5rem;
        gap: 1.25rem;
    }

    .title-epis {
        font-size: 1.75rem;
    }

    .texts,
    .section-image {
        width: 100%;
    }

    .section-image {
        max-width: 20rem;
        height: 18rem;
    }
}

.section-tracking {
    margin-top: 1.4rem;
    margin-bottom: 2.2rem;
    padding: 0 1rem;
    text-align: center;
}

.benefits-section {
    width: min(100%, 84rem);
    padding: 2.8rem 0.7rem 3.5rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.benefits-header {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    gap: 0.9rem;
    margin-bottom: 1.8rem;
}

.benefits-title {
    font-size: 2rem;
    color: #123752;
    line-height: 1.08;
}

.benefits-subtitle {
    font-size: 1.15rem;
    color: #5f6775;
    width: min(100%, 46rem);
    line-height: 1.45;
}

.benefits-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: stretch;
    gap: 1.2rem;
    width: 100%;
}

.benefit-card {
    flex: 1 1 16rem;
    max-width: 18rem;
    background: #ffffff;
    border: 1px solid #cfdbe5;
    border-radius: 1rem;
    min-height: 16rem;
    padding: 1.3rem 1.15rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 0.85rem;
    text-align: center;
}

.benefit-icon {
    width: 3.2rem;
    height: 3.2rem;
    border-radius: 0.95rem;
    background: #e3f2f4;
    color: #1A535C;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
}

.benefit-icon i {
    font-size: 1.2rem;
}

.benefit-card h3 {
    color: #123752;
    font-size: 1.35rem;
    line-height: 1.15;
    margin: 0;
}

.benefit-card p {
    color: #5f6775;
    font-size: 0.98rem;
    line-height: 1.45;
    margin: 0;
}

@keyframes sectionGlow {
    to {
        opacity: 1;
    }
}

@keyframes titleReveal {
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}

@keyframes subtitleReveal {
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes gradientFlow {
    0% {
        background-position: 0% 50%;
    }

    50% {
        background-position: 100% 50%;
    }

    100% {
        background-position: 0% 50%;
    }
}

@keyframes marquee {
    from {
        transform: translateX(0);
    }

    to {
        transform: translateX(-50%);
    }
}

@media (max-width: 1024px) {
    .home-nav {
        height: 21rem;
        padding: 1rem;
    }

    .home-title {
        font-size: 2.2rem;
        max-width: 32rem;
    }

    .text {
        font-size: 1.02rem;
        max-width: 30rem;
    }

    .banner-text h2 {
        max-width: 18ch;
    }

    .carousel-text {
        font-size: 0.82rem;
    }

    .carousel-track {
        animation-duration: 30s;
    }
}

@media (max-width: 768px) {

    .banner-wrap,
    .banner {
        min-height: 16.5rem;
    }

    .banner-text {
        padding: 1rem;
    }

    .banner-eyebrow {
        font-size: 0.78rem;
        letter-spacing: 0.06em;
    }

    .banner-text h2 {
        font-size: clamp(1.12rem, 5vw, 1.7rem);
        max-width: 16ch;
    }

    .sobre-button {
        width: 8.8rem;
        height: 2.6rem;
        font-size: 0.82rem;
        margin-top: 0.9rem;
    }

    .colored-text {
        margin-top: 1rem;
        gap: 0.7rem;
        padding: 0 0.4rem;
    }

    .carousel-text {
        font-size: 0.76rem;
        padding: 0.52rem 0.68rem;
    }

    .carousel-track {
        gap: 0.7rem;
        animation-duration: 26s;
    }

    .benefits-section {
        padding: 2.2rem 0.7rem 2.6rem;
    }

    .benefits-subtitle {
        font-size: 1rem;
    }

    .benefit-card h3 {
        font-size: 1.8rem;
    }

    .benefit-card p {
        font-size: 1.2rem;
    }
}

@media (max-width: 640px) {
    .home-nav {
        height: 19rem;
        padding: 1rem;
    }

    .home-title {
        font-size: 1.8rem;
        text-align: center;
    }

    .text {
        font-size: 0.97rem;
    }

    .title-epis {
        font-size: 1.4rem;
        text-align: center;
    }

    .section-epis {
        padding: 1.25rem;
        border-radius: 1.5rem;
    }

    .section-title {
        font-size: 1.6rem;
        text-align: center;
    }

    .colored-text {
        gap: 0.55rem;
        padding: 0 0.7rem;
    }

    .carousel-track {
        animation-duration: 24s;
    }

    .benefit-card {
        min-height: 14rem;
    }

    .section-tracking {
        margin-top: 1rem;
        margin-bottom: 1.8rem;
    }
}

@media (max-width: 480px) {

    .banner-wrap,
    .banner {
        min-height: 14rem;
    }

    .banner-text {
        gap: 0.35rem;
        padding: 0.8rem;
    }

    .banner-text h2 {
        font-size: clamp(1rem, 6vw, 1.35rem);
        max-width: 15ch;
    }

    .home-nav {
        height: 17rem;
    }

    .home-title {
        font-size: 1.5rem;
    }

    .text {
        font-size: 0.9rem;
        max-width: 20rem;
    }

    .sobre-button {
        width: 8.2rem;
        height: 2.4rem;
        font-size: 0.78rem;
    }

    .section-title {
        font-size: 1.35rem;
    }

    .section-image {
        max-width: 16rem;
        height: 14rem;
    }

    .section-subtitle {
        font-size: 0.92rem;
        padding: 0 0.5rem;
    }

    .colored-text {
        margin-top: 0.85rem;
        padding: 0 0.5rem;
        mask-image: none;
    }

    .carousel-track {
        animation-duration: 22s;
    }

    .carousel-text {
        font-size: 0.72rem;
        padding: 0.45rem 0.62rem;
    }
}
</style>
