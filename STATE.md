# STATE.md — Passagem de Bastão, Memória Negativa & Radar de Progresso

> **REGRA DESTE ARQUIVO:** Máximo absoluto de **50 linhas**. Ao iniciar chat ou retomar pós-`/compact`, leia este arquivo inteiro. Ao encerrar qualquer etapa/chat, **sobrescreva** atualizando os ícones (`✅`, `⏳`, `⬜`), preservando as restrições ativas e apagando históricos antigos.

## 1. Radar Visual do Ciclo (Macro-Fases)
`[✅ Kit Base v1.7 Homologado & Publicado no GitHub Template]` $\rightarrow$ **`[⏳ PRONTO PARA FASE 0: Descoberta de Novo App]`** $\rightarrow$ `[⬜ FASE A]` $\rightarrow$ `[⬜ FASE B]` $\rightarrow$ `[⬜ FASE C]`

## 2. Progresso Etapa a Etapa
- **FUNDAÇÃO DO KIT BASE (`App_base` v1.7):**
  - `✅ [DNA-UIUX & CAD3D]` **12 Pilares + 7 Regras Sênior + 4 Prova de Fogo + Extensão Condicional CAD 2D/3D** gravados em `DESIGN.md`, `04-PADRAO-UIUX.md` e skills.
  - `✅ [POSTURA-IA]` **7 Posturas Cognitivas Transversais** (*Spine-First + Step-Budget*, *Pushback* Anti-Bajulação, Freio de Ambiguidade, Leitura Prévia, *YAGNI*, Causa-Raiz + *Stop-Loss* e Honestidade de Verificação) gravadas em `AGENTS.md`.
  - `✅ [BLINDAGENS-v1.7]` Memória Negativa pós-`/compact` (`T01`), Runner Executável `verify-oracle` (`T03`), `scan-vibecode.ps1` v2 (`T04`), *Micro-Scan Shift-Left* (`T05`), *Step-Budget* 1 Plug/Turno (`T06`), Envelope `Result<T>` (`T07`) e Destilação `/learn` na Fase C (`T10`).
- **FASE 0 (Chat 01 de um Novo App — Zero Código):**
  - `⬜ [0.1]` Entrevista de Descoberta 360° (`[modo-arquiteto]` + apoio tldraw/diagrams.net)
  - `⬜ [0.2]` Criação física de Skills Especialistas extras em `.agents/skills/`
  - `⬜ [0.3]` Preenchimento de `docs/00..04` + `DESIGN.md` + Estimativa de Chats da Fase B
- **FASE A (Chat 02 — *Spine-First* + *Step-Budget* + *Contract Freeze*):**
  - `⬜ [A.1]` Entrevista Tática + Aval Explícito $\rightarrow$ `⬜ [A.2]` Espinha Mestre Compilável $\rightarrow$ `⬜ [A.3]` 1 Plug/Turno + Micro-Scan + `verify-oracle` $\rightarrow$ `⬜ [A.4]` `🔒 CONTRACT FREEZE`
- **FASE B (Chats Isolados em Ordem *Bottom-Up* + Micro-Scan):**
  - `⬜ Chat B.1..N` (`[modo-dados]` $\rightarrow$ `[modo-backend]` $\rightarrow$ `[modo-fluxos]` $\rightarrow$ `[modo-uiux]` $\rightarrow$ `[modo-frontend]`)
- **FASE C (Auditoria Read-Only, Homologação & `/learn`):**
  - `⬜ [C.1]` `scan-vibecode.ps1` v2 + Dossiê `AUDIT-ATUAL.md` $\rightarrow$ `⬜ [C.2]` `/compact` + Fix $\rightarrow$ `⬜ [C.3]` Benchmark + Retroalimentação `/learn`

## 3. Memória Negativa & Decisões Descartadas (Não Reabrir Pós-`/compact`)
- **Proibido codar denso ou apressado:** Jamais escrever código sem aval 360° explícito ou saltar a Espinha Mestre inicial (sempre esqueleto simples + 1 plug simples por etapa).
- **Proibido validar cálculos no olho ou lançar `throw` solto:** Cálculos exigem runner `verify-oracle` real; Fachadas exigem envelope `Result<T>`.
- `{{REGISTRAR_AQUI_NO_PROJETO: ideias/layouts/bibliotecas descartadas pelo usuário para a IA nunca sugerir novamente}}`

## 4. Status Global & Próximo Passo Exato
- **Status Atual:** Kit Base (`App_base` v1.7, tag `v1.7-kit-base`) completo, versionado e publicado como GitHub Template em `eduardobezerrasigma1/App_base`.
- **Próximo Passo para Iniciar Projeto Novo (Chat 01):** `"Ativar [modo-arquiteto]. Vamos iniciar a Fase 0 (Regra 01 - Zero Código) para um novo aplicativo."`
