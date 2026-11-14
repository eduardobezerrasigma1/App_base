# 03-CONTRATOS-DADOS.md — Convenção de Dados, Planilha-Oráculo, Schemas e Exportação

> *Responsável por este documento:* **`[modo-dados]`** (em conjunto com `[modo-arquiteto]` no *Contract Freeze*).

---

## 1. Status do Contrato (Governança Fase A $\rightarrow$ Fase B)

- **Status Atual:** `🔓 ABERTO (Fase 0 / Fase A)` *(Mudar para `🔒 CONGELADO (CONTRACT FREEZE)` ao concluir a Fase A)*
- **Versão do Schema de Persistência (`schemaVersion`):** `1`

> **ATENÇÃO (FASE B):** Quando o status acima estiver `🔒 CONGELADO`, nenhum chat isolado da Fase B pode renomear campos, alterar tipos ou mudar assinaturas de entrada/saída listadas neste documento sem autorização formal do `[modo-arquiteto]`.

---

## 2. Convenção de Coleta e Entrada de Dados (Ingestão)

> **Regra de Ouro:** A leitura de arquivos ou fontes externas do usuário é **100% Read-Only (Não-Destrutiva)**.

| Fonte de Entrada | Formato / Origem | Campos Obrigatórios | Sanitização e Tratamento de Erros de Entrada |
| :--- | :--- | :--- | :--- |
| `{{PREENCHER_NA_FASE_0}}` | `{{Ex: CSV, XLSX, Input Manual, API}}` | `{{PREENCHER}}` | `{{Ex: Ignorar linhas vazias, converter encoding, validar datas}}` |

---

## 3. Convenções de Precisão, Datas e Moeda

- **Valores Numéricos / Monetários:** `{{PREENCHER_NA_FASE_0: ex. Armazenar em centavos (Inteiro) ou Decimal com 2 casas; proibido Float puro em somas}}`
- **Datas e Fusos Horários:** `{{PREENCHER_NA_FASE_0: ex. Formato interno ISO YYYY-MM-DD, exibição DD/MM/YYYY}}`
- **Identificadores Únicos (IDs):** `{{PREENCHER_NA_FASE_0: ex. UUID v4 ou hash determinístico para evitar duplicatas na reimportação}}`

---

## 4. Entidades e Contratos Principais (`Result<T>`, Snapshot e Schemas Core)

### 4.1 Contrato Universal de Retorno das Fachadas (`Result<T>` & `AppError`)
Toda função pública falível exposta pelas Fachadas (`src/data`, `src/core` e serviços) deve retornar este envelope padronizado (proibido `throw` solto para a camada de UI):
```text
AppError {
  tag: string          // Ex: "[DADOS:IMPORTAR]"
  code: string         // Ex: "INVALID_COLUMN_SCHEMA"
  userMessage: string  // Mensagem clara e acionável para o toast na UI
  context?: unknown    // Metadados úteis para reprodução/debug
}

Result<T> = { ok: true, data: T } | { ok: false, error: AppError }
```

### 4.2 Contrato Padrão do Snapshot de Diagnóstico (`DiagnosticSnapshot`)
Todo aplicativo do Kit deve suportar a exportação e importação deste envelope JSON para reprodução instantânea de erros pela IA:
```text
DiagnosticSnapshot {
  schemaVersion: number          // Versão atual do schema (ex: 1)
  exportedAt: string             // ISO Timestamp
  currentViewOrStep: string      // Tela ou etapa ativa no momento do snapshot
  appState: AppStateContract     // Estado completo dos dados em memória/storage
  recentLogs: Array<{            // Últimos erros ou eventos [MÓDULO:FUNÇÃO]
    timestamp: string
    tag: string
    message: string
    context?: unknown
  }>
}
```

### 4.3 Entidades do Domínio do App
```text
// {{PREENCHER_NA_FASE_0: Definir aqui as estruturas exatas de dados (Interfaces/Schemas) que trafegam entre os módulos}}

EntidadeExemplo {
  id: string
  ...
}
```

---

## 5. Contratos das Fachadas de Módulo (Assinaturas Públicas)

| Módulo (`src/...`) | Função Pública na Fachada | Parâmetros de Entrada (Input) | Retorno Garantido (Output) | Erros Possíveis (`[MÓDULO:FUNÇÃO]`) |
| :--- | :--- | :--- | :--- | :--- |
| `src/data` | `exportDiagnosticSnapshot()` | `void` | `Result<DiagnosticSnapshot>` | `[DADOS:EXPORT_SNAPSHOT] Falha ao serializar` |
| `src/data` | `importDiagnosticSnapshot(raw)` | `string (JSON)` | `Result<AppState>` | `[DADOS:IMPORT_SNAPSHOT] Schema incompatível` |
| `{{modulo_dados}}` | `{{importarDados(...)}}` | `{{...}}` | `{{Result<T>}}` | `{{[DADOS:IMPORTAR] Formato inválido}}` |
| `{{modulo_core}}` | `{{processar(...)}}` | `{{...}}` | `{{Result<T>}}` | `{{[CORE:PROCESSAR] ...}}` |

---

## 6. Convenção de Exportação e Saída de Resultados

| Destino / Tipo de Exportação | Formato e Nomenclatura Padrão | Estrutura / Colunas / Layout Garantido | Regra de Proteção (Anti-Sobrescrita) |
| :--- | :--- | :--- | :--- |
| `{{PREENCHER_NA_FASE_0}}` | `{{Ex: relatorio_YYYYMMDD_HHMM.xlsx}}` | `{{PREENCHER}}` | Sempre gerar arquivo novo com timestamp ou solicitar caminho. |

---

## 7. Regra da Planilha-Oráculo (`docs/golden-oracle.csv`), Runner Executável & *Golden Dataset*

Para eliminar erros de interpretação matemática pela IA:
1. **Planilha-Oráculo (`docs/golden-oracle.csv`) + Runner Executável (`scripts/verify-oracle.*`):**
   - Contém de **5 a 15 linhas** geradas/conferidas pelo usuário no Excel/Sheets com as **colunas de entrada** e as **colunas de resultado exato esperado**.
   - **Proibido Validar "De Cabeça":** O `[modo-backend]` deve criar e executar no terminal o script `scripts/verify-oracle.*` que lê `docs/golden-oracle.csv`, invoca `src/core/` e imprime `PASS (0 divergências)` ou `FAIL (linha X: esperado Y, obtido Z)`. Nenhuma regra de cálculo é aprovada sem execução real comprovada.
2. **Casos de Borda no *Golden Dataset* (`src/data/mocks/`):**
   - Valores zerados e negativos;
   - Campos opcionais vazios / `null`;
   - Textos longos com acentuação e caracteres especiais (`R$`, `;`, `,`, `"`);
   - Tentativa de importar registro duplicado.
