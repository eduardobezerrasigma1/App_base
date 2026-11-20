# STATE.md — Índice Enxuto da Espinha & Frentes Ativas (App_base v2.0)

> **REGRA DESTE ARQUIVO (`<= 45` linhas):** Guarda apenas o status macro da **Espinha (`App 0`)**, o índice de frentes em `docs/planos/ativos/` e a **Memória Negativa Global**.
> **🚫 ZERO COLISÃO EM PARALELO:** Estado detalhado de cada plug/ferramenta mora exclusivamente nas **linhas `L1–L25`** do próprio `docs/planos/ativos/PLANO_[SLUG].md` (nunca grave progresso de frentes paralelas aqui).

## 1. Status da Espinha Mestre (`App 0`)
`[✅ Kit Base v2.0 Pronto]` $\rightarrow$ **`[⏳ PRONTO PARA APP 0: Fundação da Espinha]`** $\rightarrow$ `[⬜ Espinha + 1º Fluxo (2-MVP)]` $\rightarrow$ `[⬜ 🔒 Freeze & Plugs]`

- **Espinha (`App 0`):** `⬜ Não iniciada` *(sem código em `src/`)*
- **Contratos Globais (`docs/03-CONTRATOS-DADOS.md`):** `🔓 ABERTO` · `schemaVersion: 1`
- **DNA Visual (`docs/DESIGN.md`):** `⬜ Pendente escolha (Combo F1..F4, Paleta C2..C7, Tema)`

## 2. Frentes / Plugs Ativos (`docs/planos/ativos/`)
- *(Nenhuma frente aberta ainda — após o `App 0`, cada novo plug entra aqui como 1 linha apontando para `docs/planos/ativos/PLANO_[SLUG].md`.)*

## 3. Memória Negativa Global (`🚫 Não Reabrir Pós-/compact`)
- **Proibido codar antes do `1-Protótipo` clicável (`generative_ui`):** Todo novo fluxo (`App 0`, `Implementador` ou `Refinador` visual) passa por poda visual antes de tocar no repositório.
- **Proibido congelar contrato antes do `2-MVP` testado na prática:** `🔒 CONTRACT FREEZE` só após validação real; evoluções futuras entram sempre via `.optional().default(...)`.
- **Proibido validar cálculos no olho ou estourar `250` LOC:** Exige runner `scripts/verify-oracle.*` (quando houver cálculo), `Result<T>` nas Fachadas e `scan-vibecode.ps1 -TargetPaths`.
- `{{REGISTRAR_AQUI_NO_APP: decisões/layouts/libs descartadas globalmente pelo usuário}}`

## 4. Próximo Passo Exato
- **Iniciar um Novo App (`App 0`):**
  > `Ativar [modo-mestre]. Quero iniciar o App 0 para criar "[NOME DO APP]". A dor central é [descreva em 2 linhas].`
