param(
    [string]$DestinationRoot = "$env:USERPROFILE\.agents\skills",
    [string]$Destination = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$source = Join-Path $repoRoot "codex-coding-workflow"
$skillName = "codex-plan-task-workflow"

if ($Destination -ne "") {
    $rootDestination = $Destination
    $DestinationRoot = Split-Path -Parent $Destination
} else {
    $rootDestination = Join-Path $DestinationRoot $skillName
}

if (-not (Test-Path -LiteralPath (Join-Path $source "SKILL.md"))) {
    throw "未找到 skill 源文件：$source\SKILL.md"
}

New-Item -ItemType Directory -Force -Path $DestinationRoot | Out-Null

if (Test-Path -LiteralPath $rootDestination) {
    Remove-Item -LiteralPath $rootDestination -Recurse -Force
}

Copy-Item -LiteralPath $source -Destination $rootDestination -Recurse -Force

Write-Host "已安装 skill 到：$rootDestination"
