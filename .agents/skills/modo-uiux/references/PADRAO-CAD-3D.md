# PADRAO-CAD-3D.md — Padrão Condicional de UI/UX para Visualizadores Técnicos CAD (2D/3D) e Gráficos Científicos (2D/3D)

> **REGRA DE ISOLAMENTO DE CONTEXTO (CARREGAMENTO SOB DEMANDA):**
> Este documento é uma **extensão condicional** de [`docs/DESIGN.md`](../../../../docs/DESIGN.md) e [`docs/04-PADRAO-UIUX.md`](../../../../docs/04-PADRAO-UIUX.md).
> Ele deve ser lido e aplicado por `[modo-uiux]`, `[modo-frontend]` e `[modo-auditor]` **EXCLUSIVAMENTE** quando o aplicativo envolver **Viewports CAD 2D/3D, modelagem geométrica/estrutural/arquitetônica, malhas de elementos finitos (FEM/CAE), superfícies 3D `Z(x,y)` ou mapas científicos de contorno/isolinhas 2D**. Em aplicativos comuns (CRUD, ERP, financeiro, dashboards tradicionais), ignore este arquivo para economizar contexto.

---

## 1. Os 7 Pilares Específicos de CAD 2D/3D & Gráficos Científicos 2D/3D

Todas as telas de CAD 2D/3D e Gráficos Científicos herdam integralmente os **12 Pilares Gerais + 7 Regras Sênior + Regra Cromática 85/12/3 + Fontes de Zero Liso (`F1`–`F4` com `tabular-nums`)**, acrescidos das **7 Leis Inegociáveis** abaixo:

### 1.1 Arquitetura da Viewport: Split-Dock `1px` Duplamente Retrátil (`C-B Retrátil`)
- **Estrutura Base (`C-B`):** Os painéis laterais (Sidebar de navegação à esquerda e Painel de Camadas/Séries à direita) são acoplados em **grade estrutural contínua de `1px`**, garantindo **zero sobreposição** sobre as linhas do desenho ou da malha 3D.
- **Retração Bilateral Obrigatória (`«` / `»`):** Tanto a Sidebar esquerda quanto o Painel direito devem possuir **botões discretos de retração (*collapse*)**, permitindo recolher qualquer um dos dois (ou ambos) para expandir a viewport CAD/3D em `100%` quando o usuário desejar.

### 1.2 Toolbar de Ferramentas CAD Integrada e Discreta (`T-C Discreto`)
- **Embutida no Header da Viewport (`T-C`):** Todas as ferramentas de manipulação do canvas (Seleção `V`, Orbit/Pan `O`, Cota Linear/Angular `M`, Inspeção de Nó `N`, Plano de Corte `S`, Grelha `G`, Enquadrar `F`) ficam **integradas diretamente na barra superior de `1px` da viewport**, ao lado do título/retorno tipográfico de Nível 3 (`Pai / Filho` ou `‹ Pai | Filho`).
- **Discrição Visual Absoluta:** Botões **100% *Icon-Only*** (`26px × 26px`, ícones *outline* `14px` com `stroke-width: 1.75px`), agrupados por divisores verticais sutis de `1px` dentro de uma moldura discreta, sem elementos flutuando sobre o desenho.

### 1.3 Árvore de Camadas (Layers) com Ferramentas Reveladas no *Hover* (`L-A Expandido`)
- **Estado de Repouso Limpo:** Cada linha exibe apenas `Micro-quadrado de cor da layer (6px) + Nome da Layer + Contagem tabular à direita` (ou ícone discreto apenas se a layer estiver travada `🔒` ou oculta com risco sutil).
- **Estado de *Hover* Rico mas Sóbrio:** Ao passar o mouse sobre a linha da camada, a contagem dá lugar às ferramentas completas de controle da layer em tom neutro/monocromático (sem "estourar" aos olhos):
  1. **Isolar / Solo (`◎`):** Isola rapidamente apenas aquela camada na viewport.
  2. **Modo de Exibição / Opacidade (`◐`):** Alterna transparência ou wireframe da camada.
  3. **Visibilidade (`👁`):** Oculta/exibe a camada.
  4. **Bloqueio (`🔒`):** Trava a camada contra edição acidental.

### 1.4 Proibição de HUD de Coordenadas & Gizmo 3D Semitransparente (`Zero HUD` + `Gizmo H-B`)
- **PROIBIÇÃO PADRÃO — ZERO HUD DE COORDENADAS:** É **estritamente proibido** exibir barras ou pílulas fixas/flutuantes de coordenadas em tempo real (`X, Y, Z`) no rodapé ou nos cantos do canvas, pois pesam visualmente e geram ruído constante.
- **Gizmo de Orientação 3D (`H-B Semitransparente`):** Posicionado no canto inferior do canvas (`56px × 56px`), com **semitransparência sutil em repouso (`opacity: 0.65–0.75`)** que sobe para `1.0` apenas no *hover*, exibindo os eixos ortogonais `X`, `Y`, `Z` com suas respectivas letras.

### 1.5 Inspetor de Elemento Selecionado: Balão Contextual Essencial + Expansão Sutil (`P-C com ⌄`)
- **Ancoragem Direta (`P-C`):** Ao clicar em uma barra, viga, placa ou componente do modelo, abre-se um **Card Contextual Compacto (`width: 210px–230px`)** próximo ao elemento selecionado, conectado ao ponto clicado por uma **linha de chamada técnica fina (`1px`)**. Fecha imediatamente com `ESC` ou clique no vazio.
- **Restrição ao Essencial + Soberania do Título:**
  - Cabeçalho com **Título da Peça em `14px–14.5px` negrito** (soberano) à esquerda e código/perfil auxiliar menor (`11.5px`, tom secundário) à direita.
  - Corpo restrito às **3 propriedades essenciais** do elemento em linhas de `1px` (Unidade declarada na chave à esquerda + valor numérico limpo em `tabular-nums` à direita).
- **Símbolo Sutil de Expansão na Base (`⌄`):** Na base do balão `P-C`, incluir uma **faixa mínima (`20px`) com um chevron sutil centralizado (`⌄`)** para que o usuário possa expandir os parâmetros secundários somente quando necessitar.

### 1.6 Cotas Lineares/Angulares em Verde Padrão (`M-A Refinado`) vs. Callouts de Nó (`M-C`)
1. **Cotas de Medida Linear e Angular (`M-A Refinado`):**
   - **Cor Dedicada Exclusiva (Verde Técnico `#10B981` no Dark / `#059669` no Light):** Tanto as linhas de extensão/dimensão (`1px`) quanto o texto do valor da cota devem usar **exatamente a mesma cor verde padrão**, diferenciando imediatamente as cotas da geometria estrutural do projeto.
   - **PROIBIDO Caixa/Pílula no Texto da Cota:** O valor numérico (`12.000 mm`, `6.800 mm`, `12.924 mm` com zero liso) nunca fica preso dentro de caixas ou pílulas; ele fica **100% livre, posicionado acima da linha de cota e rotacionado exatamente na mesma direção/inclinação da linha**.
   - **Cotas de Ângulo (`22,4°`, `90,0°`):** **PROIBIDO usar linha pontilhada no arco do ângulo!** O arco de ângulo deve ser **contínuo (`1px`) na mesma cor verde da cota, finalizado com duas setas sutis (no início e no fim do arco)** indicando com precisão a abertura medida, com o valor em graus limpo ao lado.
2. **Inspeção de Nó / Ponto Crítico Específico (`M-C`):**
   - Quando a informação referir-se a um **nó, apoio ou vértice específico** (ex.: `Nó Cumeeira #N-04`, reações de apoio, concentração de tensão nodal), usar obrigatoriamente o padrão **`M-C`**: marcador circular no nó (`4.5px–6px`) + **linha de chamada quebrada a `45°/90°` (`1px`)** até uma etiqueta limpa contendo **Ponto Semântico `6px` (`8A`) + Nome do Nó** e valores principais com destaque semântico (`8B`).

### 1.7 Gráficos Científicos: Superfícies 3D (`G-A Refinado`) vs. Isolinhas 2D (`G-C Refinado`)
> **Separação Estrita de Funções:** Nunca misture uma superfície 3D suspensa com um plano de contorno projetado embaixo na mesma caixa (antigo `G-B` banido por falta de valores legíveis). Use **`G-A Refinado`** para visão espacial 3D da malha `Z(x,y)` e **`G-C Refinado`** para leitura plana de isolinhas/contornos 2D.

1. **Gráfico de Superfície / Malha 3D (`G-A Refinado`):**
   - **Grelha `X-Y` no Piso + Projeção Tracejada do Ponto Avaliado:** Na base do volume 3D (`Z = 0`), desenhe sempre uma **grelha isométrica clara nos eixos `X` e `Y`** com marcações numéricas discretas nas bordas. A partir do ponto `(X, Y, Z)` inspecionado na superfície 3D, trace uma **linha vertical pontilhada/tracejada descendo até o ponto correspondente `(X, Y)` na grelha do piso**, e a partir dele trace **duas linhas tracejadas ortogonais sobre a grelha até as marcas `X` e `Y` da borda**, deixando inequívoca a posição horizontal do ponto avaliado.
   - **Zero Nomes de Eixos Soltos na Base + Gizmo `X, Y, Z`:** **Proibido** escrever textos soltos `"Eixo X"` / `"Eixo Y"` inclinados nas bordas inferiores do gráfico. A identificação das direções `X, Y, Z` é feita por um **Gizmo 3D semitransparente com as letras `X, Y, Z`** no canto do card.
   - **Escala de Cores Contínua (`Colorbar 8px`) + Balão Afastado:** Barra cromática vertical contínua e fina (`8px`) à direita com valores em `tabular-nums`, e **Balão Flutuante Afastado** no espaço livre superior conectado ao ponto avaliado por linha de chamada fina (`1px`).
2. **Gráfico de Isolinhas / Contorno 2D (`G-C Refinado`):**
   - **Visão 2D Pura com Valores Inscritos nas Próprias Isolinhas:** O mapa de isolinhas é sempre 2D ortogonal (nunca um plano inclinado em 3D sem valores) e deve **exibir os valores numéricos (`18,0`, `15,0`, `10,0`, `5,0` em `tabular-nums`) inscritos diretamente sobre o traço das isolinhas principais**.
   - **Escala de Cores Contínua (`Colorbar 8px` idêntica ao `G-A`):** **Proibido** usar legenda pontual de quadradinhos discretos soltos no rodapé. Use a **mesma barra cromática vertical contínua de `8px` à direita** do padrão `G-A`.
   - **Indicação no Cursor Idêntica ao `G-A`:** O ponto inspecionado no mapa 2D projeta linhas tracejadas ortogonais até os eixos `X` e `Y` e conecta-se por uma linha de chamada fina (`1px`) ao **Balão Flutuante Afastado** no canto superior esquerdo (destacando o valor principal `Z` e as coordenadas `X, Y`).

---

## 2. Matriz Rápida de Auditoria Condicional CAD 2D/3D & Gráficos 3D (`[modo-auditor]`)

| Elemento Técnico | ✅ Padrão Homologado (`PADRAO-CAD-3D.md`) | ❌ Proibido (Reprovação Imediata) |
| :--- | :--- | :--- |
| **Viewport & Painéis (`C-B`)** | Split-Dock em grade contínua `1px` com **ambos os painéis laterais retráteis (`«` / `»`)**. | Painéis fixos sem botão de retração ou janelas pesadas cobrindo o desenho. |
| **Toolbar CAD (`T-C`)** | Discreta, *Icon-Only*, embutida no cabeçalho de `1px` da viewport. | Barras de ferramentas flutuantes gigantes ou botões com rótulos de texto. |
| **Camadas / Cena (`L-A`)** | Limpa em repouso (`6px` + Nome + Contagem); revela `◎ Isolar`, `◐ Opacidade`, `👁 Olho`, `🔒 Cadeado` de forma sutil no *hover*. | Ícones de olho/cadeado repetidos e acesos em todas as linhas o tempo todo. |
| **Coordenadas & Gizmo (`H-B`)** | **Zero HUD de coordenadas `X, Y, Z`**; apenas Gizmo `X/Y/Z` semitransparente no canto inferior. | Barras inferiores de status com coordenadas `X, Y, Z` piscando ou caixas opacas pesadas. |
| **Inspetor de Peça (`P-C`)** | Balão ancorado via linha `1px` com as 3 propriedades essenciais + **chevron sutil de expansão (`⌄`) na base**. | Painel gigante mostrando 30 linhas de parâmetros de uma só vez sobre o canvas. |
| **Cotas Lineares e Ângulos (`M-A`)** | Cor **Verde Padrão (`#10B981` / `#059669`)** igual para linha e texto; **zero caixa no texto**; texto acima e na direção da linha; ângulo com **arco contínuo e 2 setas sutis**. | Pílulas/caixas em volta do número da cota, texto horizontal cruzando linha inclinada ou arco de ângulo pontilhado. |
| **Inspeção de Nó (`M-C`)** | Linha quebrada `45°/90°` de `1px` + etiqueta com ponto semântico `6px` (`8A`) + valor colorido (`8B`). | Balões redondos de quadrinhos ou badges coloridas (`8C`). |
| **Superfície 3D (`G-A`)** | Piso com **grelha `X-Y` + linha tracejada vertical e horizontal marcando o ponto avaliado no piso** + Gizmo `X/Y/Z` (sem nomes de eixos na base) + Colorbar contínua `8px` + Balão afastado. | Superfície 3D solta no ar sem grelha de piso `X-Y`, sem projeção tracejada do ponto avaliado ou com textos `"Eixo X"` escritos na base. |
| **Mapa de Isolinhas 2D (`G-C`)** | Visão 2D com **valores numéricos inscritos nas próprias isolinhas** + Colorbar contínua `8px` + Balão de cursor estilo `G-A`. | Isolinhas mudas sem valores escritos nas curvas, plano 3D misturado (`G-B`) ou legenda discreta de quadradinhos no rodapé. |

---

## 3. Bloco Adicional para Prompts do Stitch em Telas CAD / 3D (`StitchMCP`)

Quando gerar uma tela de Viewport CAD 2D/3D ou Gráfico de Superfície/Isolinhas no Stitch, anexe (além do bloco `STRICT ANTI-BLOAT CONSTRAINTS` geral de `docs/DESIGN.md`) este bloco específico:

> **CAD 2D/3D & SCIENTIFIC SURFACE CONSTRAINTS:**
> - Use `C-B` 1px split-dock architecture where BOTH left navigation sidebar and right layer panel have explicit collapse/retract icon buttons (`«` / `»`).
> - Integrate the discreet icon-only CAD toolbar (`T-C`) directly inside the top 1px viewport header bar.
> - In the Layer Tree (`L-A`), show only 6px color square + layer name + count at rest; reveal subtle hover-only tools (Isolate, Opacity, Eye, Lock) only on the hovered row.
> - DO NOT include any coordinate HUD (`X, Y, Z` readout bar or pill); place only a semitransparent 3D axis gizmo (`X, Y, Z`) in the bottom corner (`H-B`).
> - For selected elements, use an anchored contextual callout card (`P-C`) connected by a 1px leader line showing only 3 essential rows and a subtle bottom expand chevron (`⌄`).
> - Render linear and angular dimensions (`M-A`) in a dedicated technical green (`#10B981` / `#059669`) for both line and text, WITHOUT any box/pill around the dimension text, placing the text directly above and aligned parallel to the dimension line; render angle arcs as solid continuous lines (never dashed) with two subtle arrowheads at start and end. Use `M-C` orthogonal leader callouts with 6px semantic dots (`8A`) for specific structural nodes.
> - For 3D Surface plots (`G-A`), include an isometric `X-Y` floor grid with dashed projection lines dropping vertically from the evaluated 3D point to the `(X,Y)` floor grid and out to the grid ticks, a semitransparent `X/Y/Z` gizmo instead of loose axis title text on the base, a slim 8px continuous vertical colorbar, and an offset floating readout balloon connected by a 1px leader line.
> - For 2D Contour/Isoline maps (`G-C`), use pure 2D view with numeric values written inline directly on major contour lines, the same slim 8px continuous vertical colorbar (no discrete color squares), and `G-A` style offset cursor balloon.
