param(
    [string]$Destination = "$env:USERPROFILE\.codex\skills\codex-coding-workflow"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$source = Join-Path $repoRoot "codex-coding-workflow"

if (-not (Test-Path -LiteralPath (Join-Path $source "SKILL.md"))) {
    throw "未找到 skill 源文件：$source\SKILL.md"
}

New-Item -ItemType Directory -Force -Path (Split-Path $Destination) | Out-Null

if (Test-Path -LiteralPath $Destination) {
    Remove-Item -LiteralPath $Destination -Recurse -Force
}

Copy-Item -LiteralPath $source -Destination $Destination -Recurse -Force

Write-Host "已安装到：$Destination"
