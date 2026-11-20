# 01-GUIDELINES-VIBECODE.md — Diretrizes de Engenharia, Desacoplamento & Retrocompatibilidade (v2.0)

Este documento define as leis técnicas de codificação para manter o aplicativo modular, seguro para edição assistida por IA em frentes paralelas e imune a regressões entre `2-MVP`, `3-Consolidada` e evoluções via `Refinador`.

---

## 1. Limite Rígido de Tamanho de Arquivos (Hard Cap)

Modelos de IA perdem precisão cirúrgica quando arquivos ficam longos:
- **Meta Ideal:** `80 a 150 linhas` por arquivo.
- **Zona de Alerta Amarelo:** `180 linhas` (planejar extração de helper ou subcomponente).
- **Trava Máxima Absoluta (Hard Cap):** **`250 linhas`** por arquivo de código (medido por `scan-vibecode.ps1` via `ReadAllLines`).
- **Ação Obrigatória:** Ao encostar em `250` linhas (inclusive em incrementos do `Refinador`), extraia um subcomponente ou helper coeso em vez de engordar o arquivo existente.

---

## 2. Arquitetura de Desacoplamento (Padrão Caixa-Preta & Fachada)

### 2.1 Comunicação Exclusiva via Contratos e Fachadas
1. **Pasta de Contratos (`src/contracts/`):** Apenas interfaces, tipos, `Result<T>`, `AppError` e schemas de validação — zero dependência de UI ou banco.
2. **Fachada de Módulo (`index` / `facade`):** Cada módulo funcional expõe um único ponto de entrada público. **Regra de Ouro:** O Módulo A **nunca** importa um arquivo interno profundo do Módulo B; importa apenas da Fachada (`../moduloB`) ou de `src/contracts/`.

### 2.2 Separação em 3 Camadas Estritas
- **Camada 1 — Cérebro Puro (`src/core/`):** Funções 100% puras e determinísticas. Zero DOM/UI, `localStorage`, rede ou filesystem.
- **Camada 2 — Dados e I/O (`src/data/`):** Leitura Read-Only de entradas, validação em runtime, persistência versionada (`schemaVersion`), exportação não-destrutiva e Snapshot JSON.
- **Camada 3 — Casca Visual (`src/ui/`):** Apenas exibe dados, captura interações e consome Fachadas (`Result<T>`), obedecendo aos 12 Pilares em `docs/DESIGN.md`.

---

## 3. Funil Progressivo, *Step-Budget* & `🔒 CONTRACT FREEZE` Pós-`2-MVP`

1. **`1-Protótipo` Descartável (`generative_ui`):** Zero código em `src/` antes de aprovar o protótipo clicável (máx. 1–2 turnos para podar excessos).
2. **`2-MVP` (*Hard Core, Thin Shell* — Contrato ABERTO):**
   - Núcleo puro 100% rigoroso + tela mínima no caminho feliz único (**zero campos especulativos para V2/V3**).
   - **Step-Budget (Porte `M/G`):** 1 camada/plug simples por turno, rodando `scan-vibecode.ps1 -TargetPaths <frente>` + *typecheck* ao final de cada entrega.
3. **`🔒 CONTRACT FREEZE` (Só Após Validar o `2-MVP` Real):**
   - Somente quando o usuário testa e aprova o `2-MVP` com dados reais é que `L1–L25` do `PLANO_[SLUG].md` (ou `03-CONTRATOS-DADOS.md` na Espinha) muda para `🔒 CONGELADO`.
4. **Retrocompatibilidade na `3-Consolidada` e no `Refinador`:**
   - Após o congelamento, novos campos em schemas/contratos entram **exclusivamente** de forma aditiva via **`.optional().default(valorSeguro)`** (ou com bump explícito de `schemaVersion` + migrador se alterar persistência da Espinha).

---

## 4. Envelope `Result<T>` & Erros Auto-Diagnosticáveis

- **Proibido `catch`/`except` Vazio ou `throw` Solto entre Camadas:** Toda função pública falível das Fachadas retorna:
  ```text
  Result<T> = { ok: true, data: T } | { ok: false, error: { tag, code, userMessage, context? } }
  ```
- **Formato da `tag` Técnica:** `[MÓDULO:FUNÇÃO] Descrição clara da falha | Contexto: { ... }`
- **Feedback Duplo:** Registra no log estruturado (`recentLogs` do Snapshot JSON) e exibe `userMessage` em *toast* efêmero *bottom-up*.

---

## 5. I/O Não-Destrutivo, `schemaVersion` & Segredos

1. **Imutabilidade das Entradas:** Arquivos originais do usuário são estritamente **Read-Only**. Exportações geram sempre novo arquivo ou backup explícito.
2. **Versionamento (`schemaVersion`):** Todo estado persistido localmente (e todo Snapshot JSON) carrega `{ schemaVersion: N, data: ... }` com fallback/migrador seguro.
3. **Higiene de Segredos:** Chaves e credenciais nunca ficam hardcoded; residem em `.env` (com `.env.example` versionado).

---

## 6. Matriz Binária de Auditoria (`✅ PERMITIDO` vs. `❌ PROIBIDO`)

| Critério | ✅ PERMITIDO | ❌ PROIBIDO (Reprovação no `[modo-auditor]`) |
| :--- | :--- | :--- |
| **Tamanho de Arquivo** | Enxuto (`80–150` LOC; máximo absoluto `250`). | Arquivo com `> 250` linhas. |
| **Imports entre Módulos** | Apenas via `src/contracts/` ou Fachada (`index`). | Import profundo em interno de outro módulo. |
| **Regra de Negócio / I-O na UI** | Página chama Fachada (`Result<T>`) e renderiza. | Cálculo de domínio ou `fetch`/`localStorage` em `ui/pages/`. |
| **Evolução Pós-Freeze** | Campo novo com `.optional().default(...)` ou bump `schemaVersion`. | Renomear/remover campo congelado quebrando dados antigos. |
| **Pacotes Externos** | Listados no *Stack Lock* (`02-ARQUITETURA-FLUXOS.md`). | Instalar biblioteca sem aprovação do `[modo-mestre]`. |
| **Tratamento de Erros** | `Result<T>` com log `[MÓDULO:FUNÇÃO]`. | `catch (e) {}` / `except: pass` vazio ou `throw` cru na UI. |
