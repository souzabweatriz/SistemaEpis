# 🛡️ EPICloud - Sistema de Gestao de EPIs

<div align="center">

![EPICloud Banner](public/Image/bannerWebsite.png)

**Plataforma web para controle, rastreabilidade e organizacao de Equipamentos de Protecao Individual**

[![Vue](https://img.shields.io/badge/Vue-3.5.25-42b883?style=flat-square&logo=vue.js)](https://vuejs.org/)
[![Vite](https://img.shields.io/badge/Vite-7.3.1-646cff?style=flat-square&logo=vite)](https://vitejs.dev/)
[![Vue Router](https://img.shields.io/badge/Vue_Router-4.6.4-35495e?style=flat-square&logo=vuedotjs)](https://router.vuejs.org/)
[![Supabase](https://img.shields.io/badge/Supabase-Auth_%2B_DB-3ecf8e?style=flat-square&logo=supabase)](https://supabase.com/)
[![PrimeIcons](https://img.shields.io/badge/PrimeIcons-UI_Icons-0ea5e9?style=flat-square)](https://www.npmjs.com/package/primeicons)

</div>

## 🚀 Visao Geral

O **EPICloud** e um sistema front-end construido com Vue 3 para facilitar a gestao de EPIs em empresas.

A aplicacao oferece:

- autenticacao com Supabase
- navegacao protegida para area interna
- dashboard com menu lateral
- paginas para cadastro, entregas e relatorio
- interface responsiva para desktop, tablet e mobile

## ✨ Funcionalidades Principais

### 🔐 Autenticacao e Acesso

- [x] Login com e-mail e senha
- [x] Logout com redirecionamento
- [x] Guard de rotas privadas no Vue Router
- [x] Integracao com Supabase Auth

### 📊 Dashboard

- [x] Rota pai com subrotas (`/dashboard/...`)
- [x] SideBar com navegacao interna
- [x] Modulos de:
	- cadastro/funcionario
	- entregas
	- relatorio

### 🎨 Interface

- [x] Home institucional com secoes informativas
- [x] Cards de beneficios com PrimeIcons
- [x] Footer responsivo
- [x] Layout adaptado para mobile e tablet

## 🧱 Stack do Projeto

```text
⚡ Vite            - Build tool e servidor de desenvolvimento
🟢 Vue 3           - Framework principal de interface
🧭 Vue Router      - Roteamento SPA com children routes
🧩 Supabase JS     - Autenticacao e acesso ao backend
🎯 PrimeIcons      - Biblioteca de icones
```

## 📁 Estrutura de Pastas

```text
SistemaEpis/
├── components/
│   ├── AppFooter.vue
│   ├── AppHeader.vue
│   └── SideBar.vue
├── public/
│   └── Image/
├── src/
│   ├── composables/
│   │   └── useSupabase.js
│   ├── router/
│   │   └── index.js
│   ├── views/
│   │   ├── Home.vue
│   │   ├── Login.vue
│   │   ├── Dashboard.vue
│   │   ├── Cadastro.vue
│   │   ├── EPIs.vue
│   │   ├── Setores.vue
│   │   └── Sobre.vue
│   ├── App.vue
│   ├── main.js
│   └── style.css
├── database.sql
├── index.html
├── package.json
└── vite.config.js
```

## ⚙️ Configuracao de Ambiente

Crie um arquivo `.env` na raiz do projeto com as variaveis do Supabase:

```env
VITE_SUPABASE_URL=https://SEU-PROJETO.supabase.co
VITE_SUPABASE_ANON_KEY=SUA_CHAVE_ANON
```

## 🧪 Como Executar

### 1. Instalar dependencias

```bash
npm install
```

### 2. Rodar em desenvolvimento

```bash
npm run dev
```

### 3. Gerar build

```bash
npm run build
```

### 4. Visualizar build

```bash
npm run preview
```

## 🔗 Rotas Principais

| Rota                     | Tipo      | Descricao                     |
| ------------------------ | --------- | ----------------------------- |
| `/`                      | Publica   | Pagina inicial                |
| `/login`                 | Publica   | Autenticacao                  |
| `/cadastro`              | Publica   | Cadastro de usuario           |
| `/dashboard`             | Privada   | Container principal do painel |
| `/dashboard/funcionario` | Privada   | Modulo de funcionario         |
| `/dashboard/entregas`    | Privada   | Modulo de entregas de EPI     |
| `/dashboard/relatorio`   | Privada   | Modulo de relatorio           |

## 🛠️ Script SQL

O arquivo `database.sql` contem a base inicial para estrutura de dados.

## 🤝 Contribuicao

Para contribuir:

1. Crie uma branch para sua feature
2. Faça commits pequenos e descritivos
3. Abra um Pull Request com o contexto da mudanca

## 📄 Licenca

Este projeto esta em desenvolvimento academico/prototipo.

---

<div align="center">

**EPICloud - Gestao inteligente de EPIs em nuvem**

</div>
