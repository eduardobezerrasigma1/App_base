# PLANO — [Nome da Ferramenta ou Espinha] (`[slug]`)

> **ESTADO VIVO DA FRENTE (`L1–L25` — Fonte Única de Contexto desta Frente):**
> - **Slug / Posição:** `[slug]` · `AppShell > [Seção]`
> - **Perfil & Porte:** `[App 0 | Implementador | Refinador]` · `Porte [P | M | G]`
> - **Estágio Atual:** `1-Protótipo Aprovado` $\rightarrow$ **Próximo Passo:** `2-MVP`
> - **Contrato (`🔒 CONTRACT FREEZE`):** `ABERTO` *(congela somente após o usuário testar e aprovar o `2-MVP` real)*
> - **Escopo `-TargetPaths`:** `src/contracts/[slug],src/core/[slug],src/data/[slug],src/ui/pages/[slug]`
> - **Auditoria Isolada:** `docs/audits/AUDIT_[SLUG].md`
> - **Memória Negativa da Frente (`🚫 Não Reabrir`):**
>   - `[Listar itens cortados na entrevista ou no 1-Protótipo para a IA nunca sugerir novamente]`

---

## 1. Contrato Enxuto do `2-MVP` (*Hard Core, Thin Shell*)

- **Entradas essenciais:** `[campos mínimos com unidades/tipos claros — zero campos especulativos para V2/V3]`
- **Saídas essenciais:** `[retorno Result<T> e indicadores visíveis na 1ª dobra]`
- **Regra central / Oráculo:** `[lógica pura em src/core/ e se exige docs/golden-oracle.csv + verify-oracle]`

---

## 2. Escopo Estrito do `2-MVP` (Caminho Feliz Único — Step-Budget 1 Camada/Turno)

1. **Dados & Contrato (`[modo-dados]`):** `[schema mínimo + mocks de teste]`
2. **Cérebro Puro (`[modo-backend]`):** `[funções puras < 250 LOC + runner verify-oracle se aplicável]`
3. **Tela Enxuta (`[modo-frontend]`):** `[fiel ao 1-Protótipo aprovado, < 250 LOC por arquivo, sem satélites]`
4. **Validação Real:** `scan-vibecode.ps1 -TargetPaths ...` + *typecheck* + teste prático pelo usuário $\rightarrow$ **`🔒 CONTRACT FREEZE`**.

---

## 3. Escopo da `3-Consolidada` (Pós-Validação do `2-MVP` e `🔒 Freeze`)

- `[Integrações, persistência completa com schemaVersion, casos de borda, exportação segura e 4 estados completos]`
- Fechamento via `[modo-auditor]` em `docs/audits/AUDIT_[SLUG].md` $\rightarrow$ mover este plano para `docs/planos/concluidos/`.

---

## 4. Fora de Escopo Inicial (*Aprimoramentos Futuros* — Via `[modo-mestre]` Refinador)

- `[Ideias estacionadas em lista curta — entram sob demanda com .optional().default(...)]`
