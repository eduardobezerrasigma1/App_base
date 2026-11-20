# 05-HOMOLOGACAO-BENCHMARK.md — Homologação Final, Benchmark & `/learn` (v2.0)

Este documento define a régua objetiva para homologar a **Espinha (`App 0`)** ou qualquer **Plug (`3-Consolidada`)** construído pelo Kit Base v2.0 e retroalimentar aprendizados via `/learn`.

---

## 1. Checklist de Homologação Técnica (`3-Consolidada`)

- [ ] **1. Limite de Tamanho (Regra 02):** 100% dos arquivos da frente possuem $\le 250$ linhas no `scan-vibecode.ps1 -TargetPaths`?
- [ ] **2. Isolamento de Módulos (Regra 02):** Nenhum módulo importa arquivos internos de outro módulo fora das Fachadas (`index`)?
- [ ] **3. Pureza de Domínio & Envelope `Result<T>`:** `src/core/` é 100% livre de DOM/rede/storage e todas as Fachadas retornam `Result<T>` padronizado?
- [ ] **4. Prova Executável do Oráculo *(se houver cálculo)*:** `scripts/verify-oracle.*` executou no terminal contra `docs/golden-oracle.csv` com `0 divergências`?
- [ ] **5. Coerência Visual (12 Pilares):** As telas respeitam `docs/DESIGN.md`, `<AppShell>` único, `tabular-nums`, zero pills `8C` e os 4 estados (*Default, Empty, Loading, Error*)?
- [ ] **6. I/O Não-Destrutivo, `schemaVersion` & Retrocompatibilidade:** Arquivos originais intocados, persistência com `schemaVersion`, Snapshot JSON funcional e extensões pós-freeze com `.optional().default(...)`?
- [ ] **7. Scanner v3 & Auditorias Zeradas:** `scan-vibecode.ps1 -TargetPaths` reporta `0 violações`, `docs/audits/AUDIT_[SLUG].md` foi sanado e o plano foi movido para `docs/planos/concluidos/`?

---

## 2. Matriz de Benchmark: App Novo (v2.0) vs. Referência Anterior

| Dimensão Avaliada | Peso | Referência Anterior | App Novo (v2.0) | Evidência / Observação Prática |
| :--- | :---: | :---: | :---: | :--- |
| **1. Velocidade até 1º Valor Real (`1-Protótipo` $\rightarrow$ `2-MVP`)** | 20% | `Nota 0-10` | `Nota 0-10` | `{{PREENCHER}}` |
| **2. Modularidade e Tamanho (`<= 250` LOC + Fachadas)** | 20% | `Nota 0-10` | `Nota 0-10` | `{{PREENCHER}}` |
| **3. Precisão de Dados, Oráculo e I/O Seguro** | 20% | `Nota 0-10` | `Nota 0-10` | `{{PREENCHER}}` |
| **4. Coerência Visual e UX entre Telas (12 Pilares)** | 20% | `Nota 0-10` | `Nota 0-10` | `{{PREENCHER}}` |
| **5. Manutenibilidade (`Refinador` / `Hotfix` / Paralelismo)** | 20% | `Nota 0-10` | `Nota 0-10` | `{{PREENCHER}}` |
| **MÉDIA PONDERADA FINAL** | **100%** | **`--`** | **`--`** | **`{{Conclusão Geral}}`** |

---

## 3. Destilação de Aprendizado para o Kit Base (Retroalimentação `/learn`)

Ao consolidar a Espinha ou uma frente relevante, registre até **3 aprendizados práticos** que mereçam retroalimentar o template **`App_base`** via `/learn`:

| # | Ocorrência / Padrão Descoberto | Regra ou Melhoria Sugerida para o `App_base` | Promovido via `/learn`? |
| :---: | :--- | :--- | :---: |
| **1** | `{{PREENCHER_NA_HOMOLOGACAO}}` | `{{PREENCHER_NA_HOMOLOGACAO}}` | `[ ]` |
| **2** | `{{PREENCHER_NA_HOMOLOGACAO}}` | `{{PREENCHER_NA_HOMOLOGACAO}}` | `[ ]` |
| **3** | `{{PREENCHER_NA_HOMOLOGACAO}}` | `{{PREENCHER_NA_HOMOLOGACAO}}` | `[ ]` |
