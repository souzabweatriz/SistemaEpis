<template>
    <div class="layout-shell">
        <header class="hero-card">
            <div class="hero-copy">
                <p class="eyebrow">Distribuição de EPIs</p>
                <h1>Registro de entregas</h1>
                <p class="hero-text">Controle quais EPIs foram entregues a cada funcionário, data e quantidade.</p>
            </div>

            <div class="hero-metrics">
                <article class="metric-card">
                    <span class="metric-label">Total de entregas</span>
                    <strong>{{ entregas.length }}</strong>
                </article>
                <article class="metric-card">
                    <span class="metric-label">Funcionários beneficiados</span>
                    <strong>{{ funcionariosUnicos }}</strong>
                </article>
            </div>
        </header>

        <main class="content-grid">
            <section class="card-form">
                <div class="card-head">
                    <div>
                        <p class="card-kicker">Registro</p>
                        <h3>Registrar entrega de EPI</h3>
                    </div>
                </div>

                <form @submit.prevent="salvar" class="main-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label>Funcionário</label>
                            <select v-model="form.id_funcionario" required class="input-field">
                                <option value="" disabled>Selecione o funcionário</option>
                                <option v-for="f in funcionarios" :key="f.id_funcionario" :value="f.id_funcionario">
                                    {{ f.nome }} ({{ f.cargo }})
                                </option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>EPI</label>
                            <select v-model="form.id_epi" required class="input-field">
                                <option value="" disabled>Selecione o EPI</option>
                                <option v-for="e in epis" :key="e.id_epi" :value="e.id_epi">
                                    {{ e.nome }} ({{ e.numero_ca }})
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Quantidade</label>
                            <input v-model="form.quantidade" type="number" min="1" step="1" placeholder="Ex: 1" required class="input-field">
                        </div>
                        <div class="form-group">
                            <label>Data da entrega</label>
                            <input v-model="form.data_entrega" type="date" required class="input-field">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group span-2">
                            <label>Observações (opcional)</label>
                            <input v-model="form.observacoes" type="text" placeholder="Ex: Entregue no turno da manhã" class="input-field">
                        </div>
                    </div>

                    <p v-if="mensagemErro" class="form-feedback error">{{ mensagemErro }}</p>
                    <p v-if="mensagemSucesso" class="form-feedback success">{{ mensagemSucesso }}</p>

                    <div class="action-bar">
                        <button type="submit" class="btn btn-primary">Registrar entrega</button>
                    </div>
                </form>
            </section>

            <section class="card-table">
                <div class="table-head">
                    <div>
                        <p class="card-kicker">Lista</p>
                        <h3>Entregas realizadas</h3>
                    </div>
                    <span class="table-count">{{ entregas.length }} registros</span>
                </div>

                <div class="table-wrap">
                    <table class="styled-table">
                        <thead>
                            <tr>
                                <th>Funcionário</th>
                                <th>EPI</th>
                                <th>Quantidade</th>
                                <th>Data da entrega</th>
                                <th>Observações</th>
                                <th class="text-center">Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-if="entregas.length === 0">
                                <td colspan="6" class="empty-state">Nenhuma entrega registrada.</td>
                            </tr>
                            <tr v-for="e in entregas" :key="e.id_entrega">
                                <td><span class="text-bold">{{ getNomeFuncionario(e.id_funcionario) }}</span></td>
                                <td><span class="badge-epi">{{ getNomeEpi(e.id_epi) }}</span></td>
                                <td><span class="badge-quantidade">{{ e.quantidade }}</span></td>
                                <td>{{ formatarData(e.data_entrega) }}</td>
                                <td>{{ e.observacoes || '-' }}</td>
                                <td class="text-center">
                                    <button @click="excluir(e.id_entrega)" class="btn-action delete">Excluir</button>
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
import { ref, reactive, computed, onMounted } from 'vue'
import { useSupabase } from '../composables/useSupabase'

const { supabase } = useSupabase()

const funcionarios = ref([])
const epis = ref([])
const entregas = ref([])
const mensagemErro = ref('')
const mensagemSucesso = ref('')

const form = reactive({
    id_funcionario: '',
    id_epi: '',
    quantidade: '',
    data_entrega: '',
    observacoes: ''
})

const funcionariosUnicos = computed(() => {
    return new Set(entregas.value.map(e => e.id_funcionario)).size
})

const limparMensagens = () => {
    mensagemErro.value = ''
    mensagemSucesso.value = ''
}

const carregarDados = async () => {
    const [{ data: funcData }, { data: epiData }, { data: entregasData }] = await Promise.all([
        supabase.from('funcionarios').select('*').order('nome'),
        supabase.from('epi').select('*').order('nome'),
        supabase.from('entregas').select('*').order('data_entrega', { ascending: false })
    ])

    funcionarios.value = funcData || []
    epis.value = epiData || []
    entregas.value = entregasData || []
}

const getNomeFuncionario = (id) => {
    return funcionarios.value.find(f => f.id_funcionario === id)?.nome || 'Desconhecido'
}

const getNomeEpi = (id) => {
    return epis.value.find(e => e.id_epi === id)?.nome || 'Desconhecido'
}

const formatarData = (valor) => {
    if (!valor) return '-'
    const data = new Date(valor)
    if (Number.isNaN(data.getTime())) return '-'
    return data.toLocaleDateString('pt-BR')
}

const salvar = async () => {
    limparMensagens()

    if (!form.id_funcionario || !form.id_epi || !form.quantidade || !form.data_entrega) {
        mensagemErro.value = 'Preencha todos os campos obrigatórios.'
        return
    }

    const { error } = await supabase.from('entregas').insert([{
        id_funcionario: Number(form.id_funcionario),
        id_epi: Number(form.id_epi),
        quantidade: Number(form.quantidade),
        data_entrega: form.data_entrega,
        observacoes: form.observacoes || null
    }])

    if (error) {
        mensagemErro.value = 'Não foi possível registrar a entrega.'
        return
    }

    mensagemSucesso.value = 'Entrega registrada com sucesso.'
    form.id_funcionario = ''
    form.id_epi = ''
    form.quantidade = ''
    form.data_entrega = ''
    form.observacoes = ''
    carregarDados()
}

const excluir = async (id) => {
    if (!confirm('Deseja remover este registro?')) return

    limparMensagens()

    const { error } = await supabase.from('entregas').delete().eq('id_entrega', id)

    if (error) {
        mensagemErro.value = 'Não foi possível excluir a entrega.'
        return
    }

    mensagemSucesso.value = 'Entrega removida com sucesso.'
    carregarDados()
}

onMounted(carregarDados)
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
    color: #123752;
}

.hero-text {
    max-width: 40rem;
    color: #4a647b;
    line-height: 1.6;
}

.hero-metrics {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
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

.metric-label,
.table-count {
    display: block;
    color: #4a647b;
    font-size: 0.8rem;
    font-weight: 700;
    margin-bottom: 0.35rem;
}

.metric-card strong {
    display: block;
    font-size: 1.6rem;
    color: #123752;
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
    color: #123752;
    font-size: 1.05rem;
}

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

.input-field {
    width: 100%;
    padding: 0.88rem 1rem;
    border: 1px solid #d9e3ec;
    border-radius: 0.9rem;
    background: #fff;
    color: #123752;
    outline: none;
    transition: border-color 0.2s ease, box-shadow 0.2s ease;
    font-family: inherit;
}

.input-field:focus {
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
    transition: transform 0.18s ease, box-shadow 0.18s ease;
}

.btn:hover {
    transform: translateY(-1px);
}

.btn-primary {
    background: linear-gradient(135deg, #123752, #2b8ac8);
    color: #fff;
    box-shadow: 0 12px 26px rgba(18, 55, 82, 0.18);
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
}

.styled-table tbody tr:hover {
    background: rgba(43, 138, 200, 0.035);
}

.empty-state {
    text-align: center;
    color: #73889a;
    padding: 1.4rem 1rem;
}

.text-bold {
    font-weight: 800;
    color: #123752;
}

.badge-epi,
.badge-quantidade {
    display: inline-flex;
    align-items: center;
    border-radius: 999px;
    padding: 0.38rem 0.72rem;
    font-weight: 800;
    font-size: 0.8rem;
}

.badge-epi {
    background: #eef5fb;
    color: #23516f;
}

.badge-quantidade {
    background: #f0f7ff;
    color: #1e5f9e;
}

.btn-action {
    border: none;
    background: transparent;
    font-weight: 800;
    cursor: pointer;
    padding: 0;
    font-size: 0.82rem;
}

.btn-action.delete {
    color: #b03434;
}

.text-center {
    text-align: center;
}

@media (max-width: 760px) {
    .layout-shell {
        width: min(100% - 1rem, 980px);
        margin-top: 1rem;
        margin-bottom: 1.5rem;
    }

    .form-row {
        grid-template-columns: 1fr;
    }

    .span-2 {
        grid-column: auto;
    }

    .hero-card,
    .card-head,
    .table-head {
        padding: 1rem;
    }

    .hero-metrics {
        grid-template-columns: 1fr;
    }
}
</style>
