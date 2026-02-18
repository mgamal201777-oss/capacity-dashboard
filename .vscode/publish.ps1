param(
    [string]$Message = "dashboard update",
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

$workspaceRoot = Split-Path -Parent $PSScriptRoot
Set-Location $workspaceRoot

$gitCandidates = @(
    "C:\Program Files\Git\cmd\git.exe",
    "C:\Program Files\Git\bin\git.exe"
)

$gitPath = $gitCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $gitPath) {
    $gitCmd = Get-Command git -ErrorAction SilentlyContinue
    if ($gitCmd) {
        $gitPath = $gitCmd.Source
    }
}

if (-not $gitPath) {
    throw "Git executable not found. Install Git or add it to PATH."
}

function Invoke-Git {
    param([string[]]$GitArgs)
    & $gitPath @GitArgs
    if ($LASTEXITCODE -ne 0) {
        throw "Git command failed: git $($GitArgs -join ' ')"
    }
}

Invoke-Git @("rev-parse", "--is-inside-work-tree")
$branch = (& $gitPath branch --show-current).Trim()
if ([string]::IsNullOrWhiteSpace($branch)) {
    $branch = "main"
}

$status = (& $gitPath status --porcelain)
if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host "No local changes to publish."
    exit 0
}

$stamp = Get-Date -Format "yyyy-MM-dd HH:mm"
$commitMessage = "$Message ($stamp)"

if ($DryRun) {
    Write-Host "[DryRun] Git path: $gitPath"
    Write-Host "[DryRun] Branch: $branch"
    Write-Host "[DryRun] Commit message: $commitMessage"
    & $gitPath status --short
    exit 0
}

Invoke-Git @("add", "-A")

$cachedStatus = (& $gitPath diff --cached --name-only)
if ([string]::IsNullOrWhiteSpace($cachedStatus)) {
    Write-Host "No staged changes to commit."
    exit 0
}

Invoke-Git @("commit", "-m", $commitMessage)
Invoke-Git @("push", "origin", $branch)

Write-Host "Published successfully to origin/$branch"
