<div align="center">

# SQUADS
### AI Teams for Brazilian Entrepreneurs

**6 specialized squads. 18 agents. One context file.**
Your business DNA, loaded once — used by every agent, every time.

[![Agents](https://img.shields.io/badge/Agents-18-blue)](#)
[![Squads](https://img.shields.io/badge/Squads-6-purple)](#)
[![Version](https://img.shields.io/badge/Version-2.0-green)](#)
[![Language](https://img.shields.io/badge/Output-pt--BR-yellow)](#)

</div>

---

## What is this?

SQUADS gives your company a full AI team that already knows your business.

Every agent reads `~/.claude/empresa.yaml` — a single file with your company's context, ICP, product, tone of voice, financial goals, and team structure. You fill it once during installation. Every agent uses it automatically.

The result: agents that don't need to be re-briefed every conversation. They know who you are, what you sell, who your customer is, and what you're building toward.

---

## The 6 Squads

| Squad | Agents | Resolves |
|-------|--------|---------|
| `squad-comercial` | Prospecção, Proposta, Follow-up, Atendimento | More deals, with the right clients, faster |
| `squad-gestao` | Prioridade Semanal, Reunião, Estratégia, Relatório | Priority clarity and execution |
| `squad-marketing` | Conteúdo, Anúncio, Email, Pesquisa | Content that converts |
| `squad-operacoes` | Operacional, Contratação, Delegação | Business that runs without you |
| `squad-financeiro` | Análise Financeira, Precificação | Numbers that drive decisions |
| `squad-cs` | Onboarding, Atendimento, Anti-Churn | Clients that stay and grow |

---

## Installation — One Command

```bash
curl -fsSL https://raw.githubusercontent.com/lucasvalerio10/squads/main/squads/install.sh | bash
```

The installer will:
1. **Check and auto-install** all requirements (Node.js, Git, Claude Code)
2. Clone this repository to `~/.squads/`
3. Install the 6 squad skills to `~/.claude/skills/`
4. Ask questions about your business and generate your `empresa.yaml`
5. Configure Claude Code to load your context automatically

**Requirements (auto-installed if missing):**
- [Node.js LTS](https://nodejs.org) — installed automatically on Mac/Linux
- [Git](https://git-scm.com) — installed automatically on Mac/Linux
- [Claude Code](https://claude.ai/code) — installed automatically via npm
- Terminal (macOS, Linux, or Windows Git Bash)

> **Windows users:** If Git or Node.js aren't found, the installer will point you to the download page. Install them manually and re-run the installer.

---

## How to Use

After installation, open any terminal and start Claude Code:

```bash
claude
```

Then just describe what you need in Portuguese:

```
"Preciso prospectar donos de clínicas odontológicas em SP"
"Tenho uma reunião bagunçada — aqui as notas: [cole aqui]"
"Meus números do mês: faturei X, gastei Y"
"Lead sumiu após a proposta — o que fazer?"
"Novo cliente fechou — cria o plano de onboarding"
"Quero parar de fazer essas tarefas: [lista]"
```

The right agent activates automatically. No commands to memorize.

---

## How It Works

### v2.0 — SKILL.md Architecture (Official Claude Code Standard)

Each squad is a `SKILL.md` file installed at `~/.claude/skills/[squad-name]/SKILL.md`.

This is the official Claude Code skills standard. It means:
- Skills are loaded **on-demand** — only when relevant, keeping context lean
- **Natural language activation** — Claude reads the intent and routes to the right agent
- **No commands required** — describe the problem, the agent activates
- **Compatible** with future Claude Code updates

### The empresa.yaml File

Located at `~/.claude/empresa.yaml`. Editable at any time.

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
  palavras_proibidas:
    - "sinergia"
    - "solução"

financeiro:
  metas:
    mrr_atual: "R$ 30.000"
    mrr_meta: "R$ 80.000"
    prazo_meta: "Dezembro 2025"

metas_trimestre:
  foco_principal: "Dobrar MRR passando de 30k para 60k"
```

Every agent reads this. Every agent uses it. Configure once, use forever.

---

## Squad Details

### Squad Comercial — Sales Team
**Resolves:** Close more deals, with the right clients, faster.

| Agent | Frameworks | What it delivers |
|-------|-----------|-----------------|
| Prospecção | Predictable Revenue, Cold Email (Josh Braun), BANT | ICP profile, outreach sequence, full cadence |
| Proposta Comercial | MEDDIC, SPIN Selling, Challenger Sale | Personalized proposal with value anchor |
| Follow-up | Fanatical Prospecting (Blount), Value Follow-Up (Jason Bay) | Silence diagnosis, messages by channel, breakup message |
| Atendimento | LAER (Challenger Sale), Harvard Negotiation, Gainsight CS | Interaction classification, LAER response, next steps |

### Squad Gestão — Management Team
**Resolves:** Priority clarity, meetings that generate results, strategic decisions.

| Agent | Frameworks | What it delivers |
|-------|-----------|-----------------|
| Prioridade Semanal | Eisenhower Matrix, 80/20, OKR, GTD | Max 3 red priorities, elimination list, first action today |
| Reunião | Structured Extraction, Accountability Mapping | One-message ata ready for WhatsApp/Slack |
| Estratégia | First Principles, Inversion (Munger), Amazon Type 1/2 | Root cause analysis, one clear recommendation |
| Relatório Semanal | KPI Dashboard, Variance Analysis, OKR Tracking | Executive report with metrics vs targets |

### Squad Marketing — Marketing Team
**Resolves:** Content that converts, ads that qualify, research that informs.

| Agent | Frameworks | What it delivers |
|-------|-----------|-----------------|
| Conteúdo | Awareness Stages (Schwartz), Psychological Copy Stack | Reels, carrossel, caption, stories, email |
| Copy de Anúncio | Breakthrough Advertising, CopyHackers, Foxwell | 3 A/B/C variants + testing protocol |
| Email Marketing | Soap Opera Sequence, Email Players, Lifecycle System | Full sequence with behavioral segmentation |
| Pesquisa de Mercado | Jobs to Be Done, McGrath Opportunity Analysis | Competitive intelligence, JTBD map |

### Squad Operações — Operations Team
**Resolves:** Owner-dependent business, inconsistent processes, wrong hires.

| Agent | Frameworks | What it delivers |
|-------|-----------|-----------------|
| Operacional (COO) | Theory of Constraints, BPM, EOS/Traction | Bottleneck identified, process redesigned, one move this week |
| Contratação | Topgrading, STAR, Culture Add | Role scorecard, interview script, decision criteria |
| Delegação | Delegation Poker, Mochary Leverage, EOS | Audit classified, top 3 delegations with handoff scripts |

### Squad Financeiro — Financial Team
**Resolves:** Lack of clarity in numbers, wrong pricing, decisions without data.

| Agent | Frameworks | What it delivers |
|-------|-----------|-----------------|
| Análise Financeira (CFO) | CFO Lens, 80/20 Revenue, Anomaly Detection | Dashboard vs targets, anomalies flagged, one decision |
| Precificação | Value-Based Pricing (Nagle), Ariely, ProfitWell | Value analysis, tiered structure, price increase script |

### Squad CS — Customer Success Team
**Resolves:** Churn, clients who don't reach results, weak onboarding.

| Agent | Frameworks | What it delivers |
|-------|-----------|-----------------|
| Onboarding | Lincoln Murphy, JTBD (CS), First Value Moment | 30-day plan day-by-day, FVM definition, messages ready to send |
| Atendimento | LAER, Harvard Negotiation, Gainsight CS | LAER response, churn risk classification, next steps |
| Anti-Churn | Net Revenue Retention, Health Scoring, Churn Autopsy | Risk matrix, root cause, proactive intervention, elegant exit |

---

## Repository Structure

```
squads/
├── install.sh                        ← One-command installer (v2.0)
├── empresa.yaml (template)           ← Template — filled during installation
├── CLAUDE.md                         ← Claude Code global configuration
├── README.md                         ← This file
│
├── squad-comercial/
│   ├── SKILL.md                      ← Squad skill (boot sequence + 4 agents + protocols)
│   └── agents/
│       ├── prospeccao.md
│       ├── proposta-comercial.md
│       ├── follow-up.md
│       └── atendimento.md
│
├── squad-gestao/
│   ├── SKILL.md
│   └── agents/
│       ├── prioridade-semanal.md
│       ├── reuniao.md
│       ├── estrategico-pessoal.md
│       └── relatorio-semanal.md
│
├── squad-marketing/
│   ├── SKILL.md
│   └── agents/
│       ├── conteudo.md
│       ├── copy-anuncio.md
│       ├── email-marketing.md
│       └── pesquisa-mercado.md
│
├── squad-operacoes/
│   ├── SKILL.md
│   └── agents/
│       ├── operacional.md
│       ├── contratacao.md
│       └── delegacao.md
│
├── squad-financeiro/
│   ├── SKILL.md
│   └── agents/
│       ├── analise-financeira.md
│       └── precificacao.md
│
└── squad-cs/
    ├── SKILL.md
    └── agents/
        ├── onboarding-cliente.md
        ├── atendimento.md
        └── anti-churn.md
```

---

## Updating

```bash
cd ~/.squads && git pull origin main
```

Skills are updated automatically from the repository.

---

## What Changed in v2.0

| | v1.0 | v2.0 |
|--|------|------|
| Install | curl \| bash (manual prereqs) | curl \| bash (auto-installs everything) |
| Skill format | Custom CLAUDE.md routing | Official SKILL.md standard |
| Skills location | `~/.squads/squads/` | `~/.claude/skills/` (Claude Code native) |
| Activation | Commands like `/squad-x:agente` | Natural language — describe the problem |
| Context file | `~/.squads/squads/empresa.yaml` | `~/.claude/empresa.yaml` |
| Agent depth | Individual .md files | Full engines with Python reasoning blocks |

---

## License

MIT — use, modify, and distribute freely.

---

<div align="center">
Built for Brazilian entrepreneurs who are done doing everything alone.
</div>
