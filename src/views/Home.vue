<template>
    <div>
        <AppHeader />
    </div>
    <div class="home-container">
        <nav class="home-nav">
            <h1 class="home-title">Proteção em cada detalhe, controle em cada entrega.</h1>
            <p class="text">Agende uma demonstração e veja como a EPICloud pode revolucionar a segurança na sua empresa</p>
            <button class="sobre-button" @click="router.push('/sobre')">Clique e conheça</button>
        </nav>
        <div class="colored-text">
            <p class="text-purple">Segurança elevada à nuvem</p>
            <p class="text-purple">Gestão que protege vidas</p>
            <p class="text-purple">Gestão que protege vidas</p>
            <p class="text-purple">Gestão que protege vidas</p>
        </div>
        <div class="section-epis">
            <h1 class="title-epis">Controle total do ciclo de vida dos</h1>
            <h1 class="title-epis">equipamentos de proteção</h1>
        </div>
        <div
            ref="showcaseRef"
            class="epis-showcase"
            :style="{ '--scroll-progress': showcaseProgress }"
        >
            <img class="img-epi epi-botas" src="../../public/Image/botas.png" alt="Imagem de Botas EPI">
            <img class="img-epi epi-capacete" src="../../public/Image/capacete.png" alt="Imagem de capacete EPI">
            <img class="img-epi epi-fone" src="../../public/Image/fone.png" alt="Imagem de Fone EPI">
            <img class="img-armario" src="../../public/Image/Armario.png" alt="Armário que armazena as EPIs">
            <img class="img-epi epi-luvas" src="../../public/Image/luvas.png" alt="Imagem de Luvas EPI">
            <img class="img-epi epi-oculos" src="../../public/Image/oculos.png" alt="Imagem de Óculos EPI">
            <img class="img-epi epi-macacao" src="../../public/Image/macacao.png" alt="Imagem Macacão EPI">
        </div>
        <div class="section-text">
            <h1 class="home-title">Pronto para transformar sua gestão de EPIs?</h1>
            <p>Aproveite de todas as funcionalidades que irão facilitar o seu dia</p>
        </div>
        <div class="section-gerenciamento">
            <h1 class="text-gerenciamento">Gerencie as EPI's do seu ambiente corporativo</h1>
            <aside class="aside-estoque">
                <div class="aside-bloco">
                    <h1 class="aside-epi">Botas</h1>
                    <p>2 unidades</p>
                    <p class="aside-quantidade">Estoque Crítico</p>
                </div>
                <div class="aside-bloco">
                    <h1 class="aside-epi">Luvas</h1>
                    <p>20 unidades</p>
                    <p class="aside-quantidadeemdia">Estoque em dia</p>
                </div>
                <div class="aside-bloco">
                    <h1 class="aside-epi">Fone</h1>
                    <p>20 unidades</p>
                    <p class="aside-quantidadeemdia"><span>Estoque em dia</span></p>
                </div>
                <div class="aside-bloco">
                    <h1 class="aside-epi">Óculos</h1>
                    <p>7 unidades</p>
                    <p class="aside-quantidade">Estoque Crítico</p>
                </div>
            </aside>
        </div>
    </div>
</template>


<script setup>
import { onBeforeUnmount, onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import AppHeader from '/components/Header/AppHeader.vue'

const router = useRouter()
const showcaseRef = ref(null)
const showcaseProgress = ref(0)

const clamp = (value, min, max) => Math.min(Math.max(value, min), max)

const updateShowcaseProgress = () => {
    if (!showcaseRef.value) {
        return
    }

    
    const rect = showcaseRef.value.getBoundingClientRect()
    const sectionCenter = rect.top + rect.height / 2
    const viewportCenter = window.innerHeight / 2
    const startDistance = window.innerHeight * 0.55
    const distanceToCenter = sectionCenter - viewportCenter
    const progress = 1 - distanceToCenter / startDistance

    showcaseProgress.value = clamp(progress, 0, 1)
}

onMounted(() => {
    updateShowcaseProgress()
    window.addEventListener('scroll', updateShowcaseProgress, { passive: true })
    window.addEventListener('resize', updateShowcaseProgress)
})

onBeforeUnmount(() => {
    window.removeEventListener('scroll', updateShowcaseProgress)
    window.removeEventListener('resize', updateShowcaseProgress)
})
</script>

<style scoped>
.home-container{
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: auto;
    background-color: #ffffff;
}

.home-nav {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 30rem;
    width: 100%;
    background: radial-gradient(
    circle at center,
    #f0eef1 0%,
    #D4C1DB 50%,
    #3a004f99 100%
);

}
.home-title{
    max-width: 50rem;
    font-size: 3.4rem;
    color: #3A004F;
    font-weight: bolder;
}
.text{
    max-width: 40rem;
    font-size: 1.5rem;
    color: #2a0837bb;
    font-weight: 500;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
}
.sobre-button{
    margin-top: 2rem;
    width: 12rem;
    height: 4rem;
    border-radius: 1rem;
    background: linear-gradient(90deg, #3c0643 0%, 40%, #b8a0c3 100%);
    background-size: 200% 200%;
    background-position: 0% 50%;
    border: none;
    color: black;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.341);
    cursor: pointer;
    transition: transform 0.5s ease;
    font-weight: bolder;
    color: white;
    font-size: 1rem;
}
.sobre-button:hover {
    background-position: 100% 50%;
    transform: scale(1.05);
    background: linear-gradient(90deg, #3c0643 0%, 40%, #b8a0c3 100%);
    background-size: 200% 200%;
    background-position: 0% 50%;
}
.epis-showcase{
    position: relative;
    width: min(100%, 72rem);
    height: 48rem;
    margin-top: 1rem;
    display: flex;
    justify-content: center;
    align-items: center;
}
.colored-text{
    display: flex;
    margin-top: 2rem;
    justify-content: center;
    align-items: center;
    gap: 4rem;
    flex-wrap: wrap;
}
.text-purple{
    background-color: #ffffffb0;
    border-radius: 2rem;
    padding: 1rem;
    border:  1px solid #3A004F;
    color: #3A004F;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 1rem;
    opacity: 0;
    transform: translateY(12px);
    animation: revealText 0.6s ease forwards;
}

.section-text{
    display: flex;
    flex-direction: column;
    text-align: center;
    justify-content: center;
    align-items: center;
    gap: 1rem;
    margin-top: 2rem;

}

.text-purple:nth-child(1) {
    animation-delay: 0.15s;
}

.text-purple:nth-child(2) {
    animation-delay: 0.35s;
}

.text-purple:nth-child(3) {
    animation-delay: 0.55s;
}

.text-purple:nth-child(4) {
    animation-delay: 0.75s;
}

@keyframes revealText {
    from {
        opacity: 0;
        transform: translateY(12px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
.section-epis{
    margin-top: 4rem;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}
.title-epis{
    display: flex;
    align-items: center;
}
.img-armario{
    height: 45rem;
    z-index: 2;
}

.img-epi {
    position: absolute;
    width: 8.2rem;
    z-index: 3;
    filter: drop-shadow(0px 6px 12px rgba(0, 0, 0, 0.18));
    --item-delay: 0;
    --item-duration: 0.18;
    --item-progress: clamp(0, calc((var(--scroll-progress) - var(--item-delay)) / var(--item-duration)), 1);
    opacity: var(--item-progress);
    transform: translate(
        calc((1 - var(--item-progress)) * var(--from-x, 0rem)),
        calc((1 - var(--item-progress)) * var(--from-y, 0rem))
    ) scale(calc(0.45 + var(--item-progress) * 0.55));
    will-change: transform, opacity;
}

.epi-botas {
    top: 3rem;
    left: 2rem;
    --from-x: 13rem;
    --from-y: 8rem;
    --item-delay: 0.02;
}

.epi-capacete {
    top: 19rem;
    left: 9.5rem;
    --from-x: 17rem;
    --from-y: -1rem;
    --item-delay: 0.16;
}

.epi-fone {
    bottom: 7rem;
    left: 2rem;
    --from-x: 15rem;
    --from-y: -7rem;
    --item-delay: 0.3;
}

.epi-luvas {
    top: 3rem;
    right: 2rem;
    --from-x: -13rem;
    --from-y: 8rem;
    --item-delay: 0.44;
}

.epi-oculos {
    top: 19rem;
    right: 9.8rem;
    --from-x: -15rem;
    --from-y: -1rem;
    --item-delay: 0.58;
}

.epi-macacao {
    bottom: 1rem;
    right: 2rem;
    width: 9.2rem;
    --from-x: -14rem;
    --from-y: -8rem;
    --item-delay: 0.72;
}

@media (max-width: 900px) {
    .epis-showcase {
        height: 38rem;
    }

    .img-armario {
        height: 35rem;
    }

    .img-epi {
        width: 6rem;
    }

    .epi-botas {
        left: 1.2rem;
    }

    .epi-capacete {
        left: 1.6rem;
        top: 13rem;
    }

    .epi-fone {
        left: 0.7rem;
        bottom: 5rem;
    }

    .epi-luvas {
        right: 1.2rem;
    }

    .epi-oculos {
        right: 1.8rem;
        top: 13rem;
    }

    .epi-macacao {
        right: 0.8rem;
        bottom: 5rem;
        width: 6.8rem;
    }
}
.section-gerenciamento{
    display: flex;
    flex-direction: row;
    justify-content: end;
    align-items: center;
    width: 100%;
    height: 20rem;
    background-color: #F5F3F6;
    margin-top: 2rem;

}
.text-gerenciamento{
    color:#5A286C;
    width: 10rem;
    font-size: 2.5rem;
}
.aside-bloco{
    margin-left: 10rem;
    margin-top: 1rem;
    display: flex;
    text-align: center;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    gap: 1rem;
    width: 27rem;
    height: 3rem;
    margin-right: 5rem;
    background-color: white;
    border-radius: 2rem;
    box-shadow:
        5px 5px 10px #979494,
        -5px -5px 10px #ffffff;
}
.aside-quantidade{
    display: flex;
    align-items: center;
    flex-direction: row;
    align-content: center;
    justify-content: center;
    width: 10rem;
    height: 2rem;
    color: #F25D27;
    background-color: #bf190a42;
    color: #730A0A;
    border-radius: 2rem;
    box-shadow:
        5px 5px 10px #d9d9d9,
        -5px -5px 10px #ffffff;
}
.aside-quantidadeemdia{
    display: flex;
    align-items: center;
    flex-direction: row;
    align-content: center;
    justify-content: center;
    width: 10rem;
    height: 2rem;
    background-color: #CCDECD;
    color: #10403B;
    border-radius: 2rem;
    box-shadow:
        5px 5px 10px #d9d9d9,
        -5px -5px 10px #ffffff;
}
.aside-epi{
    font-size: 1rem;
}
</style>
