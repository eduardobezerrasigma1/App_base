# DESIGN.md — Especificação Mestre do DNA Visual (Stitch & Antigravity)

> **REGRA PÉTREA DESTE DOCUMENTO:** Este arquivo contém o **DNA Visual Inegociável do Autor**. Ele é enviado via `StitchMCP` (`upload_design_md` $\rightarrow$ `create_design_system_from_design_md`) e lido obrigatoriamente por `[modo-uiux]`, `[modo-frontend]` e `[modo-auditor]`. Nenhuma geração no Stitch ou código de UI pode violar os 12 Pilares abaixo.

---

## 1. Identidade & Direção Estética (Inspiração: Linear `I1` + Raycast `I6` + Árvore Limpa `I4`)
- **Application Name:** `{{PREENCHER_NA_FASE_0}}`
- **Target Device:** `DESKTOP` (`max-width: 1200px` centralizado para leitura confortável `11A`) | `MOBILE` (`100%` fluido `11B`)
- **Visual Personality:** Ultra-clean, single-focus, low information density, continuous `1px` structural borders, generous whitespace, zero visual clutter.
- **Theme Modes Homologados:**
  - **Light Technical (`1A`):** High-precision light surface with `1px` hairline dividers (`#E2E8F0` / `#E4E4E7`) and zero drop-shadows.
  - **Deep Dark Technical (`1C`):** Layered dark surfaces with `1px` subtle borders and optional top-edge specular highlight (`S2`).

---

## 2. Banco Oficial de Fontes — 100% "Zero Liso" (Open Zero)
> **PROIBIÇÃO ABSOLUTA DE TIPOGRAFIA:** É **estritamente proibido** usar fontes monoespaçadas de código que possuam ponto ou traço dentro do número zero (`JetBrains Mono`, `Fira Code`, `Space Mono`, `IBM Plex Mono`, `Consolas` estão **BANIDAS**), bem como fontes clichês (`Inter`, `Roboto`, `Arial`).
> Todos os números devem usar a **própria fonte geométrica/humanista do combo escolhido** com `font-variant-numeric: tabular-nums` (mantendo o `0` 100% liso/aberto e o alinhamento decimal perfeito).

- **Combo Selecionado para este App:** `{{ESCOLHER_NA_FASE_0: F1 (Padrão) | F2 | F3 | F4}}`
  - **Combo `F1` (Padrão — Precisão Unificada):** `Plus Jakarta Sans` (Títulos `600/700`, Corpo `400/500` e Números Tabulares `600 tabular-nums`).
  - **Combo `F2` (Geométrica + Leitura Clássica):** `Outfit` (Títulos `600/700`) + `DM Sans` (Corpo e Números Tabulares `tabular-nums`).
  - **Combo `F3` (Alta Nitidez Executiva):** `Urbanist` (Títulos `600/700`) + `Manrope` (Corpo e Números Tabulares `tabular-nums`).
  - **Combo `F4` (Equilíbrio Suíço Contemporâneo):** `Instrument Sans` (Títulos `600/700`) + `Figtree` (Corpo e Números Tabulares `tabular-nums`).

### 2.1 Escala Tipográfica Travada em 5 Degraus (Proibido Tamanhos Arbitrários)
1. **`11.5px`:** Legendas de gráficos, rodapés discretos de cards-vitrine (`V2`/`V4`) e cabeçalhos de coluna.
2. **`13px`:** Corpo padrão de listas, tabelas, itens da sidebar e inputs.
3. **`14.5px`:** Títulos internos de cards, modais e gráficos (`A1–A3`).
4. **`18px`:** Título principal da página (sempre em 1 linha, `white-space: nowrap`).
5. **`22px–24px`:** Número principal de resumo no topo (`3C`).

### 2.2 Anatomia Rigorosa dos Ícones
- **Família e Traço Único:** Ícones 100% *Outline* (vazados, proibido misturar ícones *Filled*/pintados), `stroke-width: 1.75px`, tamanho `16px` em botões/listas e `18px` no Tronco da sidebar.
- **Proibido "Caixinhas Coloridas" Decorativas:** Ícones informativos ficam puros sobre a superfície; **um ícone só tem borda/caixa em volta quando ele é um botão clicável**.

---

## 3. Princípio de Composição Cromática (85/12/3), Banco de Paletas (`C2`–`C7`), Superfícies (`S1`/`S2`/`S4`) e Status (`8A`/`8B`)

> **REGRA MESTRE DE COMPOSIÇÃO CROMÁTICA (85 / 12 / 3):** Mais importante do que a cor isolada é a **composição e proporção tonal** da tela. Qualquer paleta escolhida (seja do banco abaixo ou específica do projeto) deve obedecer estritamente à proporção:
> - **85% Superfícies Coesas da Mesma Família Tonal:** Fundo do canvas, superfície do card e borda de `1px` pertencem à mesma temperatura/escala tonal com contraste controlado.
> - **12% Tipografia em 2 Níveis:** Primário de alto contraste + secundário dessaturado na mesma família tonal do fundo.
> - **3% Acento Cirúrgico:** Máximo de 1 cor de ação/foco + 1 cor harmônica/semântica aplicada apenas em pontos focais cirúrgicos (nunca em fundos de tags ou grandes blocos).

- **Paleta Selecionada:** `{{ESCOLHER_NA_FASE_0: C2 | C3 | C5 | C6 | C7 | Custom 85/12/3}}`

### 3.1 Paleta `C2` — Carbono Puro & Zinco (Neutra Monocromática + Verde Técnico)
- **Light (`1A`):** Canvas `#F4F4F5` | Card `#FFFFFF` | Border `1px solid #E4E4E7` | Text Primary `#09090B` | Text Muted `#71717A` | Primary Action `#09090B` | Accent `#10B981`
- **Dark (`1C`):** Canvas `#09090B` | Card `#121215` | Border `1px solid #27272A` | Text Primary `#FAFAFA` | Text Muted `#A1A1AA` | Primary Action `#FAFAFA` | Accent `#10B981`

### 3.2 Paleta `C3` — Marinho Profundo & Cobalto (Executiva / Financeira)
- **Light (`1A`):** Canvas `#EEF2F6` | Card `#FFFFFF` | Border `1px solid #CBD5E1` | Text Primary `#0F172A` | Text Muted `#64748B` | Primary Action `#0F172A` | Accent `#2563EB`
- **Dark (`1C`):** Canvas `#070B14` | Card `#101726` | Border `1px solid #1E293B` | Text Primary `#F1F5F9` | Text Muted `#94A3B8` | Primary Action `#2563EB` | Accent `#38BDF8`

### 3.2-B Paletas Criativas Homologadas (`C5`, `C6`, `C7` — Mesma Regra 85/12/3)
- **Paleta `C5` (Ameixa Noturno & Âmbar Quente — Dark):** Canvas `#0E0B14` | Card `#161220` | Border `1px solid #262035` | Text Primary `#F5F3FF` | Text Muted `#9E95B8` | Accent `#F59E0B` + `#A855F7`
- **Paleta `C6` (Algodão Quente & Terracota — Light Editorial):** Canvas `#F5F2EB` | Card `#FCFBF7` | Border `1px solid #E2DDD2` | Text Primary `#1C1917` | Text Muted `#78716C` | Accent `#C2410C` + `#4D7C0F`
- **Paleta `C7` (Floresta Profundo & Menta Elétrico — Dark Científico):** Canvas `#06100E` | Card `#0C1A17` | Border `1px solid #18302A` | Text Primary `#ECFDF5` | Text Muted `#7FA89B` | Accent `#2DD4BF` + `#F43F5E`

### 3.3 Acabamento de Superfície e Texturas de Fundo (`S1`, `S2`, `S4: T1–T5`)
- **Interior dos Cards:** Sempre 100% liso (`S1` Fosco Sólido ou `S2` Micro-degradê vertical de 4% de luminosidade + fio de luz superior `border-top: 1px solid rgba(255,255,255,0.16)` no modo escuro).
- **Fundo do Canvas (`S4` — Proibido usar grade/folha quadriculada!):**
  - `T1`: Contraste de tom sólido puro (`#EEF2F6` / `#070B14`).
  - `T2`: Luz atmosférica vertical suave (variação de 4% do topo para a base).
  - `T3`: Textura física de papel matte (*fine grain noise*).
  - `T4`: Micro-pontos esparsos (`0.85px` a cada `24px`, sem linhas).
  - `T5`: Hachura diagonal sutil (`45deg`) apenas para zonas neutras/desabilitadas.

### 3.4 Indicadores de Status Sem Carnaval (`8A` e `8B` — Banido `8C`!)
- **PROIBIDO usar tags/pills/badges com caixas coloridas ou contornos (`8C` banido)** em tabelas e listas.
- Use exclusivamente:
  - **`8A` (Ponto Semântico):** Micro-ponto de `6px` (`#10B981` positivo, `#F59E0B` atenção, `#EF4444` crítico) ao lado do texto limpo.
  - **`8B` (Cor Semântica no Número):** Aplicar a cor semântica diretamente no valor numérico (`+ R$ 140.000` em `#059669`, desvio crítico em `#DC2626`).

---

## 4. Arquitetura do `AppShell` e Hierarquia de 3 Níveis (Tronco $\rightarrow$ Galhos $\rightarrow$ Ramos)

1. **Sidebar em Árvore (Apenas Nível 1 "Tronco" e Nível 2 "Galhos"):**
   - **Expandida:** Mostra `Ícone + Nome curto` no **Tronco (Nível 1)**. Os **Galhos (Nível 2)** descem conectados por **Linha-Guia Vertical contínua (`2A`)** ou em **Trilho Duplo recolhível (`2C`)**, **sem repetir ícones nos filhos** e **proibido usar bolinhas estilo Word (`•`)**.
   - **Recolhida (Collapsed):** Exibe apenas os ícones dos Troncos (1 ícone exclusivo por Tronco, proibido repetir o mesmo ícone).
2. **Regra Estrita do Nível 3 ("Ramos" — FORA da Sidebar):**
   - Os **Ramos (Nível 3)** jamais entram na sidebar. Eles são navegados dentro da área principal de duas formas:
     - **Caso `5A` (Ramos por Abas na mesma página):** Usando abas integradas à moldura superior da caixa (`5A-1`) ou barra de abas com linha contínua de `1px` integrada ao cabeçalho (`5A-2`). O título da página nunca quebra em duas linhas (`white-space: nowrap`).
     - **Caso `5B` (Ramos por Cards-Vitrine):** O Nível 2 exibe uma vitrine de Cards acionáveis (`V1`–`V4`: puros com `Ícone + Título + Botão > / ↗` ou com **linha divisória suave `#F1F5F9` abaixo do título** e dado complementar em cinza claro `#94A3B8` afastado na base ou abaixo da seta `>`). Ao clicar no card, abre a página própria do Nível 3 usando **Navegação Tipográfica Integrada de Retorno** (**PROIBIDO botão quadrado avulso com seta `[ ← ]`**):
       - **Tipo A (Barra `/`):** `Nível 2 Clicável  /  Título Nível 3`
       - **Tipo B (Chevron sem caixa + divisor `|`):** `‹ Nível 2  |  Título Nível 3`
       - **Tipo C (Pílula/Header integrado `›`):** `Nível 2  ›  Título Nível 3`

---

## 5. Orçamento de Tela, Componentes Enxutos, Gráficos e Transições

1. **Botões Sem Texto & Filtros Ocultos (`4C`):**
   - Ações secundárias (buscar, filtrar, exportar, editar, voltar) são **100% *Icon-Only* (apenas ícone + *tooltip*, sem texto)**.
   - Filtros ficam ocultos dentro de um botão de ícone (abrindo em *popover* flutuante `4C`), nunca esparramados no topo.
2. **Listas, Resumo no Topo (`3C`) e Painel de Detalhes (`3B`):**
   - **Proibido fileiras de KPI Cards com badges de `%`:** Use resumo tipográfico limpo integrado ao cabeçalho (`3C`) quando necessário.
   - **Listas/Tabelas:** Máximo de 3 a 4 colunas visíveis, divisões de `1px`, e ícones de ação visíveis apenas no *hover* da linha (`3A`).
   - **Split-View (`3B`):** A caixa lateral direita de detalhes deve ter obrigatoriamente **altura auto-ajustável (`height: fit-content` / `align-items: start`)**, proibindo caixas esticadas com vazio exagerado para baixo.
3. **Formulários e Edição (`9A`, `9B`, `9C`):**
   - Edição direta na linha (`9C`) ou Modal compacto em grade `1px` (`9B`) para dados rápidos; Balão/Card flutuante próximo ao clique do `+`/`Editar` ou Gaveta lateral direita (`9A`) quando houver mais campos.
4. **Gráficos Indicativos (`10A–10C`) vs. Gráficos de Análise Profunda (`A1–A3`):**
   - **Indicativos Minimalistas:** Linha limpa sem grade (`10A`), barras monocromáticas (`10B`) e barra de proporção horizontal única (`10C` no lugar de pizza/rosca).
   - **Análise Profunda:**
     - `A1` (Séries/Curvas): **Título sempre fixo no canto superior esquerdo**. Dados do ponto inspecionado ficam em **balão flutuante afastado da curva** (para não tampar o gráfico) ou em faixa abaixo/ao lado, destacando o Valor principal e deixando metadados em cinza.
     - `A2` (Comparativo de Barras): Acima da barra fica apenas `Nome` (esq.) e `Valor` (dir.). O `%` fica **abaixo da barra à direita em cinza claro** ou **apenas num balão flutuante mínimo (só o `%`) ao passar o mouse**.
     - `A3` (Composição): Legenda posicionada abaixo ou ao lado (nunca poluindo o título) + balão flutuante no espaço livre ao passar o mouse (usando micro-quadrados de cor, zero bolinhas `•`).
5. **Transições Fluidas (`M2`/`M3` Refinado) e Estado Vazio (`12C`):**
   - **Zero trocas secas e zero mudança brusca na seta ativa:** Transições curtas, fluidas e suaves (`150ms–200ms cubic-bezier(0.22, 1, 0.36, 1)`) na cor da borda, cor da fonte, fundo do card ou leve proporção/canto.
   - **Estado Vazio (`12C`):** Faixa discreta de 1 linha com botão `+` (proibido ilustrações grandes e textos longos).
6. **Higiene Numérica em Tabelas, Upload, Feedback, Scroll e Teclado (Regras Sênior):**
   - **Unidade no Cabeçalho da Coluna:** Coloque `Valor (R$)` ou `Taxa (%)` no título da coluna e exiba apenas o número limpo (`140.000,00`) nas linhas para eliminar repetição visual.
   - **Valores Zero/Vazios e Trava de 1 Linha (*Single-Line Lock*):** Exiba um traço sutil em cinza claro (`—`) em vez de `0,00` repetido. Nenhuma linha de tabela pode quebrar em 2 andares (`text-overflow: ellipsis` + *tooltip* no *hover*).
   - **Upload Inteligente:** Dropzone de arquivos só aparece aberta no *Empty State*; com dados carregados, vira **apenas 1 botão de ícone (`↑`)** no cabeçalho.
   - **Feedback Sem Popups e Exclusão Rápida:** Sucesso altera suavemente o próprio ícone para `✓` por `1.5s` (ou micro-toast discreto). Exclusão usa confirmação *inline* na própria linha ou `Desfazer (4s)` (proibido modal gigante de confirmação para ações rotineiras).
   - **Viewport Lock (`100vh`) & Sticky Headers:** O `AppShell` (Sidebar + Header + Abas `5A`) é fixo e nunca rola; apenas o miolo da lista rola internamente com cabeçalho de colunas *sticky*.
   - **Keyboard-First:** *Auto-focus* imediato no 1º input ao abrir `+` ou busca; `ESC` fecha qualquer balão, filtro, modal ou gaveta; `Enter` confirma.
   - **Hierarquia Intocável no Cabeçalho de Card (Título > Métrica Auxiliar):** No topo interno de qualquer Card/Bloco, o Título do Card tem prioridade absoluta (`14.5px`, cor primária). Qualquer métrica ou contagem colocada à direita do título do card deve ser **menor ou igual ao título (`12px–13.5px`) e em cor neutra/secundária**, jamais maior ou mais vibrante que o próprio título da área.
   - **Proibição de Avisos Fixos no Rodapé (Toast Efêmero Bottom-Up):** **Proibido** criar barras ou caixas largas de aviso/status permanentes na parte inferior da tela. Qualquer aviso do sistema deve surgir como um **Card/Toast compacto flutuante**, deslizando de baixo para cima (`slide-up`), e desaparecer sozinho (`auto-dismiss` em `3s–4s`).

---

## 6. Bloco Obrigatório de Restrições para Prompts do Stitch (`DO NOT INCLUDE`)
Sempre inclua este bloco ao chamar `StitchMCP:generate_screen_from_text` ou `edit_screens`:
> **STRICT ANTI-BLOAT CONSTRAINTS:**
> - DO NOT include subtitle paragraphs or explanatory help text below headings.
> - DO NOT include rows of KPI stat cards with percentage trend badges.
> - DO NOT include text labels inside secondary toolbar buttons (use icon-only buttons).
> - DO NOT include open multi-select filter bars (hide filters inside a single filter icon button).
> - DO NOT include colored status pills/badges or bullet points (`•`).
> - DO NOT use a standalone square back-arrow button (`[ ← ]`) on Level 3 pages; use integrated typographic breadcrumbs (`Parent / Title`, `‹ Parent | Title`, or `Parent › Title`).
> - DO NOT make auxiliary numbers on the right side of a card header larger or brighter than the card title itself.
> - DO NOT include persistent bottom status/notice bars; system notices must be compact bottom-up auto-dismissing floating toasts.
> - DO NOT use slashed-zero or dotted-zero monospace fonts (`JetBrains Mono`, `Space Mono`, `Fira Code` are forbidden); use open-zero `tabular-nums`.
> - Keep maximum 2-3 visual groups on screen with generous whitespace, `1px` continuous borders, and 85/12/3 tonal composition.
