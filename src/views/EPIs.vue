<template>
    <AppHeader />
    <main class="page-shell">
        <section class="top-card">
            <div>
                <p class="eyebrow">Painel de EPIs</p>
                <h1>Controle de estoque e distribuicao</h1>
                <p>Visualize quantidades, validade e prioridade de reposicao em um unico painel.</p>
            </div>
            <button class="primary-action">Novo registro</button>
        </section>

        <section class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>Item</th>
                        <th>Estoque</th>
                        <th>Validade media</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Capacete Classe B</td>
                        <td>146</td>
                        <td>8 meses</td>
                        <td><span class="status ok">OK</span></td>
                    </tr>
                    <tr>
                        <td>Luva Nitrilica</td>
                        <td>42</td>
                        <td>2 meses</td>
                        <td><span class="status warn">Médio</span></td>
                    </tr>
                    <tr>
                        <td>Oculos de Protecao</td>
                        <td>19</td>
                        <td>1 mes</td>
                        <td><span class="status warn">Médio</span></td>
                    </tr>
                    <tr>
                        <td>Protetor Auricular</td>
                        <td>7</td>
                        <td>4 meses</td>
                        <td><span class="status danger">Baixo</span></td>
                    </tr>
                </tbody>
            </table>
        </section>
    </main>
    <AppFooter />
</template>

<script setup>
import AppHeader from '/components/AppHeader.vue'
import AppFooter from '../../components/AppFooter.vue'
</script>

<style scoped>
.page-shell {
    width: min(1120px, 92%);
    margin: 2rem auto 3rem;
    display: grid;
    gap: 1.1rem;
}

.top-card,
.table-card {
    border-radius: 1rem;
    border: 1px solid #d7deea;
    background: linear-gradient(180deg, #f8fafc 0%, #eef4fa 100%);
    box-shadow: 0 12px 28px rgba(12, 20, 38, 0.08);
}

.top-card {
    padding: 1.4rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 1rem;
}

.eyebrow {
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: #2b8ac8;
    font-weight: 700;
    font-size: 0.78rem;
    margin-bottom: 0.45rem;
}

h1 {
    color: #123752;
    margin-bottom: 0.35rem;
}

p {
    color: #4a647b;
}

.primary-action {
    border: none;
    border-radius: 0.75rem;
    padding: 0.72rem 1rem;
    background: linear-gradient(90deg, #17486b 0%, #2b8ac8 100%);
    color: #fff;
    font-weight: 700;
    cursor: pointer;
}

.table-card {
    padding: 0.9rem;
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th,
td {
    text-align: left;
    padding: 0.9rem 0.8rem;
    border-bottom: 1px solid #dce4ef;
}

th {
    color: #214663;
    font-size: 0.88rem;
}

td {
    color: #3d5b74;
}

.status {
    border-radius: 999px;
    font-size: 0.78rem;
    font-weight: 700;
    padding: 0.25rem 0.6rem;
}

.status.ok {
    background: #def7e7;
    color: #226144;
}

.status.warn {
    background: #fff3dd;
    color: #865e18;
}

.status.danger {
    background: #ffe1e1;
    color: #8f2b2b;
}

@media (max-width: 740px) {
    .top-card {
        flex-direction: column;
        align-items: flex-start;
    }
}
</style>
