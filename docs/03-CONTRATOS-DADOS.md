# 03-CONTRATOS-DADOS.md — Contratos Globais da Espinha, `Result<T>`, Snapshot & Oráculo (v2.0)

> *Responsáveis:* **`[modo-dados]`** e **`[modo-mestre]`**.
> *Regra de Escopo v2.0:* Este arquivo guarda os **contratos globais da Espinha Mestre (`App 0`)**. Contratos específicos de cada novo plug nascem primeiro na Seção 1 de `docs/planos/ativos/PLANO_[SLUG].md` e só sobem para cá se forem compartilhados entre módulos.

---

## 1. Status do Contrato da Espinha (`App 0`)

- **Status Atual:** `🔓 ABERTO (Pré-validação do 2-MVP da Espinha)` *(Mudar para `🔒 CONGELADO (CONTRACT FREEZE)` somente após testar e aprovar o `2-MVP` real)*
- **Versão do Schema de Persistência (`schemaVersion`):** `1`

> **REGRA PÓS-CONGELAMENTO (`3-Consolidada` & `Refinador`):** Quando o status estiver `🔒 CONGELADO`, é proibido renomear ou remover campos públicos existentes. Novos campos entram exclusivamente com **`.optional().default(valorSeguro)`** (ou com bump explícito de `schemaVersion` + rotina de migração).

---

## 2. Convenção de Entrada (100% Read-Only) & Precisão

| Fonte de Entrada | Formato / Origem | Campos Obrigatórios | Sanitização e Tratamento de Erros |
| :--- | :--- | :--- | :--- |
| `{{PREENCHER_NO_APP_0}}` | `{{CSV, XLSX, Manual, API}}` | `{{PREENCHER}}` | `{{Ex: encoding, datas, colunas faltantes}}` |

- **Precisão Numérica / Unidades:** `{{PREENCHER_NO_APP_0: ex. centavos inteiros ou unidades explícitas _cm/_kN/_MPa}}`
- **Datas / IDs:** `{{PREENCHER_NO_APP_0: ex. ISO YYYY-MM-DD, UUID v4 ou hash determinístico}}`

---

## 3. Contratos Universais da Espinha

### 3.1 Envelope Universal das Fachadas (`Result<T>` & `AppError`)
Proibido `throw` solto entre camadas ou `catch` vazio:
```text
AppError {
  tag: string          // Ex: "[DADOS:IMPORTAR]"
  code: string         // Ex: "INVALID_COLUMN_SCHEMA"
  userMessage: string  // Mensagem acionável para o toast efêmero na UI
  context?: unknown    // Metadados para diagnóstico
}

Result<T> = { ok: true, data: T } | { ok: false, error: AppError }
```

### 3.2 Snapshot de Diagnóstico JSON (`DiagnosticSnapshot`)
```text
DiagnosticSnapshot {
  schemaVersion: number
  exportedAt: string             // ISO Timestamp
  currentViewOrStep: string
  appState: AppStateContract
  recentLogs: Array<{ timestamp: string; tag: string; message: string; context?: unknown }>
}
```

### 3.3 Entidades Globais Compartilhadas *(Preenchido no `App 0`)*
```text
// Apenas entidades essenciais à Espinha — zero campos especulativos para V2/V3
EntidadeBase {
  id: string
}
```

---

## 4. Assinaturas Públicas das Fachadas da Espinha

| Módulo (`src/...`) | Função na Fachada | Entrada | Retorno (`Result<T>`) | Erros (`[MÓDULO:FUNÇÃO]`) |
| :--- | :--- | :--- | :--- | :--- |
| `src/data` | `exportDiagnosticSnapshot()` | `void` | `Result<DiagnosticSnapshot>` | `[DADOS:EXPORT_SNAPSHOT]` |
| `src/data` | `importDiagnosticSnapshot(raw)` | `string (JSON)` | `Result<AppState>` | `[DADOS:IMPORT_SNAPSHOT]` |
| `{{modulo_1}}` | `{{funcao(...)}}` | `{{...}}` | `{{Result<T>}}` | `{{[CORE:...]}}` |

---

## 5. Exportação Não-Destrutiva & Planilha-Oráculo (`docs/golden-oracle.csv`)

- **Exportação:** Sempre gerar novo arquivo com timestamp ou pasta dedicada (nunca sobrescrever originais do usuário sem backup explícito).
- **Planilha-Oráculo (`docs/golden-oracle.csv`) + Runner (`scripts/verify-oracle.*`):** Quando o app possuir cálculos de negócio/engenharia, manter 5–15 casos canônicos conferidos pelo usuário e provar `PASS (0 divergências)` no terminal — proibido conferir contas "de cabeça".
- **Casos de Borda (*Golden Dataset* em `src/data/mocks/`):** zeros, negativos, campos vazios/`null`, acentuação/caracteres especiais e duplicatas.
