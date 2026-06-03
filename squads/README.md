<div align="center">

# SQUADS
### AI Teams for Brazilian Entrepreneurs

**6 specialized squads. 18 agents. One context file.**
Your business DNA, loaded once — used by every agent, every time.

[![Agents](https://img.shields.io/badge/Agents-18-blue)](#)
[![Squads](https://img.shields.io/badge/Squads-6-purple)](#)
[![Workflows](https://img.shields.io/badge/Workflows-12-green)](#)
[![Language](https://img.shields.io/badge/Output-pt--BR-yellow)](#)

</div>

---

## What is this?

SQUADS gives your company a full AI team that already knows your business.

Every agent reads `~/.squads/empresa.yaml` — a single file with your company's context, ICP, product, tone of voice, financial goals, and team structure. You fill it once during installation. Every agent uses it automatically.

The result: agents that don't need to be re-briefed every conversation. They know who you are, what you sell, who your customer is, and what you're building toward.

---

## The 6 Squads

| Squad | Agents | Solves |
|-------|--------|--------|
| `squad-comercial` | Prospecção, Proposta, Follow-up, Atendimento | More deals, faster |
| `squad-gestao` | Prioridade Semanal, Reunião, Estratégia, Relatório | Clarity and execution |
| `squad-marketing` | Conteúdo, Anúncio, Email, Pesquisa | Content that converts |
| `squad-operacoes` | Operacional, Contratação, Delegação | Business that runs without you |
| `squad-financeiro` | Análise Financeira, Precificação | Numbers that drive decisions |
| `squad-cs` | Onboarding, Atendimento, Anti-Churn | Clients that stay and grow |

---

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/lucasvalerio10/squads/main/install.sh | bash
```

The installer will:
1. Check requirements (Git + Claude Code CLI)
2. Clone this repository to `~/.squads/`
3. Ask 12 questions about your business
4. Generate your `empresa.yaml` context file
5. Configure Claude Code to load your context automatically

**Requirements:**
- [Claude Code](https://claude.ai/code) (`npm install -g @anthropic-ai/claude-code`)
- Git
- Terminal (macOS, Linux, or Windows WSL)

---

## How to Use

After installation, open any project folder and start Claude Code:

```bash
cd ~/my-project
claude
```

Then activate any agent:

```bash
# Sales
/squad-comercial:prospeccao gerar-perfil
/squad-comercial:proposta [cliente] [produto] [contexto]
/squad-comercial:followup [situação]

# Management
/squad-gestao:prioridade
/squad-gestao:reuniao [cole o conteúdo]
/squad-gestao:estrategia [decisão ou dilema]
/squad-gestao:relatorio [cole os dados]

# Marketing
/squad-marketing:conteudo reels [ideia]
/squad-marketing:anuncio [produto] [objetivo]
/squad-marketing:email boas-vindas

# Operations
/squad-operacoes:operacional [processo]
/squad-operacoes:contratacao [cargo]
/squad-operacoes:delegacao auditoria

# Finance
/squad-financeiro:analise [cole os dados]
/squad-financeiro:preco analise

# Customer Success
/squad-cs:onboarding [produto]
/squad-cs:churn [situação]
```

---

## The empresa.yaml File

Located at `~/.squads/empresa.yaml`. Edit anytime.

```yaml
empresa:
  nome: "Sua Empresa"
  segmento: "SaaS B2B"

produto:
  nome: "Seu Produto"
  ticket_medio: "R$ 1.200"

cliente_ideal:
  perfil: "Donos de agências digitais com 5-20 colaboradores"
  dores_principais:
    - "Processos manuais que dependem do dono"

posicionamento:
  tom_de_voz: "direto, próximo, sem enrolação"

financeiro:
  metas:
    mrr_atual: "R$ 30.000"
    mrr_meta: "R$ 80.000"
    prazo_meta: "Dezembro 2025"

metas_trimestre:
  foco_principal: "Dobrar MRR passando de 30k para 60k"
```

Every agent reads this. Every agent uses it. You configure it once.

---

## Frameworks Used

Each agent is built on proven methodologies:

| Agent | Frameworks |
|-------|-----------|
| Prospecção | Aaron Ross (Predictable Revenue), Josh Braun, BANT |
| Proposta Comercial | MEDDIC, SPIN Selling, Challenger Sale |
| Follow-up | Jeb Blount, Jason Bay, Pipeline Velocity |
| Atendimento | LAER, Harvard Negotiation, Gainsight CS |
| Prioridade Semanal | Eisenhower Matrix, 80/20, OKR, GTD |
| Reunião | Structured Extraction, Accountability Mapping |
| Estratégia | First Principles, Inversion (Munger), Strategic Choice Cascade |
| Relatório | KPI Dashboard, Variance Analysis, OKR Tracking |
| Conteúdo | Eugene Schwartz Awareness, Consumer Psychology |
| Anúncio | Breakthrough Advertising, CopyHackers, A/B Testing |
| Email | Soap Opera Sequence, Email Players, Lifecycle System |
| Pesquisa | Jobs to Be Done, Competitive Intelligence |
| Operacional | Theory of Constraints, BPM, EOS/Traction |
| Contratação | Topgrading, STAR, Culture Add |
| Delegação | Delegation Poker, Mochary Leverage |
| Análise Financeira | CFO Lens, 80/20 Revenue, Anomaly Detection |
| Precificação | Value-Based Pricing, Ariely Psychology |
| Onboarding CS | Lincoln Murphy, JTBD, First Value Moment |
| Anti-Churn | NRR Framework, Health Scoring, Churn Autopsy |

---

## Update

```bash
cd ~/.squads && git pull origin main
```

---

## License

MIT — use, modify, and distribute freely.

---

<div align="center">
Built for Brazilian entrepreneurs who are done doing everything alone.
</div>
