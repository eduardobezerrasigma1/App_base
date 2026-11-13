<#
.SYNOPSIS
    Scanner Deterministico de Auditoria Vibecode & DNA Visual (Regra 02, Regra 05 e 12 Pilares UI/UX)
.DESCRIPTION
    Verifica automaticamente:
    1. Arquivos em src/ que ultrapassam 180 linhas (Alerta) ou 250 linhas (Violacao Hard Cap).
    2. Blocos catch vazios ou silenciosos.
    3. Imports profundos entre modulos que violam o padrao de Fachada (index).
    4. Violacoes do DNA Visual em src/ui/ (Fontes banidas com zero cortado, recriacao de <aside> fora do AppShell, cores hardcoded em pages/ e efeito de pulo translateY).
#>

param(
    [string]$TargetDir = "src",
    [int]$WarnLines = 180,
    [int]$MaxLines = 250
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   SCANNER DETERMINISTICO DE AUDITORIA - VIBECODE KIT     " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

if (-not (Test-Path $TargetDir)) {
    Write-Host "[INFO] Diretorio '$TargetDir' ainda nao existe (Projeto na Fase 0)." -ForegroundColor Yellow
    exit 0
}

$codeExtensions = @("*.ts", "*.tsx", "*.js", "*.jsx", "*.py", "*.vue", "*.svelte", "*.css", "*.html")
$files = Get-ChildItem -Path $TargetDir -Recurse -Include $codeExtensions -File |
    Where-Object { $_.FullName -notmatch "node_modules|dist|build|\.git" }

$violations = 0
$warnings = 0

Write-Host "`n[1/5] Verificando Limite de Linhas (Alerta > $WarnLines | Max > $MaxLines)..." -ForegroundColor White
foreach ($f in $files) {
    $lineCount = (Get-Content $f.FullName | Measure-Object -Line).Lines
    $relPath = Resolve-Path -Path $f.FullName -Relative
    if ($lineCount -gt $MaxLines) {
        Write-Host "  [VIOLACAO CRITICA] $relPath -> $lineCount linhas (Maximo permitido: $MaxLines)" -ForegroundColor Red
        $violations++
    } elseif ($lineCount -gt $WarnLines) {
        Write-Host "  [ALERTA AMARELO]   $relPath -> $lineCount linhas (Proximo do limite de $MaxLines)" -ForegroundColor Yellow
        $warnings++
    }
}

Write-Host "`n[2/5] Verificando Blocos 'catch' Vazios ou Silenciosos..." -ForegroundColor White
foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    if ($null -ne $content -and $content -match 'catch\s*(\([^)]*\))?\s*\{\s*(//.*)?\s*\}') {
        $relPath = Resolve-Path -Path $f.FullName -Relative
        Write-Host "  [VIOLACAO CRITICA] $relPath -> Contem bloco catch vazio/silencioso!" -ForegroundColor Red
        $violations++
    }
}

Write-Host "`n[3/5] Verificando Imports Cruzados Fora de Fachada (index)..." -ForegroundColor White
foreach ($f in $files) {
    $lines = Get-Content $f.FullName
    $lineNum = 0
    foreach ($line in $lines) {
        $lineNum++
        if ($line -match "from\s+['""](\.\./)+[^/'""]+/[^/'""]+/[^'""]+['""]" -and $line -notmatch "/index['""]" -and $line -notmatch "design-system") {
            $relPath = Resolve-Path -Path $f.FullName -Relative
            Write-Host "  [VIOLACAO DE FACHADA] ${relPath}:L${lineNum} -> Import profundo detectado: $($line.Trim())" -ForegroundColor Red
            $violations++
        }
    }
}

Write-Host "`n[4/5] Verificando Fontes Banidas (Zero Cortado/Pontilhado) e Efeito Pulo (translateY)..." -ForegroundColor White
foreach ($f in $files) {
    $lines = Get-Content $f.FullName
    $lineNum = 0
    foreach ($line in $lines) {
        $lineNum++
        if ($line -match "JetBrains Mono|Fira Code|Space Mono|IBM Plex Mono") {
            $relPath = Resolve-Path -Path $f.FullName -Relative
            Write-Host "  [VIOLACAO DNA VISUAL] ${relPath}:L${lineNum} -> Fonte com zero cortado/pontilhado proibida (use F1..F4 tabular-nums): $($line.Trim())" -ForegroundColor Red
            $violations++
        }
        if ($line -match "hover:.*-translate-y|transform:\s*translateY\(-") {
            $relPath = Resolve-Path -Path $f.FullName -Relative
            Write-Host "  [ALERTA DNA VISUAL]   ${relPath}:L${lineNum} -> Card pulando no hover (translateY proibido em M3): $($line.Trim())" -ForegroundColor Yellow
            $warnings++
        }
    }
}

Write-Host "`n[5/5] Verificando Imutabilidade do AppShell e Cores Hardcoded em src/ui/pages/..." -ForegroundColor White
$pagesDir = Join-Path $TargetDir "ui/pages"
if (Test-Path $pagesDir) {
    $pageFiles = Get-ChildItem -Path $pagesDir -Recurse -Include $codeExtensions -File
    foreach ($pf in $pageFiles) {
        $lines = Get-Content $pf.FullName
        $lineNum = 0
        foreach ($line in $lines) {
            $lineNum++
            if ($line -match "<aside\b") {
                $relPath = Resolve-Path -Path $pf.FullName -Relative
                Write-Host "  [VIOLACAO APPSHELL] ${relPath}:L${lineNum} -> Tag <aside> dentro de pages/ (Sidebar pertence exclusivamente ao AppShell)!" -ForegroundColor Red
                $violations++
            }
            if ($line -match "#[0-9a-fA-F]{3,8}\b") {
                $relPath = Resolve-Path -Path $pf.FullName -Relative
                Write-Host "  [ALERTA UI/UX]      ${relPath}:L${lineNum} -> Cor Hex hardcoded na pagina (use Tokens 85/12/3): $($line.Trim())" -ForegroundColor Yellow
                $warnings++
            }
        }
    }
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "RESUMO DO SCAN: $violations Violacoes Criticas | $warnings Alertas" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

if ($violations -gt 0) { exit 1 } else { exit 0 }
