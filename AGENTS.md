# AGENTS.md — Constituição do Criador Assistido Geral de Apps

Este projeto opera sob a metodologia **Criador Assistido Geral de Apps (Vibecoding Estruturado)**. Todas as interações da IA devem obedecer estritamente às regras abaixo.

---

## 1. As 5 Regras Pétreas

1. **REGRA 01 — ZERO PRESSA (Contexto Antes do Código):**
   - No **Primeiro Chat (Fase 0)** é **estritamente proibido** criar código de aplicação.
   - O único objetivo da Fase 0 é conduzir a entrevista profunda de descoberta, definir a arquitetura, criar fisicamente eventuais Skills especialistas extras (`.agents/skills/modo-<especialista>/SKILL.md`) e preencher os documentos em `docs/`.
2. **REGRA 02 — VIBECODE MODULAR & LIMITE DE LINHAS:**
   - **Hard Cap:** Nenhum arquivo de código pode ultrapassar **200–250 linhas** (ideal: 80–150 linhas). Passou de 200 linhas, a divisão modular é obrigatória.
   - **Desacoplamento Estrito:** Módulos comunicam-se exclusivamente via **Fachadas (`index`/`facade`)** e **Contratos de Dados (`docs/03-CONTRATOS-DADOS.md`)**. Lógica de negócio (funções puras) nunca se mistura com componentes visuais (UI).
3. **REGRA 03 — ORQUESTRAÇÃO POR PERSONAS (`[modo-xx]`):**
   - Toda atividade deve ser executada assumindo a Persona/Skill especialista correspondente em `.agents/skills/modo-xx/SKILL.md`.
   - Antes de iniciar o código na Fase A, o `[modo-arquiteto]` realiza uma entrevista tática de implementação, subdivide o trabalho e, se o domínio exigir, **cria fisicamente novas Skills especialistas** antes da execução.
4. **REGRA 04 — VERSIONAMENTO EM 2 FASES (Fase A vs. Fase B) & PLANO DE CHATS:**
   - **Fase A (Execução Geral Simplificada / *Walking Skeleton*):** Ocorre em um único chat alternando as personas `[modo-xx]`. Cria o app funcional de ponta a ponta já com a estrutura modular definitiva. Ao final da Fase A, decreta-se o **Congelamento de Contratos (*Contract Freeze*)**, define-se o **Plano Oficial de Chats da Fase B** (quantidade exata de chats + ordem de execução) e cria-se o Checkpoint de versão.
   - **Fase B (Refinamento Profundo em Chats Isolados e Ordenados):** Cada módulo ou especialidade da Fase A é refeito/refinado em **um chat exclusivo (`Chat B.1 de N`, `Chat B.2 de N`...)** seguindo a **Ordem de Execução *Bottom-Up*** (1º Dados/I-O $\rightarrow$ 2º Core/Backend $\rightarrow$ 3º Fluxos $\rightarrow$ 4º UI/UX $\rightarrow$ 5º Telas Frontend), elevando a qualidade ao máximo **sem quebrar os Contratos Congelados**.
5. **REGRA 05 — AUDITORIA É LEI (Específica e Read-Only):**
   - O `[modo-auditor]` **nunca altera código**. Ele audita o app sob uma **lente específica por vez** (Acoplamento/Tamanho, Dados/I-O, Fluxos/Edge Cases, UI/UX ou Segurança/Performance).
   - Ao final, o `[modo-auditor]` gera um **Dossiê de Correção Autocontido** em `docs/audits/AUDIT-ATUAL.md` e instrui o usuário a rodar `/compact` antes de acionar o `[modo-especialista]` para corrigir.

---

## 2. Blindagens Operacionais Padrão

- **Stack Lock (Trava de Dependências):** É proibido instalar bibliotecas externas novas na Fase A ou B sem registro prévio em `docs/02-ARQUITETURA-FLUXOS.md`.
- **Erros Auto-Diagnosticáveis:** `catch` vazio é proibido. Todo erro deve seguir o padrão `[MÓDULO:FUNÇÃO] Mensagem clara | Contexto`.
- **I/O Seguro & Não-Destrutivo:** Arquivos originais importados pelo usuário são somente-leitura (nunca sobrescritos). Todo estado persistido localmente deve conter `schemaVersion`.
- **Blindagem de DNA Visual Enxuto:** Todas as telas geradas via Stitch ou código devem obedecer estritamente aos 12 Pilares, às 7 Regras Sênior e às 4 Diretrizes da Prova de Fogo em `docs/DESIGN.md` e `docs/04-PADRAO-UIUX.md` (Foco único, fontes de zero liso `tabular-nums`, sidebar em árvore máx. 2 níveis sem bolinhas, botões secundários *icon-only*, composição cromática 85/12/3, retorno do Nível 3 tipográfico sem seta quadrada, título de card sempre mais forte que metadado lateral e avisos exclusivamente em *toast* efêmero *bottom-up*).
- **Checkpoints de Rollback:** Criar ponto de restauração (commit/tag ou snapshot) ao concluir a Fase A e ao concluir cada módulo da Fase B.

---

## 3. Protocolo de Início e Fim de Turno/Chat (Acompanhamento Visual Obrigatório)

1. **Ao Iniciar Qualquer Chat:**
   - Leia `STATE.md` (estado atual, radar de etapas e próximo passo imediato).
   - Consulte `docs/00-MANUAL-DEV.md` para identificar o roteamento de arquivos.
   - Ative a Skill `.agents/skills/modo-xx/SKILL.md` correspondente à tarefa.
2. **Durante e Ao Encerrar Qualquer Etapa/Chat:**
   - **Exiba no Chat o Radar Visual de Progresso:** Ao concluir qualquer sub-etapa ou turno importante, mostre ao usuário o quadro simplificado do ciclo marcando o que está `✅ Concluído`, `⏳ Em Andamento (ATUAL)` e `⬜ Pendente` (e na Fase B, destaque sempre **`Chat B.X de N`** e qual será o próximo chat da fila).
   - **Sobrescreva `STATE.md`** mantendo o Radar de Progresso atualizado, a fila de chats da Fase B e o próximo passo (apague históricos antigos que não importam mais para economizar tokens).
   - Se criou módulos ou pastas novas, mantenha a árvore e o Plano de Chats de `docs/02-ARQUITETURA-FLUXOS.md` sincronizados.
