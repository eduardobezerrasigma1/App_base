# docs/ui-templates/ — Gabaritos Visuais Opcionais Consolidados (StitchMCP)

Esta pasta armazena templates HTML e screenshots consolidados opcionalmente a partir do **Stitch** via `StitchMCP:download_file` (quando acionado sob demanda no `App 0` / `[modo-uiux]`; a prototipação diária do `1-Protótipo` roda diretamente via `generative_ui`).

## Convenção de Arquivos
- `00-template-mestre.html` / `00-template-mestre.png`: O Template Mestre (AppShell + Componentes-Base do Design System).
- `01-<nome-da-pagina>.html` / `01-<nome-da-pagina>.png`: Templates de cada página gerados a partir do `designSystem` do Template Mestre e validados no Stitch.

> **REGRA (Regra 02):** Os arquivos `.html` desta pasta são **gabaritos visuais somente-leitura**. O `[modo-uiux]` e o `[modo-frontend]` devem decompô-los em componentes modulares (`< 250 linhas`) em `src/ui/design-system/` e `src/ui/pages/`, nunca colando o HTML monolítico inteiro diretamente como código de produção.
