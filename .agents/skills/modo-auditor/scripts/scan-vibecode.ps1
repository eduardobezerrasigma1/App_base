<#
.SYNOPSIS
    Scanner Deterministico de Auditoria Vibecode v3 (Suporte a -TargetPaths, -PlanFile e Paralelismo)
.DESCRIPTION
    Verifica automaticamente (em < 1s, custo zero de tokens):
    1. Limite de linhas (> 180 Alerta | > 250 Violacao Hard Cap).
    2. Blocos catch (JS/TS) ou except/pass (Python) vazios/silenciosos.
    3. Imports profundos fora de Fachada (index / facade) em JS/TS e Python.
    4. Pureza do Cerebro (core/): proibido DOM, storage, rede ou FS direto.
    5. Isolamento de I/O na UI (ui/pages/): proibido fetch/storage direto na view.
    6. Guardiao de Contract Freeze: detecta edicoes em src/contracts/ quando o contrato esta CONGELADO.
    7. DNA Visual: fontes banidas, pulo translateY, <aside> fora do AppShell e Hex hardcoded em pages/.
#>

param(
    [string]$TargetDir = "src",
    [string[]]$TargetPaths = @(),
    [string]$ContractsDoc = "docs/03-CONTRATOS-DADOS.md",
    [string]$PlanFile = "",
    [int]$WarnLines = 180,
    [int]$MaxLines = 250
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  SCANNER DETERMINISTICO VIBECODE v3 - SHIFT-LEFT & PARALELO" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$codeExtensions = @(".ts", ".tsx", ".js", ".jsx", ".py", ".vue", ".svelte", ".css", ".html")
$resolvedTargets = @()

if ($TargetPaths.Count -gt 0) {
    foreach ($entry in $TargetPaths) {
        foreach ($part in ($entry -split ",")) {
            $trimmed = $part.Trim()
            if (-not [string]::IsNullOrWhiteSpace($trimmed)) { $resolvedTargets += $trimmed }
        }
    }
}

$files = @()
if ($resolvedTargets.Count -gt 0) {
    Write-Host "[ESCOPO] Modo Frentes Paralelas (-TargetPaths): $($resolvedTargets -join ', ')" -ForegroundColor DarkCyan
    foreach ($tp in $resolvedTargets) {
        if (-not (Test-Path $tp)) {
            Write-Host "  [AVISO] Caminho alvo nao encontrado: $tp" -ForegroundColor Yellow
            continue
        }
        $item = Get-Item $tp
        if ($item.PSIsContainer) {
            $files += Get-ChildItem -Path $item.FullName -Recurse -File |
                Where-Object { $codeExtensions -contains $_.Extension.ToLower() -and $_.FullName -notmatch "node_modules|dist|build|\.git|__pycache__" }
        } elseif ($codeExtensions -contains $item.Extension.ToLower()) {
            $files += $item
        }
    }
    $files = @($files | Sort-Object FullName -Unique)
} else {
    if (-not (Test-Path $TargetDir)) {
        Write-Host "[INFO] Diretorio '$TargetDir' ainda nao existe (Projeto pre-App 0)." -ForegroundColor Yellow
        exit 0
    }
    $scanRoots = @($TargetDir)
    if (Test-Path "scripts") { $scanRoots += "scripts" }
    $files = @(Get-ChildItem -Path $scanRoots -Recurse -File |
        Where-Object { $codeExtensions -contains $_.Extension.ToLower() -and $_.FullName -notmatch "node_modules|dist|build|\.git|__pycache__" })
}

if ($files.Count -eq 0) {
    Write-Host "[INFO] Nenhum arquivo de codigo encontrado no escopo informado." -ForegroundColor Yellow
    exit 0
}

$violations = 0
$warnings = 0

Write-Host "`n[1/7] Verificando Limite de Linhas (Alerta > $WarnLines | Max > $MaxLines)..." -ForegroundColor White
foreach ($f in $files) {
    $lineCount = [System.IO.File]::ReadAllLines($f.FullName).Length
    $relPath = Resolve-Path -Path $f.FullName -Relative
    if ($lineCount -gt $MaxLines) {
        Write-Host "  [VIOLACAO CRITICA] $relPath -> $lineCount linhas (Maximo permitido: $MaxLines)" -ForegroundColor Red
        $violations++
    } elseif ($lineCount -gt $WarnLines) {
        Write-Host "  [ALERTA AMARELO]   $relPath -> $lineCount linhas (Proximo do limite de $MaxLines)" -ForegroundColor Yellow
        $warnings++
    }
}

Write-Host "`n[2/7] Verificando Blocos 'catch' / 'except' Vazios ou Silenciosos..." -ForegroundColor White
foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw
    if ($null -eq $content) { continue }
    $relPath = Resolve-Path -Path $f.FullName -Relative
    if ($content -match 'catch\s*(\([^)]*\))?\s*\{\s*(//.*)?\s*\}') {
        Write-Host "  [VIOLACAO CRITICA] $relPath -> Contem bloco catch vazio/silencioso!" -ForegroundColor Red
        $violations++
    }
    if ($f.Extension -eq ".py" -and $content -match 'except\b[^:]*:\s*(\r?\n\s*(#.*)?)*\r?\n\s*pass\b') {
        Write-Host "  [VIOLACAO CRITICA] $relPath -> Contem bloco except: pass silencioso!" -ForegroundColor Red
        $violations++
    }
}

Write-Host "`n[3/7] Verificando Imports Cruzados Fora de Fachada (JS/TS e Python)..." -ForegroundColor White
foreach ($f in $files) {
    $lines = [System.IO.File]::ReadAllLines($f.FullName)
    $lineNum = 0
    foreach ($line in $lines) {
        $lineNum++
        $isJsDeep = ($line -match "from\s+['""](\.\./)+[^/'""]+/[^/'""]+/[^'""]+['""]" -and $line -notmatch "/index['""]" -and $line -notmatch "design-system")
        $isPyDeep = ($f.Extension -eq ".py" -and $line -match "^\s*from\s+(src\.)?(core|data|ui)\.[a-zA-Z0-9_]+\.[a-zA-Z0-9_]+" -and $line -notmatch "\.(index|facade)\b" -and $line -notmatch "design_system")
        if ($isJsDeep -or $isPyDeep) {
            $relPath = Resolve-Path -Path $f.FullName -Relative
            Write-Host "  [VIOLACAO DE FACHADA] ${relPath}:L${lineNum} -> Import profundo detectado: $($line.Trim())" -ForegroundColor Red
            $violations++
        }
    }
}

Write-Host "`n[4/7] Verificando Pureza do Cerebro Puro (src/core/)..." -ForegroundColor White
$coreFiles = @($files | Where-Object { $_.FullName -match "[\\/]core[\\/]" })
foreach ($cf in $coreFiles) {
    $lines = [System.IO.File]::ReadAllLines($cf.FullName)
    $lineNum = 0
    foreach ($line in $lines) {
        $lineNum++
        if ($line -notmatch "^\s*(//|#)" -and ($line -match "\b(window|document|localStorage|sessionStorage|indexedDB|fetch|XMLHttpRequest)\b" -or $line -match "from\s+['""](fs|node:fs|axios)['""]" -or $line -match "^\s*(import|from)\s+(requests|httpx|tkinter|streamlit)\b")) {
            $relPath = Resolve-Path -Path $cf.FullName -Relative
            Write-Host "  [IMPUREZA NO CORE] ${relPath}:L${lineNum} -> Acesso proibido a UI/Rede/Storage em core/: $($line.Trim())" -ForegroundColor Red
            $violations++
        }
    }
}

Write-Host "`n[5/7] Verificando Isolamento de I/O na Casca Visual (ui/pages/)..." -ForegroundColor White
$pageFiles = @($files | Where-Object { $_.FullName -match "[\\/]ui[\\/]pages[\\/]" })
foreach ($pf in $pageFiles) {
    $lines = [System.IO.File]::ReadAllLines($pf.FullName)
    $lineNum = 0
    foreach ($line in $lines) {
        $lineNum++
        if ($line -notmatch "^\s*(//|#)" -and ($line -match "\b(localStorage|sessionStorage|indexedDB|fetch)\s*[\.\(]" -or $line -match "\baxios\.")) {
            $relPath = Resolve-Path -Path $pf.FullName -Relative
            Write-Host "  [IO DIRETO NA UI]  ${relPath}:L${lineNum} -> Pagina acessando rede/storage direto (use Fachada src/data): $($line.Trim())" -ForegroundColor Red
            $violations++
        }
    }
}

Write-Host "`n[6/7] Verificando Integridade do Contract Freeze (src/contracts/)..." -ForegroundColor White
$contractsDir = Join-Path $TargetDir "contracts"
$isFrozen = $false
if (-not [string]::IsNullOrWhiteSpace($PlanFile) -and (Test-Path $PlanFile)) {
    $planHead = (Get-Content $PlanFile -TotalCount 25) -join "`n"
    if ($planHead -match "CONTRACT FREEZE[^\r\n]*CONGELADO" -and $planHead -notmatch "CONTRACT FREEZE[^\r\n]*ABERTO") {
        $isFrozen = $true
    }
}
if (-not $isFrozen -and (Test-Path $ContractsDoc)) {
    $docRaw = Get-Content $ContractsDoc -Raw
    if ($docRaw -match "Status Atual:\*\*\s*`?([^`\r\n]*\bCONGELADO\b)" -and $Matches[1] -notmatch "ABERTO") {
        $isFrozen = $true
    }
}
if ($isFrozen -and (Test-Path $contractsDir)) {
    $gitDiff = git status --porcelain -- $contractsDir 2>$null
    if ($LASTEXITCODE -eq 0 -and -not [string]::IsNullOrWhiteSpace($gitDiff)) {
        Write-Host "  [VIOLACAO CONTRACT FREEZE] Contratos CONGELADOS, mas src/contracts/ possui alteracoes pendentes!" -ForegroundColor Red
        $violations++
    }
}

Write-Host "`n[7/7] Verificando DNA Visual (Fontes, Pulo translateY, AppShell e Cores Hex)..." -ForegroundColor White
foreach ($f in $files) {
    $lines = [System.IO.File]::ReadAllLines($f.FullName)
    $lineNum = 0
    foreach ($line in $lines) {
        $lineNum++
        if ($line -match "JetBrains Mono|Fira Code|Space Mono|IBM Plex Mono") {
            $relPath = Resolve-Path -Path $f.FullName -Relative
            Write-Host "  [VIOLACAO DNA VISUAL] ${relPath}:L${lineNum} -> Fonte banida com zero cortado/pontilhado: $($line.Trim())" -ForegroundColor Red
            $violations++
        }
        if ($line -match "hover:.*-translate-y|transform:\s*translateY\(-") {
            $relPath = Resolve-Path -Path $f.FullName -Relative
            Write-Host "  [ALERTA DNA VISUAL]   ${relPath}:L${lineNum} -> Card pulando no hover (translateY proibido): $($line.Trim())" -ForegroundColor Yellow
            $warnings++
        }
    }
}
foreach ($pf in $pageFiles) {
    $lines = [System.IO.File]::ReadAllLines($pf.FullName)
    $lineNum = 0
    foreach ($line in $lines) {
        $lineNum++
        if ($line -match "<aside\b") {
            $relPath = Resolve-Path -Path $pf.FullName -Relative
            Write-Host "  [VIOLACAO APPSHELL] ${relPath}:L${lineNum} -> Tag <aside> em pages/ (exclusiva do AppShell)!" -ForegroundColor Red
            $violations++
        }
        if ($line -match "#[0-9a-fA-F]{3,8}\b") {
            $relPath = Resolve-Path -Path $pf.FullName -Relative
            Write-Host "  [ALERTA UI/UX]      ${relPath}:L${lineNum} -> Cor Hex hardcoded na pagina (use Tokens 85/12/3): $($line.Trim())" -ForegroundColor Yellow
            $warnings++
        }
    }
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "RESUMO DO SCAN v3 ($($files.Count) arquivo(s)): $violations Violacoes Criticas | $warnings Alertas" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

if ($violations -gt 0) { exit 1 } else { exit 0 }
