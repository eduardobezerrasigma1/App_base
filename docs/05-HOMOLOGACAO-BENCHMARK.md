# 05-HOMOLOGACAO-BENCHMARK.md — Protocolo de Validação e Comparação de Apps

Este documento define a régua objetiva para homologar o aplicativo construído pelo **Criador Assistido Geral de Apps** e compará-lo diretamente com qualquer versão anterior criada sem esta metodologia.

---

## 1. Checklist de Homologação Técnica (Antes de Dar o App por Concluído)

- [ ] **1. Limite de Tamanho (Regra 02):** 100% dos arquivos de código possuem $\le 250$ linhas?
- [ ] **2. Isolamento de Módulos (Regra 02):** Nenhum módulo importa arquivos internos de outro módulo fora das Fachadas (`index`)?
- [ ] **3. Pureza de Domínio & Envelope `Result<T>`:** `src/core/` é 100% livre de DOM/rede/storage e todas as Fachadas retornam `Result<T>` padronizado?
- [ ] **4. Prova Executável do Oráculo:** O runner `scripts/verify-oracle.*` executou no terminal contra `docs/golden-oracle.csv` com `0 divergências`?
- [ ] **5. Coerência de UI/UX:** Todas as páginas usam os mesmos tokens visuais e possuem os 4 estados (*Default, Empty, Loading, Error*)?
- [ ] **6. I/O Não-Destrutivo e Persistência:** Arquivos de entrada permanecem intocados e o estado local possui `schemaVersion`?
- [ ] **7. Scanner v2 & Auditorias Zeradas:** `scan-vibecode.ps1` reporta `0 violações` e todos os dossiês de `docs/audits/AUDIT-ATUAL.md` foram sanados?

---

## 2. Matriz de Benchmark: App Novo (Metodologia) vs. App Antigo (Sem Metodologia)

> Preencher após a conclusão do app de teste para medir o ganho real da metodologia:

| Dimensão Avaliada | Peso | App Antigo (Sem Regras) | App Novo (Com Metodologia) | Evidência / Observação Prática |
| :--- | :---: | :---: | :---: | :--- |
| **1. Modularidade e Tamanho dos Scripts** *(Maior arquivo em linhas, clareza de pastas)* | 20% | `Nota 0-10` | `Nota 0-10` | `{{PREENCHER}}` |
| **2. Facilidade de Manutenção por IA** *(Alterar 1 módulo sem quebrar outro)* | 20% | `Nota 0-10` | `Nota 0-10` | `{{PREENCHER}}` |
| **3. Precisão de Dados e Fluxos de I/O** *(Importação, cálculos de borda e exportação)* | 20% | `Nota 0-10` | `Nota 0-10` | `{{PREENCHER}}` |
| **4. Coerência Visual e UX entre Telas** *(Padronização, ergonomia, estados de erro/vazio)* | 20% | `Nota 0-10` | `Nota 0-10` | `{{PREENCHER}}` |
| **5. Resiliência a Bugs e Diagnóstico** *(Comportamento diante de arquivos/entradas inválidas)* | 20% | `Nota 0-10` | `Nota 0-10` | `{{PREENCHER}}` |
| **MÉDIA PONDERADA FINAL** | **100%** | **`--`** | **`--`** | **`{{Conclusão Geral}}`** |

---

## 3. Destilação de Aprendizado para o Kit Base (Retroalimentação `/learn`)

Ao encerrar a Fase C deste aplicativo, registre até **3 aprendizados práticos** (erros evitados, padrões úteis de domínio ou ajustes de fluxo) que mereçam ser levados de volta para evoluir o template **`App_base`** usando o comando `/learn`:

| # | Ocorrência / Padrão Descoberto Neste App | Regra ou Melhoria Sugerida para o `App_base` | Promovido via `/learn`? |
| :---: | :--- | :--- | :---: |
| **1** | `{{PREENCHER_NA_FASE_C}}` | `{{PREENCHER_NA_FASE_C}}` | `[ ]` |
| **2** | `{{PREENCHER_NA_FASE_C}}` | `{{PREENCHER_NA_FASE_C}}` | `[ ]` |
| **3** | `{{PREENCHER_NA_FASE_C}}` | `{{PREENCHER_NA_FASE_C}}` | `[ ]` |
