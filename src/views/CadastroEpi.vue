<template>
    <div class="layout-shell">
        <header class="hero-card">
            <div class="hero-copy">
                <p class="eyebrow">Cadastro de EPIs</p>
                <h1>Catálogo de proteção com estoque e validade</h1>
                <p class="hero-text">Controle C.A., fabricante, vencimento e quantidade em um fluxo visual mais claro e objetivo.</p>
            </div>

            <div class="hero-metrics">
                <article class="metric-card">
                    <span class="metric-label">Itens cadastrados</span>
                    <strong>{{ epis.length }}</strong>
                </article>
                <article class="metric-card warning">
                    <span class="metric-label">Estoque baixo</span>
                    <strong>{{ quantidadeBaixa }}</strong>
                </article>
                <article class="metric-card success">
                    <span class="metric-label">Estoque ok</span>
                    <strong>{{ quantidadeOk }}</strong>
                </article>
            </div>
        </header>

        <main class="content-grid">
            <section class="card-form">
                <div class="card-head">
                    <div>
                        <p class="card-kicker">Registro</p>
                        <h3>{{ editandoId ? 'Editar equipamento' : 'Novo equipamento' }}</h3>
                    </div>
                    <span class="card-badge">{{ editandoId ? 'Em edição' : 'Novo' }}</span>
                </div>

                <form @submit.prevent="salvar" class="main-form">
                    <div class="form-row">
                        <div class="form-group span-2">
                            <label>Nome do EPI</label>
                            <input v-model="form.nome" type="text" placeholder="Ex: Capacete de Segurança" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Número do C.A.</label>
                            <input v-model="form.numero_ca" type="text" placeholder="Ex: CA12345" required>
                        </div>
                        <div class="form-group">
                            <label>Estoque</label>
                            <input v-model="form.estoque" type="number" min="0" step="1" placeholder="Ex: 25" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Tipo / Proteção</label>
                            <input v-model="form.tipo" type="text" placeholder="Ex: Proteção da cabeça">
                        </div>
                        <div class="form-group">
                            <label>Fabricante</label>
                            <input v-model="form.fabricante" type="text" placeholder="Ex: 3M">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Data de validade</label>
                            <input v-model="form.dt_validade" type="date" required>
                        </div>
                        <div class="form-group">
                            <label>Periodicidade (meses)</label>
                            <input v-model="form.periodicidade_meses" type="number" min="1" step="1" placeholder="Ex: 12">
                        </div>
                    </div>

                    <p v-if="mensagemErro" class="form-feedback error">{{ mensagemErro }}</p>
                    <p v-if="mensagemSucesso" class="form-feedback success">{{ mensagemSucesso }}</p>

                    <div class="action-bar">
                        <button type="submit" class="btn btn-primary">
                            {{ editandoId ? 'Salvar alterações' : 'Cadastrar EPI' }}
                        </button>
                        <button v-if="editandoId" type="button" @click="cancelarEdicao" class="btn btn-outline">
                            Cancelar
                        </button>
                    </div>
                </form>
            </section>

            <section class="card-table">
                <div class="table-head">
                    <div>
                        <p class="card-kicker">Lista</p>
                        <h3>EPIs cadastrados</h3>
                    </div>
                    <span class="table-count">{{ epis.length }} registros</span>
                </div>

                <div class="table-wrap">
                    <table class="styled-table">
                        <thead>
                            <tr>
                                <th>Equipamento</th>
                                <th>C.A.</th>
                                <th>Tipo</th>
                                <th>Validade</th>
                                <th>Periodicidade</th>
                                <th>Estoque</th>
                                <th class="text-center">Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-if="epis.length === 0">
                                <td colspan="7" class="empty-state">Nenhum EPI cadastrado.</td>
                            </tr>
                            <tr v-for="e in epis" :key="e.id_epi">
                                <td>
                                    <div class="item-title">{{ e.nome }}</div>
                                    <div class="item-subtitle">{{ e.fabricante || 'Fabricante não informado' }}</div>
                                </td>
                                <td><span class="badge-ca">{{ e.numero_ca }}</span></td>
                                <td>{{ e.tipo || '-' }}</td>
                                <td>{{ formatarData(e.dt_validade) }}</td>
                                <td>{{ e.periodicidade_meses ? `${e.periodicidade_meses} meses` : '-' }}</td>
                                <td>
                                    <span :class="['badge-estoque', classeEstoque(e.estoque)]">
                                        <span class="stock-dot"></span>
                                        {{ e.estoque ?? 0 }} · {{ rotuloEstoque(e.estoque) }}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <div class="row-actions">
                                        <button @click="prepararEdicao(e)" class="btn-action edit">Editar</button>
                                        <button @click="excluir(e.id_epi)" class="btn-action delete">Excluir</button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue';
import { useSupabase } from '../composables/useSupabase';
const { supabase } = useSupabase();

const epis = ref([]);
const editandoId = ref(null);
const mensagemErro = ref('');
const mensagemSucesso = ref('');
const form = reactive({
    nome: '',
    numero_ca: '',
    tipo: '',
    fabricante: '',
    dt_validade: '',
    periodicidade_meses: '',
    estoque: ''
});

const quantidadeBaixa = ref(0);
const quantidadeOk = ref(0);

const limparMensagens = () => {
    mensagemErro.value = '';
    mensagemSucesso.value = '';
};

// Busca os EPIs no banco
const carregar = async () => {
    const { data, error } = await supabase.from('epi').select('*').order('nome');

    if (error) {
        mensagemErro.value = 'Não foi possível carregar os EPIs.';
        epis.value = [];
        return;
    }

    epis.value = data || [];

    quantidadeBaixa.value = epis.value.filter((item) => classeEstoque(item.estoque) === 'baixo').length;
    quantidadeOk.value = epis.value.filter((item) => classeEstoque(item.estoque) === 'ok').length;
};

// Salva ou Atualiza
const salvar = async () => {
    limparMensagens();

    const payload = {
        nome: form.nome.trim(),
        numero_ca: form.numero_ca.trim(),
        tipo: form.tipo.trim() || null,
        fabricante: form.fabricante.trim() || null,
        dt_validade: form.dt_validade,
        periodicidade_meses: form.periodicidade_meses === '' ? null : Number(form.periodicidade_meses),
        estoque: Number(form.estoque)
    };

    if (editandoId.value) {
        const { error } = await supabase.from('epi').update(payload).eq('id_epi', editandoId.value);

        if (error) {
            mensagemErro.value = 'Não foi possível atualizar o EPI.';
            return;
        }

        mensagemSucesso.value = 'EPI atualizado com sucesso.';
    } else {
        const { error } = await supabase.from('epi').insert([payload]);

        if (error) {
            mensagemErro.value = 'Não foi possível cadastrar o EPI.';
            return;
        }

        mensagemSucesso.value = 'EPI cadastrado com sucesso.';
    }

    cancelarEdicao();
    carregar();
};

const prepararEdicao = (e) => {
    limparMensagens();
    editandoId.value = e.id_epi;
    Object.assign(form, {
        nome: e.nome || '',
        numero_ca: e.numero_ca || '',
        tipo: e.tipo || '',
        fabricante: e.fabricante || '',
        dt_validade: e.dt_validade || '',
        periodicidade_meses: e.periodicidade_meses ?? '',
        estoque: e.estoque ?? 0
    });
};

const excluir = async (id) => {
    if (confirm('Deseja excluir este equipamento?')) {
        limparMensagens();

        const { error } = await supabase.from('epi').delete().eq('id_epi', id);

        if (error) {
            mensagemErro.value = 'Não foi possível excluir o EPI.';
            return;
        }

        mensagemSucesso.value = 'EPI excluído com sucesso.';
        carregar();
    }
};

const cancelarEdicao = () => {
    editandoId.value = null;
    Object.assign(form, {
        nome: '',
        numero_ca: '',
        tipo: '',
        fabricante: '',
        dt_validade: '',
        periodicidade_meses: '',
        estoque: ''
    });
};

const formatarData = (valor) => {
    if (!valor) {
        return '-';
    }

    const data = new Date(valor);

    if (Number.isNaN(data.getTime())) {
        return '-';
    }

    return data.toLocaleDateString('pt-BR');
};

const rotuloEstoque = (valor) => {
    const estoque = Number(valor) || 0;

    if (estoque < 10) {
        return 'Baixo';
    }

    if (estoque <= 50) {
        return 'Médio';
    }

    return 'OK';
};

const classeEstoque = (valor) => {
    const estoque = Number(valor) || 0;

    if (estoque < 10) {
        return 'baixo';
    }

    if (estoque <= 50) {
        return 'medio';
    }

    return 'ok';
};

onMounted(carregar);
</script>

<style scoped>
.layout-shell {
    width: min(980px, 92vw);
    margin: 1.75rem auto 2.5rem;
    display: grid;
    gap: 1.2rem;
}

.hero-card {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    padding: 1.5rem;
    border-radius: 1.4rem;
    border: 1px solid rgba(18, 55, 82, 0.08);
    background:
        linear-gradient(135deg, rgba(255, 255, 255, 0.94), rgba(243, 248, 252, 0.92)),
        radial-gradient(circle at top right, rgba(43, 138, 200, 0.14), transparent 32%);
    box-shadow: 0 16px 36px rgba(12, 20, 38, 0.08);
}

.hero-copy {
    max-width: 42rem;
}

.eyebrow,
.card-kicker {
    text-transform: uppercase;
    letter-spacing: 0.12em;
    font-size: 0.75rem;
    font-weight: 800;
    color: #2b8ac8;
    margin-bottom: 0.55rem;
}

.hero-card h1 {
    font-size: clamp(1.8rem, 3vw, 2.6rem);
    line-height: 1.08;
    margin-bottom: 0.6rem;
    color: var(--text-main);
}

.hero-text {
    max-width: 40rem;
    color: var(--text-soft);
    line-height: 1.6;
}

.hero-metrics {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 0.8rem;
    width: 100%;
}

.metric-card {
    padding: 1rem;
    border-radius: 1rem;
    border: 1px solid rgba(18, 55, 82, 0.08);
    background: rgba(255, 255, 255, 0.82);
    box-shadow: 0 10px 24px rgba(12, 20, 38, 0.06);
}

.metric-card.warning {
    background: linear-gradient(180deg, #fff9ef, #fff4e3);
}

.metric-card.success {
    background: linear-gradient(180deg, #f3fbf6, #e9f8ef);
}

.metric-label,
.table-count {
    display: block;
    color: var(--text-soft);
    font-size: 0.8rem;
    font-weight: 700;
    margin-bottom: 0.35rem;
}

.metric-card strong {
    display: block;
    font-size: 1.6rem;
    color: var(--text-main);
}

.content-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 1.2rem;
    align-items: start;
}

.card-form,
.card-table {
    overflow: hidden;
    border-radius: 1.4rem;
    border: 1px solid rgba(18, 55, 82, 0.08);
    background: rgba(255, 255, 255, 0.92);
    box-shadow: 0 16px 36px rgba(12, 20, 38, 0.08);
}

.card-head,
.table-head {
    display: flex;
    justify-content: space-between;
    gap: 1rem;
    align-items: center;
    padding: 1.1rem 1.2rem;
    border-bottom: 1px solid rgba(18, 55, 82, 0.08);
    background: linear-gradient(180deg, rgba(248, 250, 252, 0.92), rgba(243, 248, 252, 0.92));
}

.card-head h3,
.table-head h3 {
    color: var(--text-main);
    font-size: 1.05rem;
}

.card-badge,
.table-count {
    border-radius: 999px;
    padding: 0.45rem 0.8rem;
    background: rgba(43, 138, 200, 0.1);
    color: #205372;
    font-weight: 800;
    font-size: 0.78rem;
    margin-bottom: 0;
}

.main-form {
    padding: 1.2rem;
}

.form-row {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 0.9rem;
    margin-bottom: 0.95rem;
}

.span-2 {
    grid-column: 1 / -1;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 0.45rem;
}

label {
    font-size: 0.76rem;
    font-weight: 800;
    letter-spacing: 0.03em;
    color: #58738a;
    text-transform: uppercase;
}

input {
    width: 100%;
    padding: 0.88rem 1rem;
    border: 1px solid #d9e3ec;
    border-radius: 0.9rem;
    background: #fff;
    color: var(--text-main);
    outline: none;
    transition: border-color 0.2s ease, box-shadow 0.2s ease, transform 0.2s ease;
}

input::placeholder {
    color: #8aa0b1;
}

input:focus {
    border-color: #2b8ac8;
    box-shadow: 0 0 0 4px rgba(43, 138, 200, 0.12);
}

.form-feedback {
    margin-bottom: 0.85rem;
    padding: 0.88rem 1rem;
    border-radius: 0.9rem;
    font-size: 0.92rem;
    font-weight: 700;
}

.form-feedback.error {
    background: #fff0f0;
    color: #9f2f2f;
    border: 1px solid #f4c7c7;
}

.form-feedback.success {
    background: #effbf2;
    color: #1f6b3f;
    border: 1px solid #ccecd8;
}

.action-bar {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
    margin-top: 0.25rem;
}

.btn {
    min-height: 2.8rem;
    padding: 0.78rem 1.1rem;
    border-radius: 0.95rem;
    cursor: pointer;
    border: none;
    font-weight: 800;
    transition: transform 0.18s ease, box-shadow 0.18s ease, background-color 0.18s ease;
}

.btn:hover,
.btn-action:hover {
    transform: translateY(-1px);
}

.btn-primary {
    background: linear-gradient(135deg, #123752, #2b8ac8);
    color: #fff;
    box-shadow: 0 12px 26px rgba(18, 55, 82, 0.18);
}

.btn-outline {
    background: #fff;
    color: #4f6779;
    border: 1px solid #d6e0ea;
}

.table-wrap {
    overflow-x: auto;
}

.styled-table {
    width: 100%;
    border-collapse: collapse;
}

.styled-table th {
    padding: 0.95rem 1rem;
    text-align: left;
    font-size: 0.72rem;
    letter-spacing: 0.07em;
    color: #6d8394;
    text-transform: uppercase;
    border-bottom: 1px solid #e3ebf2;
    white-space: nowrap;
}

.styled-table td {
    padding: 1rem;
    border-bottom: 1px solid #eef3f7;
    font-size: 0.92rem;
    color: #385269;
    vertical-align: middle;
}

.styled-table tbody tr:hover {
    background: rgba(43, 138, 200, 0.035);
}

.item-title {
    font-weight: 800;
    color: var(--text-main);
}

.item-subtitle {
    margin-top: 0.2rem;
    color: #73889a;
    font-size: 0.8rem;
}

.empty-state {
    text-align: center;
    color: #73889a;
    padding: 1.4rem 1rem;
}

.badge-ca,
.badge-estoque {
    display: inline-flex;
    align-items: center;
    gap: 0.35rem;
    border-radius: 999px;
    padding: 0.38rem 0.72rem;
    font-weight: 800;
    font-size: 0.8rem;
    white-space: nowrap;
}

.badge-ca {
    background: #eef5fb;
    color: #23516f;
}

.badge-estoque {
    border: 1px solid transparent;
}

.badge-estoque.baixo {
    background: #fff0f0;
    color: #a12e2e;
    border-color: #f4c7c7;
}

.badge-estoque.medio {
    background: #fff6e8;
    color: #9a681d;
    border-color: #f0d29a;
}

.badge-estoque.ok {
    background: #ecfbf1;
    color: #216642;
    border-color: #c5ebd0;
}

.stock-dot {
    width: 0.5rem;
    height: 0.5rem;
    border-radius: 999px;
    background: currentColor;
    opacity: 0.9;
}

.row-actions {
    display: inline-flex;
    gap: 0.65rem;
}

.edit,
.delete {
    border: none;
    background: transparent;
    font-weight: 800;
    cursor: pointer;
    padding: 0;
}

.edit {
    color: #2b67c0;
}

.delete {
    color: #b03434;
}

.text-center {
    text-align: center;
}

@media (max-width: 1080px) {
    .hero-metrics {
        width: 100%;
    }
}

@media (max-width: 760px) {
    .layout-shell {
        width: min(100% - 1rem, 1240px);
        margin-top: 1rem;
        margin-bottom: 1.5rem;
    }

    .hero-card,
    .card-head,
    .table-head {
        padding: 1rem;
    }

    .hero-metrics {
        grid-template-columns: 1fr;
    }

    .metric-card strong {
        font-size: 1.35rem;
    }

    .form-row {
        grid-template-columns: 1fr;
    }

    .span-2 {
        grid-column: auto;
    }

    .row-actions {
        flex-direction: column;
        gap: 0.45rem;
    }
}
</style>