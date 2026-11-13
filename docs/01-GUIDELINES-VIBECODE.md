# 01-GUIDELINES-VIBECODE.md — Diretrizes de Engenharia e Desacoplamento

Este documento define as leis técnicas de codificação para que o aplicativo permaneça modular, fácil de manter por IA em múltiplos chats e imune a regressões entre a **Fase A** e a **Fase B**.

---

## 1. Limite Rígido de Tamanho de Arquivos (Hard Cap)

Modelos de IA perdem precisão de edição e contexto quando arquivos ficam longos.
- **Meta Ideal:** `80 a 150 linhas` por arquivo.
- **Zona de Alerta Amarelo:** `180 linhas` (planejar extração de sub-funções ou sub-componentes).
- **Trava Máxima Absoluta (Hard Cap):** **`250 linhas`** por arquivo de código.
- **Ação Obrigatória:** Se qualquer arquivo atingir 250 linhas durante a Fase A ou Fase B, o modo ativo deve interromper a adição de código e fatiar o arquivo em submódulos coesos antes de prosseguir.

---

## 2. Arquitetura de Desacoplamento (Padrão Caixa-Preta & Fachada)

### 2.1 Comunicação Exclusiva via Contratos e Fachadas
1. **Pasta de Contratos Globais (`contracts/` ou `types/`):**
   - Contém apenas interfaces, tipos, enums e schemas de validação refletindo `docs/03-CONTRATOS-DADOS.md`.
   - Não possui dependências de UI nem de banco de dados.
2. **Fachada de Módulo (*Barrel / Facade Pattern*):**
   - Cada módulo funcional (ex.: `modules/importacao/`, `modules/calculos/`, `modules/relatorios/`) deve expor um único arquivo público (`index.ts` / `facade.py` / etc.).
   - **Regra de Ouro:** O Módulo A **nunca** importa um arquivo interno do Módulo B (ex.: `../moduloB/interno/helper`). Ele só pode importar da Fachada (`../moduloB`) ou de `contracts/`.

### 2.2 Separação "Cérebro Puro" vs. "Casca Visual" vs. "I/O"
Todo código deve pertencer claramente a uma (e apenas uma) destas 3 camadas:
- **Camada 1 — Cérebro Puro (`core/` ou `domain/`):**
  - Funções 100% puras e determinísticas (recebem dados tipados $\rightarrow$ retornam dados tipados).
  - Zero acesso direto a DOM/UI, `localStorage`, rede ou sistema de arquivos.
- **Camada 2 — Adaptadores de Dados e I/O (`data/` ou `services/`):**
  - Responsáveis por ler arquivos de entrada, validar schemas, persistir estado local (sempre com `schemaVersion`) e exportar resultados.
- **Camada 3 — Casca Visual (`ui/` ou `pages/` + `components/`):**
  - Apenas exibe dados, captura interações do usuário e chama as Fachadas de serviço.
  - Deve consumir obrigatoriamente os tokens e componentes padronizados em `docs/04-PADRAO-UIUX.md`.

---

## 3. Congelamento de Contratos (*Contract Freeze*: Fase A $\rightarrow$ Fase B)

1. Na **Fase A (Chat Único)**, o objetivo é levantar o *Walking Skeleton* funcional de ponta a ponta e validar as assinaturas de dados e fachadas.
2. Ao encerrar a Fase A, decreta-se o **`CONTRACT FREEZE`** em `docs/03-CONTRATOS-DADOS.md`.
3. Na **Fase B (Chats Isolados)**, cada especialista pode reescrever 100% da implementação interna do seu módulo, mas **é proibido alterar nomes de funções públicas, parâmetros ou formato de retorno dos contratos congelados** sem antes acionar o `[modo-arquiteto]` para atualizar a documentação central.

---

## 4. Erros Auto-Diagnosticáveis (Observabilidade para IA)

Para que qualquer bug seja resolvido em segundos ao colar a mensagem no chat:
- **Proibido `catch` Vazio ou Silencioso:** Nenhum erro pode ser ignorado sem tratamento explícito.
- **Formato Padrão de Mensagem Técnica:**
  ```text
  [NOME_DO_MODULO:NOME_DA_FUNCAO] Descrição clara da falha | Contexto: { dadosRelevantes }
  ```
- **Feedback Duplo:** Erros de operação devem:
  1. Registrar o erro técnico estruturado no console/log para diagnóstico da IA.
  2. Exibir uma mensagem humana amigável e acionável na UI (conforme `docs/04-PADRAO-UIUX.md`).

---

## 5. Segurança de Dados, I/O Não-Destrutivo e Persistência

1. **Imutabilidade dos Arquivos de Entrada:** Quando o app ler planilhas, CSVs, JSONs ou bancos externos do usuário, a leitura é estritamente **Read-Only**. Exportações devem sempre gerar um novo arquivo ou salvar em pasta de saída dedicada, nunca sobrescrevendo o original sem confirmação explícita e backup.
2. **Versionamento de Estado Persistido (`schemaVersion`):** Qualquer dado salvo em `localStorage`, `IndexedDB`, SQLite ou JSON de configuração deve incluir `{ schemaVersion: 1, data: ... }`. Se o schema mudar, um migrador/fallback limpa ou converte o dado antigo sem quebrar a tela inicial.
3. **Higiene de Segredos:** Chaves de API, credenciais ou caminhos absolutos privados nunca vão hardcoded no código; devem residir em `.env` (com `.env.example` versionado).

---

## 6. Matriz Binária de Auditoria (`✅ PERMITIDO` vs. `❌ PROIBIDO`)

| Critério | ✅ PERMITIDO (Padrão Sênior) | ❌ PROIBIDO (Reprovação no `[modo-auditor]`) |
| :--- | :--- | :--- |
| **Tamanho de Arquivo** | Arquivos enxutos (< 200 linhas, máx. absoluto 250). | Arquivos monolíticos com > 250 linhas. |
| **Imports entre Módulos** | Importar apenas de `contracts/` ou da Fachada (`index`) do módulo. | Importar caminhos internos profundos de outro módulo. |
| **Regra de Negócio na UI** | Componente de UI chama função do domínio/serviço e renderiza o retorno. | Fazer cálculos financeiros/estatísticos ou parsing de arquivos dentro do componente de botão/página. |
| **Estilização / UI** | Usar componentes-base e tokens de `docs/04-PADRAO-UIUX.md`. | Cores hexadecimais avulsas, fontes diferentes por página ou telas sem estado de *Empty/Loading/Error*. |
| **Pacotes Externos** | Usar bibliotecas listadas no *Stack Lock* (`02-ARQUITETURA-FLUXOS.md`). | Instalar bibliotecas novas por conta própria durante a Fase B. |
| **Tratamento de Erros** | `catch (err)` com log `[MÓDULO:FUNÇÃO]` e retorno estruturado. | `catch (e) {}` vazio ou `console.log("erro")` genérico. |
