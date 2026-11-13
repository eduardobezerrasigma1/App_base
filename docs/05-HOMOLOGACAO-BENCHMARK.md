# 05-HOMOLOGACAO-BENCHMARK.md — Protocolo de Validação e Comparação de Apps

Este documento define a régua objetiva para homologar o aplicativo construído pelo **Criador Assistido Geral de Apps** e compará-lo diretamente com qualquer versão anterior criada sem esta metodologia.

---

## 1. Checklist de Homologação Técnica (Antes de Dar o App por Concluído)

- [ ] **1. Limite de Tamanho (Regra 02):** 100% dos arquivos de código possuem $\le 250$ linhas?
- [ ] **2. Isolamento de Módulos (Regra 02):** Nenhum módulo importa arquivos internos de outro módulo fora das Fachadas (`index`)?
- [ ] **3. Pureza de Domínio:** A lógica de negócio/cálculo funciona de forma independente da interface visual?
- [ ] **4. Teste com *Golden Dataset*:** Os resultados para os casos normais e de borda batem 100% com o esperado em `03-CONTRATOS-DADOS.md`?
- [ ] **5. Coerência de UI/UX:** Todas as páginas usam os mesmos tokens visuais e possuem os 4 estados (*Default, Empty, Loading, Error*)?
- [ ] **6. I/O Não-Destrutivo e Persistência:** Arquivos de entrada permanecem intocados e o estado local possui `schemaVersion`?
- [ ] **7. Zero Auditorias Pendentes:** Todos os dossiês gerados pelo `[modo-auditor]` foram corrigidos e validados?

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
