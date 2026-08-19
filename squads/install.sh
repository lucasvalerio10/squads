#!/bin/bash

# ============================================================
#  SQUADS — Instalador v2.0
#  Times de IA para Empresários
#  github.com/lucasvalerio10/squads
# ============================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

SQUADS_DIR="$HOME/.squads"
SKILLS_DIR="$HOME/.claude/skills"
REPO_URL="https://github.com/lucasvalerio10/squads"

print_header() {
  clear
  echo ""
  echo -e "${BOLD}=================================================${NC}"
  echo -e "${BOLD}  SQUADS — Times de IA para sua empresa  ${NC}"
  echo -e "${BOLD}=================================================${NC}"
  echo ""
}

print_step() { echo -e "${BLUE}▶ $1${NC}"; }
print_ok()   { echo -e "${GREEN}✓ $1${NC}"; }
print_warn() { echo -e "${YELLOW}⚠ $1${NC}"; }
print_error(){ echo -e "${RED}✗ $1${NC}"; }

ask() {
  local prompt="$1" default="$2" answer
  if [ -n "$default" ]; then
    read -p "$(echo -e "${BOLD}${prompt}${NC} [${default}]: ")" answer
    echo "${answer:-$default}"
  else
    read -p "$(echo -e "${BOLD}${prompt}${NC}: ")" answer
    echo "$answer"
  fi
}

# ============================================================
# VERIFICAÇÃO E INSTALAÇÃO AUTOMÁTICA DE PRÉ-REQUISITOS
# ============================================================

detect_os() {
  if [[ "$OSTYPE" == "darwin"* ]]; then echo "mac"
  elif [[ "$OSTYPE" == "msys"* ]] || [[ "$OSTYPE" == "cygwin"* ]]; then echo "windows"
  else echo "linux"
  fi
}

install_node() {
  local os=$(detect_os)
  print_warn "Node.js não encontrado. Instalando automaticamente..."

  if [ "$os" = "mac" ]; then
    if command -v brew &>/dev/null; then
      brew install node
    else
      print_warn "Homebrew não encontrado. Instalando Homebrew primeiro..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      brew install node
    fi
  elif [ "$os" = "linux" ]; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
  else
    print_error "No Windows, instale o Node.js manualmente em: https://nodejs.org"
    print_error "Depois reabra o Git Bash e rode o instalador novamente."
    exit 1
  fi
}

install_git() {
  local os=$(detect_os)
  print_warn "Git não encontrado. Instalando automaticamente..."

  if [ "$os" = "mac" ]; then
    xcode-select --install 2>/dev/null || true
  elif [ "$os" = "linux" ]; then
    sudo apt-get install -y git
  else
    print_error "No Windows, instale o Git em: https://git-scm.com"
    print_error "Depois reabra o Git Bash e rode o instalador novamente."
    exit 1
  fi
}

install_claude_code() {
  print_warn "Claude Code não encontrado. Instalando..."
  npm install -g @anthropic-ai/claude-code
  print_ok "Claude Code instalado"
}

check_and_install_requirements() {
  print_step "Verificando e instalando pré-requisitos..."
  echo ""

  # Node.js
  if command -v node &>/dev/null; then
    local node_version=$(node --version)
    print_ok "Node.js $node_version"
  else
    install_node
    if command -v node &>/dev/null; then
      print_ok "Node.js instalado com sucesso"
    else
      print_error "Falha ao instalar Node.js. Instale manualmente em https://nodejs.org"
      exit 1
    fi
  fi

  # Git
  if command -v git &>/dev/null; then
    print_ok "Git $(git --version | awk '{print $3}')"
  else
    install_git
    if command -v git &>/dev/null; then
      print_ok "Git instalado com sucesso"
    else
      print_error "Falha ao instalar Git. Instale manualmente em https://git-scm.com"
      exit 1
    fi
  fi

  # Claude Code
  if command -v claude &>/dev/null; then
    print_ok "Claude Code instalado"
  else
    install_claude_code
  fi

  echo ""
  print_ok "Todos os pré-requisitos prontos"
  echo ""
}

# ============================================================
# DOWNLOAD DOS SQUADS
# ============================================================

download_squads() {
  print_step "Baixando Squads do GitHub..."

  if [ -d "$SQUADS_DIR" ]; then
    print_warn "Instalação anterior encontrada. Atualizando..."
    cd "$SQUADS_DIR" && git pull origin main --quiet
    print_ok "Squads atualizados"
  else
    git clone "$REPO_URL.git" "$SQUADS_DIR" --quiet
    print_ok "Squads baixados para $SQUADS_DIR"
  fi
}

# ============================================================
# INSTALAÇÃO DAS SKILLS (padrão SKILL.md oficial)
# ============================================================

install_skills() {
  print_step "Instalando skills no Claude Code..."

  mkdir -p "$SKILLS_DIR"

  # Copia cada squad como uma skill
  local squads=("squad-comercial" "squad-gestao" "squad-marketing" "squad-operacoes" "squad-financeiro" "squad-cs")

  for squad in "${squads[@]}"; do
    local src="$SQUADS_DIR/squads/$squad"
    local dst="$SKILLS_DIR/$squad"

    if [ -d "$src" ]; then
      cp -r "$src" "$dst"
      print_ok "Skill instalada: $squad"
    fi
  done

  # Copia empresa.yaml para local acessível
  cp "$SQUADS_DIR/squads/empresa.yaml" "$HOME/.claude/empresa.yaml" 2>/dev/null || true
}

# ============================================================
# CONFIGURAÇÃO DA EMPRESA
# ============================================================

configure_empresa() {
  echo ""
  echo -e "${BOLD}=================================================${NC}"
  echo -e "${BOLD}  Configure sua empresa — faz uma vez só  ${NC}"
  echo -e "${BOLD}=================================================${NC}"
  echo ""
  echo "  Essas informações ficam salvas localmente."
  echo "  Todos os 18 agentes vão usá-las automaticamente."
  echo ""

  local EMPRESA_FILE="$SQUADS_DIR/squads/empresa.yaml"

  if [ -f "$EMPRESA_FILE" ]; then
    print_warn "Configuração anterior encontrada."
    read -p "$(echo -e "${BOLD}Reconfigurar? (s/n)${NC}: ")" reconf
    if [ "$reconf" != "s" ] && [ "$reconf" != "S" ]; then
      print_ok "Mantendo configuração existente"
      return
    fi
  fi

  local NOME=$(ask "Nome da empresa")
  local SEGMENTO=$(ask "Segmento" "Ex: Consultoria / E-commerce / Saúde")
  local PRODUTO=$(ask "Nome do produto ou serviço principal")
  local PRODUTO_DESC=$(ask "Descreva o produto em uma linha")
  local TICKET=$(ask "Ticket médio" "R$ 0")
  local ICP=$(ask "Quem é seu cliente ideal")
  local DOR1=$(ask "Principal problema que você resolve")
  local TOM=$(ask "Tom de voz" "direto, próximo, sem enrolação")
  local FOCO=$(ask "Maior prioridade do trimestre")
  local MRR_META=$(ask "Meta de faturamento mensal" "R$ 0")
  local PRAZO=$(ask "Prazo para atingir a meta" "Dezembro 2025")

  cat > "$EMPRESA_FILE" << YAML
# ============================================================
#  EMPRESA.YAML — Contexto da empresa
#  Gerado em: $(date '+%d/%m/%Y %H:%M')
# ============================================================

empresa:
  nome: "${NOME}"
  segmento: "${SEGMENTO}"
  tamanho: "1-10"

produto:
  nome: "${PRODUTO}"
  descricao_curta: "${PRODUTO_DESC}"
  ticket_medio: "${TICKET}"
  modelo_receita: "projeto"
  diferenciais:
    - "A definir"

cliente_ideal:
  perfil: "${ICP}"
  cargo_decisor: "CEO / Sócio"
  dores_principais:
    - "${DOR1}"
  gatilhos_compra:
    - "A definir"

posicionamento:
  tom_de_voz: "${TOM}"
  palavras_proibidas:
    - "sinergia"
    - "solução"
    - "robusto"

vendas:
  ciclo_medio: "30 dias"
  canais_principais:
    - "Instagram"
    - "Indicação"
  objecoes_frequentes:
    - objecao: "Está caro"
      resposta: "A definir"

marketing:
  canais_ativos:
    - "Instagram"
  cta_principal: "Agendar uma conversa"
  pilares_conteudo:
    - "Educação"
    - "Cases"

financeiro:
  moeda: "BRL"
  regime_tributario: "Simples Nacional"
  metas:
    mrr_atual: "R$ 0"
    mrr_meta: "${MRR_META}"
    prazo_meta: "${PRAZO}"

time:
  fundadores:
    - nome: "Fundador"
      cargo: "CEO"
  areas_com_time: []
  areas_solo:
    - "Todas"

metas_trimestre:
  foco_principal: "${FOCO}"
  iniciativas: []
  metricas_acompanhadas:
    - "Faturamento"
    - "Leads"
    - "Conversão"
YAML

  # Atualiza também no .claude
  cp "$EMPRESA_FILE" "$HOME/.claude/empresa.yaml" 2>/dev/null || true

  print_ok "empresa.yaml configurado"
}

# ============================================================
# CONFIGURAÇÃO DO CLAUDE CODE (CLAUDE.md)
# ============================================================

setup_claude_md() {
  print_step "Configurando Claude Code..."

  local CLAUDE_MD="$HOME/.claude/CLAUDE.md"
  mkdir -p "$HOME/.claude"

  cat > "$CLAUDE_MD" << 'CLAUDEMD'
# SQUADS — Times de IA para Empresários

## Inicialização obrigatória
Ao iniciar qualquer conversa:
1. Leia ~/.claude/empresa.yaml
2. Carregue o contexto da empresa na memória
3. Confirme internamente: você sabe o nome da empresa, produto, ICP, tom de voz e metas
4. Nunca peça informações que já estão no empresa.yaml

## Skills disponíveis
Você tem 6 times de IA instalados em ~/.claude/skills/:
- squad-comercial  → Prospecção, Proposta, Follow-up, Atendimento
- squad-gestao     → Prioridade Semanal, Reunião, Estratégia, Relatório
- squad-marketing  → Conteúdo, Anúncio, Email, Pesquisa de Mercado
- squad-operacoes  → Operacional, Contratação, Delegação
- squad-financeiro → Análise Financeira, Precificação
- squad-cs         → Onboarding, Atendimento, Anti-Churn

## Como ativar os agentes
O usuário descreve o problema em português.
Você identifica o squad mais relevante e ativa o agente correto lendo o SKILL.md correspondente.

Exemplos de ativação automática:
- "Preciso prospectar clientes"     → squad-comercial / prospeccao
- "Tenho uma reunião bagunçada"     → squad-gestao / reuniao
- "Quero criar um post"             → squad-marketing / conteudo
- "Meus números do mês"             → squad-financeiro / analise
- "Cliente quer cancelar"           → squad-cs / anti-churn
- "Quero delegar tarefas"           → squad-operacoes / delegacao

## Regra crítica
Sempre responda em português do Brasil.
Tom de voz definido em empresa.yaml — posicionamento.tom_de_voz.
Nunca use palavras genéricas de IA. Soe como um especialista humano real.
CLAUDEMD

  print_ok "CLAUDE.md configurado em ~/.claude/"
}

# ============================================================
# RESUMO FINAL
# ============================================================

print_summary() {
  echo ""
  echo -e "${BOLD}=================================================${NC}"
  echo -e "${GREEN}${BOLD}  ✓ Instalação concluída!${NC}"
  echo -e "${BOLD}=================================================${NC}"
  echo ""
  echo -e "  ${BOLD}Seu time de IA está pronto:${NC}"
  echo "   💼 Squad Comercial   — Prospecção, Proposta, Follow-up, Atendimento"
  echo "   🎯 Squad Gestão      — Prioridades, Reunião, Estratégia, Relatório"
  echo "   📣 Squad Marketing   — Conteúdo, Anúncios, Email, Pesquisa"
  echo "   ⚙️  Squad Operações   — Processos, Contratação, Delegação"
  echo "   📊 Squad Financeiro  — Análise Financeira, Precificação"
  echo "   🤝 Squad CS          — Onboarding, Atendimento, Anti-Churn"
  echo ""
  echo -e "  ${BOLD}Como usar:${NC}"
  echo "   1. Abra o terminal em qualquer pasta"
  echo "   2. Digite: claude"
  echo "   3. Descreva o que precisa em português"
  echo "   4. O agente certo entra em ação sozinho"
  echo ""
  echo -e "  ${BOLD}Exemplo:${NC}"
  echo '   "Preciso prospectar donos de clínicas em SP"'
  echo '   "Tenho uma reunião bagunçada — aqui as notas:"'
  echo '   "Meus números do mês: faturei X, gastei Y"'
  echo ""
  echo -e "  ${BOLD}Editar contexto da empresa:${NC}"
  echo "   $SQUADS_DIR/squads/empresa.yaml"
  echo ""
  echo -e "  ${BOLD}Suporte:${NC}"
  echo "   $REPO_URL"
  echo ""
}

# ============================================================
# EXECUÇÃO PRINCIPAL
# ============================================================

main() {
  print_header
  check_and_install_requirements
  download_squads
  install_skills
  configure_empresa
  setup_claude_md
  print_summary
}

main "$@"
