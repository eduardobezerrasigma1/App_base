# AUDIT_[SLUG].md — Dossiê Isolado de Auditoria (`P0–P3` · Pós-`/compact`)

> **INSTRUÇÃO DE FLUXO (REGRA 05 — 4 FASES):**
> 1. O **`[modo-auditor]`** (100% Read-Only no código nas Fases 1–3) grava este dossiê isolado para a frente `docs/planos/ativos/PLANO_[SLUG].md`.
> 2. O usuário escolhe quais faixas (`P0–P3`) autoriza corrigir e roda **`/compact`** para limpar o contexto de leitura.
> 3. O **`[modo-especialista]`** indicado lê **apenas este dossiê** + os arquivos-alvo, aplica as correções sem quebrar `🔒 CONTRACT FREEZE` e revalida com `scan-vibecode.ps1 -TargetPaths`.

---

## 1. Metadados da Auditoria Escopada
- **Frente / Plano:** `docs/planos/ativos/PLANO_[SLUG].md`
- **Perfil, Porte & Estágio:** `[App 0 | Implementador | Refinador]` · `Porte [P|M|G]` · `[2-MVP | 3-Consolidada]`
- **Lentes Inspecionadas (Fase 2):** `[L1 Arquitetura/LOC | L2 Dados/Oráculo | L3 Fluxos/Result<T> | L4 DNA Visual | L5 Segurança/Perf]`
- **Escopo `-TargetPaths`:** `[caminhos auditados]`
- **Especialista(s) Convocado(s):** `[modo-backend | modo-dados | modo-fluxos | modo-frontend | modo-uiux]`

---

## 2. Matriz de Achados (`P0 Crítico` $\rightarrow$ `P3 Baixo`)

### `[P0 | P1 | P2 | P3]` Achado #01 — `{{Título Curto}}`
- **Arquivo Exato e Linhas:** `{{caminho/do/arquivo:L10-L45}}`
- **Regra Violada:** `{{Ex: 01-GUIDELINES (>250 LOC) | 03-CONTRATOS | DESIGN.md}}`
- **Causa-Raiz Técnica:** `{{Explicação direta}}`
- **Instrução Cirúrgica de Correção (Respeitando Freeze):**
  1. `{{Passo 1 exato}}`
  2. `{{Passo 2 exato}}`
- **Critério de Verificação:** `{{Comando scan-vibecode.ps1 -TargetPaths / verify-oracle / typecheck}}`
