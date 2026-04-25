<template>
    <main class="cadastro-page">
        <section class="form-panel">
            <div class="form-card">
                <p class="eyebrow">Controle de efetivo</p>
                <h2>{{ editandoId ? 'Alterar registro de funcionario' : 'Novo funcionario' }}</h2>
                <p class="subtitle">Cadastre os dados do funcionario conforme a base do Supabase.</p>

                <form class="auth-form" @submit.prevent="salvar">
                    <div class="form-row">
                        <label class="input-func">
                            Nome completo
                            <input class="input-field" v-model="form.nome" type="text" placeholder="Digite o nome"
                                required />
                        </label>

                        <label class="input-func">
                            E-mail
                            <input class="input-field" v-model="form.email" type="email" placeholder="nome@empresa.com"
                                required />
                        </label>
                    </div>

                    <div class="form-row">
                        <label class="input-func">
                            Cargo
                            <input class="input-field" v-model="form.cargo" type="text"
                                placeholder="Ex: Analista de segurança" required />
                        </label>

                        <label class="input-func">
                            Departamento
                            <select class="input-field" v-model="form.id_departamento" required>
                                <option value="" disabled>Selecione o departamento</option>
                                <option v-for="departamento in departamentos" :key="departamento.id_departamento"
                                    :value="departamento.id_departamento">
                                    {{ departamento.nome_departamento }}
                                </option>
                            </select>
                        </label>
                    </div>

                    <div class="form-row">
                        <label class="input-func">
                            Data de nascimento
                            <input class="input-field" v-model="form.data_nascimento" type="date" required />
                        </label>

                        <label class="input-func">
                            Senha
                            <div class="password-field">
                                <input class="input-field" v-model="form.senha" :type="mostrarSenha ? 'text' : 'password'"
                                    placeholder="Minimo 6 caracteres" required minlength="6" />
                                <button class="password-toggle" type="button" @click="mostrarSenha = !mostrarSenha"
                                    :aria-label="mostrarSenha ? 'Ocultar senha' : 'Mostrar senha'">
                                    <i class="pi" :class="mostrarSenha ? 'pi-eye-slash' : 'pi-eye'"></i>
                                </button>
                            </div>
                        </label>
                    </div>

                    <div class="form-row">
                        <label class="input-func">
                            URL da foto (opcional)
                            <input class="input-field" v-model="form.foto" type="text" placeholder="https://..." />
                        </label>
                    </div>

                    <div class="actions-row">
                        <button class="label-btn" type="submit" :disabled="loading">
                            {{ loading ? 'Salvando...' : (editandoId ? 'Atualizar dados' : 'Finalizar cadastro') }}
                        </button>
                        <button class="ghost-btn" type="button" @click="cancelarEdicao">
                            {{ editandoId ? 'Cancelar' : 'Limpar' }}
                        </button>
                    </div>
                </form>

                <p v-if="message" class="status-message" :class="messageType">{{ message }}</p>

                <p class="helper-note">Dica: ao criar um novo funcionario, confirme o departamento correto antes de
                    salvar.</p>
            </div>

            <div class="table-card">
                <div class="table-header">
                    <h3>Funcionarios cadastrados</h3>
                </div>

                <div class="table-wrap">
                    <table class="styled-table">
                        <thead>
                            <tr>
                                <th>Colaborador</th>
                                <th>E-mail</th>
                                <th>Cargo / Departamento</th>
                                <th>Nascimento</th>
                                <th class="text-center">Gerenciar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-if="!funcionarios.length">
                                <td colspan="5" class="empty-row">Nenhum funcionario cadastrado ainda.</td>
                            </tr>
                            <tr v-for="f in funcionarios" :key="getRowId(f)">
                                <td><span class="text-bold">{{ f.nome }}</span></td>
                                <td>{{ f.email }}</td>
                                <td>
                                    <span class="badge">{{ getDepartamentoNome(f.id_departamento) }}</span>
                                    <span class="cargo-text">{{ f.cargo }}</span>
                                </td>
                                <td>{{ f.data_nascimento }}</td>
                                <td class="text-center">
                                    <button @click="prepararEdicao(f)" class="btn-action edit">Editar</button>
                                    <button @click="excluir(getRowId(f))" class="btn-action delete">Excluir</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
    </main>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useSupabase } from '../composables/useSupabase.js'

const { supabase } = useSupabase()

const loading = ref(false)
const message = ref('')
const messageType = ref('')
const funcionarios = ref([])
const departamentos = ref([])
const editandoId = ref(null)
const idColumn = ref('id')
const mostrarSenha = ref(false)

const form = reactive({
    nome: '',
    cargo: '',
    email: '',
    senha: '',
    data_nascimento: '',
    id_departamento: '',
    foto: ''
})

function limparForm() {
    Object.assign(form, {
        nome: '',
        cargo: '',
        email: '',
        senha: '',
        data_nascimento: '',
        id_departamento: '',
        foto: ''
    })
    mostrarSenha.value = false
    message.value = ''
    messageType.value = ''
}

async function carregar() {
    const { data, error } = await supabase
        .from('funcionarios')
        .select('*')
        .order('nome', { ascending: true })

    if (error) {
        message.value = 'Erro ao carregar funcionarios.'
        messageType.value = 'error'
        return
    }

    if (data?.length) {
        const firstRow = data[0]
        if ('id' in firstRow) {
            idColumn.value = 'id'
        } else if ('id_funcionario' in firstRow) {
            idColumn.value = 'id_funcionario'
        }
    }

    funcionarios.value = data || []
}

async function carregarDepartamentos() {
    const { data, error } = await supabase
        .from('departamento')
        .select('id_departamento, nome_departamento')
        .order('id_departamento', { ascending: true })

    if (error) {
        message.value = 'Erro ao carregar departamentos.'
        messageType.value = 'error'
        return
    }

    departamentos.value = data || []
}

function getRowId(row) {
    return row?.id ?? row?.id_funcionario ?? null
}

function getDepartamentoNome(idDepartamento) {
    if (!idDepartamento) {
        return 'Departamento'
    }

    const departamento = departamentos.value.find((item) => String(item.id_departamento) === String(idDepartamento))

    return departamento?.nome_departamento || 'Departamento'
}

function cancelarEdicao() {
    editandoId.value = null
    limparForm()
}

function prepararEdicao(funcionario) {
    editandoId.value = getRowId(funcionario)
    Object.assign(form, {
        nome: funcionario.nome || '',
        cargo: funcionario.cargo || '',
        email: funcionario.email || '',
        senha: funcionario.senha || '',
        data_nascimento: funcionario.data_nascimento || '',
        id_departamento: funcionario.id_departamento ?? '',
        foto: funcionario.foto || ''
    })
    mostrarSenha.value = false
}

async function salvar() {
    loading.value = true
    message.value = ''
    messageType.value = ''

    if (editandoId.value) {
        const { error: updateError } = await supabase
            .from('funcionarios')
            .update({
                nome: form.nome,
                cargo: form.cargo,
                email: form.email,
                senha: form.senha,
                data_nascimento: form.data_nascimento,
                id_departamento: form.id_departamento || null,
                foto: form.foto || null
            })
            .eq(idColumn.value, editandoId.value)

        loading.value = false

        if (updateError) {
            message.value = `Nao foi possivel atualizar o cadastro. (${updateError.message})`
            messageType.value = 'error'
            return
        }

        message.value = 'Cadastro atualizado com sucesso.'
        messageType.value = 'success'
        await carregar()
        cancelarEdicao()
        return
    }

    const { error: insertError } = await supabase.from('funcionarios').insert([
        {
            nome: form.nome,
            cargo: form.cargo,
            email: form.email,
            senha: form.senha,
            data_nascimento: form.data_nascimento,
            id_departamento: form.id_departamento || null,
            foto: form.foto || null
        }
    ])

    loading.value = false

    if (insertError) {
        message.value = 'A conta foi criada, mas houve falha ao salvar dados do funcionario.'
        messageType.value = 'error'
        return
    }

    message.value = 'Funcionario cadastrado com sucesso. Compartilhe as credenciais com ele.'
    messageType.value = 'success'
    limparForm()
    await carregar()
}

async function excluir(id) {
    if (!confirm('Deseja realmente remover este registro?')) {
        return
    }

    if (!id) {
        message.value = 'Nao foi possivel identificar o registro para exclusao.'
        messageType.value = 'error'
        return
    }

    const { error } = await supabase.from('funcionarios').delete().eq(idColumn.value, id)

    if (error) {
        message.value = `Nao foi possivel excluir o funcionario. (${error.message})`
        messageType.value = 'error'
        return
    }

    message.value = 'Funcionario removido com sucesso.'
    messageType.value = 'success'
    await carregar()
}

onMounted(carregar)
onMounted(carregarDepartamentos)
</script>

<style scoped>
.cadastro-page {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    padding-top: 1.5rem;
    padding-bottom: 1.5rem;
    background:
        radial-gradient(circle at 6% 12%, rgba(26, 83, 92, 0.16), transparent 35%),
        radial-gradient(circle at 96% 92%, rgba(43, 138, 200, 0.16), transparent 33%),
        linear-gradient(155deg, #edf4f9 0%, #f3f8fc 52%, #eaf2f8 100%);
}

.form-panel {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    gap: 1rem;
    align-items: center;
    justify-content: center;
}

.form-card {
    width: 76%;
    height: auto;
    border-radius: 1rem;
    border: 0.0625rem solid rgba(18, 55, 82, 0.1);
    background: rgba(255, 255, 255, 0.88);
    box-shadow: 0 1.25rem 2.25rem rgba(18, 55, 82, 0.12);
    backdrop-filter: blur(0.5rem);
    -webkit-backdrop-filter: blur(0.5rem);
    padding: 2rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 1rem;
}

.eyebrow {
    margin: 0;
    font-size: 0.8rem;
    letter-spacing: 0.08rem;
    text-transform: uppercase;
    color: #0b6b7d;
    font-weight: 800;
}

h2 {
    margin: 0;
    color: #123752;
    font-size: 2rem;
}

.subtitle {
    margin: 0;
    color: #466179;
    line-height: 1.45;
}

.auth-form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.form-row {
    width: 100%;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0.8rem;
}

.form-row:has(.input-func:only-child) {
    grid-template-columns: 1fr;
}

.input-func {
    display: flex;
    flex-direction: column;
    gap: 0.4rem;
    color: #173e59;
    font-size: 0.9rem;
    font-weight: 700;
}

.input-field {
    width: 100%;
    height: 2.8rem;
    border-radius: 0.78rem;
    border: 0.0625rem solid #c5dbe8;
    background: #fcfeff;
    padding: 0.65rem 0.75rem;
    color: #123752;
    outline: none;
    transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.password-field {
    position: relative;
    width: 100%;
}

.password-field .input-field {
    padding-right: 2.8rem;
}

.password-toggle {
    position: absolute;
    right: 0.7rem;
    top: 50%;
    transform: translateY(-50%);
    width: 2rem;
    height: 2rem;
    border: none;
    background: transparent;
    color: #5f6775;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
}

.password-toggle i {
    font-size: 1rem;
}

.password-toggle:hover {
    color: #123752;
}

select.input-field {
    background: #fcfeff;
}

.input-field:focus {
    border-color: #2b8ac8;
    box-shadow: 0 0 0 0.2rem rgba(43, 138, 200, 0.14);
}

.actions-row {
    display: flex;
    gap: 0.65rem;
    flex-wrap: wrap;
}

.label-btn,
.ghost-btn {
    height: 2.7rem;
    border-radius: 0.9rem;
    padding: 0 1.1rem;
    border: none;
    cursor: pointer;
    font-size: 0.9rem;
    font-weight: 700;
}

.label-btn {
    flex: 1;
    width: 70%;
    background: linear-gradient(135deg, #1A535C 0%, #2b8ac8 100%);
    color: #f5fbff;
}

.label-btn:disabled {
    opacity: 0.75;
    cursor: not-allowed;
}

.ghost-btn {
    width: 28%;
    background: #eef5fb;
    color: #123752;
    border: 0.0625rem solid #c9dbe8;
}

.status-message {
    margin: 0;
    border-radius: 0.75rem;
    padding: 0.7rem 0.8rem;
    font-size: 0.9rem;
    line-height: 1.4;
}

.status-message.success {
    background: rgba(39, 174, 96, 0.12);
    color: #1c7a46;
    border: 0.0625rem solid rgba(39, 174, 96, 0.35);
}

.status-message.error {
    background: rgba(194, 66, 66, 0.12);
    color: #a52c2c;
    border: 0.0625rem solid rgba(194, 66, 66, 0.35);
}

.helper-note {
    margin: 0;
    color: #3f5f78;
    font-size: 0.85rem;
}

.table-card {
    width: 76%;
    height: auto;
    border-radius: 1rem;
    border: 0.0625rem solid rgba(18, 55, 82, 0.1);
    background: rgba(255, 255, 255, 0.88);
    box-shadow: 0 1.25rem 2.25rem rgba(18, 55, 82, 0.12);
    overflow: hidden;
}

.table-header {
    width: 100%;
    height: 3.2rem;
    display: flex;
    align-items: center;
    padding: 0 1.2rem;
    background: #f2f7fb;
    border-bottom: 0.0625rem solid #d7e4ee;
}

.table-header h3 {
    margin: 0;
    color: #123752;
    font-size: 1rem;
}

.table-wrap {
    width: 100%;
    overflow-x: auto;
}

.styled-table {
    width: 100%;
    border-collapse: collapse;
}

.styled-table th {
    text-align: left;
    font-size: 0.75rem;
    color: #5b758c;
    text-transform: uppercase;
    letter-spacing: 0.05rem;
    padding: 0.9rem 1.2rem;
    background: #f8fbfd;
}

.styled-table td {
    padding: 0.95rem 1.2rem;
    border-top: 0.0625rem solid #ecf2f7;
    font-size: 0.9rem;
    color: #35566f;
}

.text-bold {
    font-weight: 700;
    color: #183f5c;
}

.badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0.28rem 0.62rem;
    border-radius: 99rem;
    background: #def3ea;
    color: #1b7c51;
    font-size: 0.72rem;
    font-weight: 700;
    margin-right: 0.45rem;
}

.cargo-text {
    color: #5b758c;
    font-size: 0.82rem;
}

.btn-action {
    border: none;
    background: transparent;
    font-size: 0.82rem;
    font-weight: 700;
    cursor: pointer;
}

.btn-action.edit {
    color: #2b8ac8;
    margin-right: 0.65rem;
}

.btn-action.delete {
    color: #b53a3a;
}

.text-center {
    text-align: center;
}

.empty-row {
    text-align: center;
    color: #5b758c;
}

@media (max-width: 67.5rem) {
    .form-panel {
        width: 100%;
        height: auto;
    }

    .form-card,
    .table-card {
        width: 92%;
        height: auto;
    }

    .form-row {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 40rem) {
    .form-card {
        padding: 1.2rem;
        border-radius: 0.9rem;
    }

    .actions-row {
        flex-direction: column;
    }

    .label-btn,
    .ghost-btn {
        width: 100%;
    }
}
</style>