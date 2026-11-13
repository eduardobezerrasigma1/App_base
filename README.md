# App_base — Kit Base de Vibecoding Estruturado (v1.6)

Template oficial para criação assistida de aplicativos modulares com IA (**Criador Assistido Geral de Apps**), projetado para manter **zero perda de contexto**, arquivos enxutos (`< 250 linhas`), desacoplamento estrito por Fachadas e DNA Visual Sênior.

---

## Como Iniciar um Novo Projeto a partir deste Template

1. Clique no botão **`Use this template`** $\rightarrow$ **`Create a new repository`** no GitHub (ou clone este repositório para uma nova pasta).
2. Abra o projeto no seu editor com IA e inicie o **Chat 01 (Fase 0 — Zero Código)** enviando:

```text
Ativar [modo-arquiteto]. Vamos iniciar a Fase 0 (Regra 01 - Zero Código) para um novo aplicativo.
```

---

## Estrutura do Kit Base

```text
📁 App_base/
├── AGENTS.md                        # Constituição: 5 Regras Pétreas + Blindagens Operacionais
├── STATE.md                         # Passagem de Bastão & Radar Visual de Progresso
├── 📁 .agents/skills/               # 7 Personas Especialistas ([modo-xx]) + Scanner Determinístico
│   ├── modo-arquiteto/              # Descoberta (Fase 0), Stack Lock, Skills extras e Contract Freeze
│   ├── modo-dados/                  # Contratos, Persistência (schemaVersion), Oráculo CSV e Snapshot JSON
│   ├── modo-fluxos/                 # Jornadas, Máquinas de Estado e Prevenção de Erros
│   ├── modo-uiux/                   # Design System, Fluxo StitchMCP e Extensão Condicional CAD 2D/3D
│   ├── modo-backend/                # Regras de negócio puras (< 250 linhas) reconciliadas com Oráculo
│   ├── modo-frontend/               # Telas modulares conectadas exclusivamente via Fachadas
│   └── modo-auditor/                # Auditoria 100% Read-Only + scripts/scan-vibecode.ps1
└── 📁 docs/                         # Hub Documental e Contratos do Projeto
    ├── 00-MANUAL-DEV.md             # Instrutor Mestre, Ciclo de Fases (0, A, B, C) e Roteamento
    ├── 01-GUIDELINES-VIBECODE.md    # Limite de 250 linhas, Padrão Caixa-Preta/Fachada e Erros
    ├── 02-ARQUITETURA-FLUXOS.md     # Stack Lock, Árvore Viva e Fila Ordenada de Chats da Fase B
    ├── 03-CONTRATOS-DADOS.md        # Schemas, Assinaturas de Fachada e Congelamento (Freeze)
    ├── 04-PADRAO-UIUX.md            # 12 Pilares Visuais, 7 Regras Sênior e 4 Diretrizes Prova de Fogo
    ├── 05-HOMOLOGACAO-BENCHMARK.md  # Checklist de Homologação Final (Fase C)
    ├── DESIGN.md                    # Especificação de Tokens (Regra 85/12/3) para StitchMCP
    ├── golden-oracle.csv            # Planilha-Oráculo para validação matemática determinística
    ├── audits/                      # Template e Dossiês de Auditoria (AUDIT-ATUAL.md)
    ├── referencias_tecnicas/        # Insumos técnicos, normas e referências do domínio
    └── ui-templates/                # Gabaritos visuais consolidados via Stitch
```

---

## Ciclo de Vida em 4 Fases

| Fase | Escopo | Regra Central |
| :--- | :--- | :--- |
| **Fase 0** (`Chat 01`) | Entrevista de Descoberta, Arquitetura, Skills extras e `docs/` | **Zero código de aplicação** (Regra 01) |
| **Fase A** (`Chat 02`) | *Walking Skeleton* ponta a ponta + Decreto de `🔒 CONTRACT FREEZE` | Fecha contratos e trava a fila `B.1..B.N` |
| **Fase B** (`Chats B.1..N`) | Refinamento profundo em chats isolados na ordem *Bottom-Up* | Respeito estrito aos Contratos Congelados |
| **Fase C** (`Auditoria`) | Scanner `scan-vibecode.ps1` + `[modo-auditor]` $\rightarrow$ `/compact` $\rightarrow$ Fix | Auditoria 100% *Read-Only* no código (Regra 05) |

Consulte [`docs/00-MANUAL-DEV.md`](./docs/00-MANUAL-DEV.md) e [`AGENTS.md`](./AGENTS.md) para o detalhamento completo.
