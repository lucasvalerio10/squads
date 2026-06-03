#!/bin/bash

# ============================================================
#  SQUADS — Instalador de Times de IA para Empresários
#  github.com/lucasvalerio10/squads
# ============================================================

set -e

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

SQUADS_DIR="$HOME/.squads"
REPO_URL="https://github.com/lucasvalerio10/squads"
EMPRESA_FILE="$SQUADS_DIR/empresa.yaml"

# ============================================================
# FUNÇÕES UTILITÁRIAS
# ============================================================

print_header() {
  echo ""
  echo -e "${BOLD}=================================================${NC}"
  echo -e "${BOLD}  SQUADS — Times de IA para sua empresa${NC}"
  echo -e "${BOLD}=================================================${NC}"
  echo ""
}

print_step() {
  echo -e "${BLUE}▶ $1${NC}"
}

print_ok() {
  echo -e "${GREEN}✓ $1${NC}"
}

print_warn() {
  echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
  echo -e "${RED}✗ $1${NC}"
}

ask() {
  local prompt="$1"
  local default="$2"
  local answer
  if [ -n "$default" ]; then
    read -p "$(echo -e "${BOLD}${prompt}${NC} [${default}]: ")" answer
    echo "${answer:-$default}"
  else
    read -p "$(echo -e "${BOLD}${prompt}${NC}: ")" answer
    echo "$answer"
  fi
}

# ============================================================
# PRÉ-REQUISITOS
# ============================================================

check_requirements() {
  print_step "Verificando pré-requisitos..."

  # Git
  if ! command -v git &> /dev/null; then
    print_error "Git não encontrado. Instale em https://git-scm.com"
    exit 1
  fi
  print_ok "Git instalado"

  # Claude Code (claude CLI)
  if ! command -v claude &> /dev/null; then
    print_warn "Claude Code CLI não encontrado."
    echo ""
    echo "  Para instalar, execute:"
    echo -e "  ${BOLD}npm install -g @anthropic-ai/claude-code${NC}"
    echo ""
    read -p "Continuar mesmo assim? (s/n): " cont
    if [ "$cont" != "s" ] && [ "$cont" != "S" ]; then
      exit 1
    fi
  else
    print_ok "Claude Code instalado"
  fi
}

# ============================================================
# DOWNLOAD DOS SQUADS
# ============================================================

download_squads() {
  print_step "Baixando squads do GitHub..."

  if [ -d "$SQUADS_DIR" ]; then
    print_warn "Instalação anterior encontrada em $SQUADS_DIR"
    read -p "Atualizar para a versão mais recente? (s/n): " update
    if [ "$update" = "s" ] || [ "$update" = "S" ]; then
      cd "$SQUADS_DIR"
      git pull origin main
      print_ok "Squads atualizados"
    fi
  else
    git clone "$REPO_URL.git" "$SQUADS_DIR"
    print_ok "Squads baixados para $SQUADS_DIR"
  fi
}

# ============================================================
# CONFIGURAÇÃO DA EMPRESA
# ============================================================

configure_empresa() {
  echo ""
  echo -e "${BOLD}=================================================${NC}"
  echo -e "${BOLD}  Configuração da sua empresa${NC}"
  echo -e "${BOLD}=================================================${NC}"
  echo ""
  echo "  Essas informações ficam salvas localmente."
  echo "  Todos os agentes vão usá-las automaticamente."
  echo ""

  # Verifica se já existe configuração
  if [ -f "$EMPRESA_FILE" ]; then
    print_warn "Configuração anterior encontrada."
    read -p "Reconfigurar? (s/n): " reconf
    if [ "$reconf" != "s" ] && [ "$reconf" != "S" ]; then
      print_ok "Mantendo configuração existente"
      return
    fi
  fi

  # Coleta informações básicas
  NOME=$(ask "Nome da empresa")
  SEGMENTO=$(ask "Segmento/setor" "Ex: SaaS B2B / Agência / Clínica / E-commerce")
  TAMANHO=$(ask "Tamanho da empresa" "1-10")
  PRODUTO_NOME=$(ask "Nome do produto/serviço principal")
  PRODUTO_DESC=$(ask "Descreva o produto em uma linha")
  TICKET=$(ask "Ticket médio" "R$ 0")
  ICP=$(ask "Descreva seu cliente ideal em uma linha")
  CARGO_DECISOR=$(ask "Cargo do decisor na empresa do cliente" "CEO / Sócio")
  DOR1=$(ask "Principal dor que você resolve")
  DOR2=$(ask "Segunda dor que você resolve")
  TOM=$(ask "Tom de voz da empresa" "direto, próximo, sem formalidade excessiva")
  MRR_ATUAL=$(ask "MRR atual" "R$ 0")
  MRR_META=$(ask "MRR meta" "R$ 0")
  PRAZO_META=$(ask "Prazo para atingir a meta" "Dezembro 2025")
  FOCO=$(ask "Maior prioridade do trimestre")

  # Gera o empresa.yaml
  cat > "$EMPRESA_FILE" << YAML
# ============================================================
#  EMPRESA.YAML — Contexto da empresa
#  Gerado em: $(date '+%d/%m/%Y %H:%M')
#  Editável manualmente a qualquer momento
# ============================================================

empresa:
  nome: "${NOME}"
  segmento: "${SEGMENTO}"
  tamanho: "${TAMANHO}"
  site: ""

produto:
  nome: "${PRODUTO_NOME}"
  descricao_curta: "${PRODUTO_DESC}"
  ticket_medio: "${TICKET}"
  modelo_receita: "recorrência mensal"
  diferenciais:
    - "A definir"

cliente_ideal:
  perfil: "${ICP}"
  cargo_decisor: "${CARGO_DECISOR}"
  dores_principais:
    - "${DOR1}"
    - "${DOR2}"
  gatilhos_compra:
    - "A definir"

posicionamento:
  tom_de_voz: "${TOM}"
  palavras_proibidas:
    - "sinergia"
    - "solução"
    - "robusto"

concorrentes:
  diretos: []
  como_se_diferenciar: "A definir"

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
    - "Bastidores"

financeiro:
  moeda: "BRL"
  regime_tributario: "Simples Nacional"
  metas:
    mrr_atual: "${MRR_ATUAL}"
    mrr_meta: "${MRR_META}"
    prazo_meta: "${PRAZO_META}"

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
    - "MRR"
    - "Novos clientes"
YAML

  print_ok "empresa.yaml criado em $EMPRESA_FILE"
}

# ============================================================
# CONFIGURAÇÃO DO CLAUDE CODE
# ============================================================

setup_claude() {
  print_step "Configurando Claude Code..."

  # Cria CLAUDE.md na pasta do usuário para ler empresa.yaml automaticamente
  CLAUDE_MD="$HOME/CLAUDE.md"

  if [ -f "$CLAUDE_MD" ]; then
    # Adiciona instrução no final sem sobrescrever
    if ! grep -q "empresa.yaml" "$CLAUDE_MD"; then
      cat >> "$CLAUDE_MD" << 'CLAUDEMD'

# Squads — Times de IA
Você tem times de IA disponíveis em ~/.squads/.
Antes de qualquer tarefa empresarial, leia ~/.squads/empresa.yaml para ter o contexto da empresa.
Use /squad-[nome]:[agente] para ativar agentes específicos.
CLAUDEMD
      print_ok "Instrução adicionada ao CLAUDE.md existente"
    else
      print_ok "CLAUDE.md já configurado"
    fi
  else
    cat > "$CLAUDE_MD" << 'CLAUDEMD'
# Contexto do Ambiente

## Times de IA (Squads)
Você tem times de IA instalados em ~/.squads/.
Antes de qualquer tarefa empresarial, leia ~/.squads/empresa.yaml para ter o contexto da empresa.
Os agentes estão organizados em squads por área de negócio.

## Como usar os squads
Use /squad-[nome]:[agente] para ativar agentes específicos.
Exemplos:
- /squad-comercial:prospeccao
- /squad-gestao:prioridade
- /squad-marketing:conteudo
- /squad-financeiro:analise
CLAUDEMD
    print_ok "CLAUDE.md criado em $HOME"
  fi
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
  echo -e "  ${BOLD}Times instalados:${NC}"
  echo "   • /squad-comercial  — Prospecção, Proposta, Follow-up, Atendimento"
  echo "   • /squad-gestao     — Prioridades, Reunião, Estratégia, Relatório"
  echo "   • /squad-marketing  — Conteúdo, Anúncios, Email, Pesquisa"
  echo "   • /squad-operacoes  — Processos, Contratação, Delegação"
  echo "   • /squad-financeiro — Análise Financeira, Precificação"
  echo "   • /squad-cs         — Onboarding, Atendimento, Anti-Churn"
  echo ""
  echo -e "  ${BOLD}Como usar:${NC}"
  echo "   1. Abra o terminal na pasta do seu projeto"
  echo "   2. Digite: claude"
  echo "   3. Digite: /squad-gestao:prioridade"
  echo "   4. Descreva o que precisa — o agente já sabe quem é sua empresa"
  echo ""
  echo -e "  ${BOLD}Editar contexto da empresa:${NC}"
  echo "   $EMPRESA_FILE"
  echo ""
  echo -e "  ${BOLD}Precisa de ajuda?${NC}"
  echo "   $REPO_URL"
  echo ""
}

# ============================================================
# EXECUÇÃO PRINCIPAL
# ============================================================

main() {
  print_header
  check_requirements
  download_squads
  configure_empresa
  setup_claude
  print_summary
}

main "$@"
