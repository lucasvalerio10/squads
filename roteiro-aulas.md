# Roteiro de Gravação — 7 Aulas Squads

> **Antes de gravar:** grave em um ambiente silencioso, use fone com microfone, feche notificações, deixe o terminal e o VS Code abertos e prontos. Fale como se estivesse explicando para um amigo empresário — direto, sem enrolação.

---

## Aula 1 — O que são os Squads e por que funcionam
**Duração estimada:** 12 min | **Tipo:** Apresentação em tela + fala

- Abra com uma dor real: "Você já abriu o ChatGPT, digitou uma pergunta genérica e recebeu uma resposta que não serve pro seu negócio?"
- Explique o problema: IA genérica não conhece sua empresa, seu produto, seu cliente
- Mostre a solução: o Squads lê o empresa.yaml e já sabe tudo antes de você digitar
- Apresente os 6 squads na tela (abra o squads-referencia.html)
- Mostre a diferença entre usar um ChatGPT qualquer vs um agente que já conhece a LXD Digital
- Explique o diferencial: não é persona famosa, é função real de negócio com método embutido
- Encerre com: "Nas próximas aulas você instala, configura e já usa o primeiro agente"

---

## Aula 2 — Instalação completa — Windows e Mac
**Duração estimada:** 18 min | **Tipo:** Screencast — grave a tela do computador

- Abra a página download-instalacao.html e mostre o passo a passo antes de fazer
- **Passo 1:** Instale o Git — mostre o download em git-scm.com, clique em avançar até o fim
- **Passo 2:** Instale o Node.js — mostre o download da versão LTS em nodejs.org
- **Passo 3:** Abra o Git Bash (Windows) ou Terminal (Mac) e rode `node --version` pra confirmar
- **Passo 4:** Instale o Claude Code: `npm install -g @anthropic-ai/claude-code`
- **Passo 5:** Rode o instalador do Squads: `curl -fsSL https://raw.githubusercontent.com/lucasvalerio10/squads/main/squads/install.sh | bash`
- Mostre as perguntas do instalador e preencha com dados reais da sua empresa ao vivo
- **Passo 6:** Abra o Claude Code digitando `claude` no terminal
- Mostre o CLAUDE.md sendo lido automaticamente
- Dica: "Se travar em algum passo, volta na aula e refaz — é normal na primeira vez"

---

## Aula 3 — Squad Comercial na prática
**Duração estimada:** 22 min | **Tipo:** Screencast — Claude Code ao vivo

- Abra o terminal e rode `claude`
- Mostre o menu com `/squads` ou descreva uma situação em português
- **Caso 1 — Prospecção:** diga "Preciso prospectar donos de clínicas odontológicas em SP" e mostre o agente respondendo já com o contexto da sua empresa
- **Caso 2 — Proposta:** diga "Preciso criar uma proposta para um lead que pediu orçamento de implementação de IA" — mostre o output estruturado com MEDDIC
- **Caso 3 — Follow-up:** diga "Tenho um lead que sumiu há 10 dias após ver a proposta" — mostre a mensagem de follow-up gerada
- Compare o resultado com um prompt genérico no ChatGPT — mostre a diferença
- Destaque: o agente já sabe o nome da empresa, o produto, o ticket e o tom de voz

---

## Aula 4 — Squad de Gestão na prática
**Duração estimada:** 20 min | **Tipo:** Screencast — Claude Code ao vivo

- **Caso 1 — Prioridade semanal:** descreva sua semana real ao vivo ("tenho 3 propostas pra fechar, 2 reuniões, preciso gravar essas aulas e ainda tem um cliente com problema") — mostre o agente organizando as 3 prioridades com justificativa
- **Caso 2 — Reunião:** cole notas bagunçadas de uma reunião real (pode inventar ou usar uma real) — mostre a ata formatada com donos e prazos saindo pronta
- **Caso 3 — Estratégia:** diga "Estou pensando em lançar um novo produto por R$97, faz sentido?" — mostre o advisor respondendo com First Principles
- Mostre como isso substitui horas de organização mental por minutos de conversa

---

## Aula 5 — Squad de Marketing na prática
**Duração estimada:** 24 min | **Tipo:** Screencast — Claude Code ao vivo

- **Caso 1 — Conteúdo:** diga "Tenho essa ideia: mostrar que empresário que usa IA genérica tá desperdiçando dinheiro" — mostre o agente transformando em roteiro de Reels + legenda + CTA
- **Caso 2 — Anúncio:** diga "Preciso de 3 versões de anúncio para testar no Meta Ads para o produto Squads" — mostre os 3 ângulos A/B/C com níveis de consciência diferentes
- **Caso 3 — Email:** diga "Preciso de uma sequência de boas-vindas para quem comprou o Squads" — mostre a sequência de 5 emails com assuntos e CTAs
- Dica prática: "Eu uso o Squad de Conteúdo toda semana pra criar os posts da LXD Digital"

---

## Aula 6 — Squads de Operações, Financeiro e CS
**Duração estimada:** 26 min | **Tipo:** Screencast — Claude Code ao vivo

- **Operações — Delegação:** diga "Quero fazer uma auditoria do que eu deveria parar de fazer" — mostre a lista de tarefas com custo de oportunidade calculado
- **Operações — Contratação:** diga "Preciso contratar um closer de vendas" — mostre o processo seletivo completo gerado com Topgrading
- **Financeiro — Precificação:** diga "Quero revisar o preço do meu serviço de implementação de IA" — mostre a análise de valor e estrutura de planos
- **CS — Anti-churn:** diga "Tenho um cliente que não responde há 2 semanas" — mostre o plano de intervenção gerado
- Mostre como acessar cada squad descrevendo a situação em português, sem decorar comandos

---

## Aula 7 — Como personalizar o empresa.yaml
**Duração estimada:** 15 min | **Tipo:** Screencast — VS Code + terminal

- Abra o arquivo `~/.squads/squads/empresa.yaml` no VS Code
- Mostre cada seção: empresa, produto, cliente_ideal, posicionamento, concorrentes, vendas, marketing, financeiro, time, metas_trimestre
- Edite ao vivo: troque o nome da empresa, o produto, o ICP e o tom de voz
- Salve e abra o Claude Code novamente — mostre o agente já respondendo com os dados novos
- Dica: "Atualizo o empresa.yaml toda vez que tenho um novo foco trimestral"
- Explique quando atualizar: mudança de produto, novo ICP, novo preço, nova meta
- Encerre: "Você tem agora um time de IA que trabalha 24h conhecendo seu negócio de dentro pra fora"

---

## Dicas gerais de gravação

- **Fale no presente:** "agora eu digito", "olha o que aparece", "aqui está o resultado"
- **Mostre erros se acontecerem:** dá credibilidade e ajuda quem tiver o mesmo problema
- **Zoom na tela:** antes de mostrar o terminal, aumente a fonte pra pelo menos 16px
- **Não edite demais:** o aluno quer ver o processo real, não uma apresentação perfeita
- **Termine cada aula com o próximo passo:** "na próxima aula você vai ver..."
