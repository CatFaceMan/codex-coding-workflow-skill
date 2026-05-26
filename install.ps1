param(
    [string]$DestinationRoot = "$env:USERPROFILE\.codex\skills",
    [string]$Destination = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$source = Join-Path $repoRoot "codex-coding-workflow"

if ($Destination -ne "") {
    $rootDestination = $Destination
    $DestinationRoot = Split-Path -Parent $Destination
} else {
    $rootDestination = Join-Path $DestinationRoot "codex-coding-workflow"
}

if (-not (Test-Path -LiteralPath (Join-Path $source "SKILL.md"))) {
    throw "未找到 skill 源文件：$source\SKILL.md"
}

New-Item -ItemType Directory -Force -Path $DestinationRoot | Out-Null

if (Test-Path -LiteralPath $rootDestination) {
    Remove-Item -LiteralPath $rootDestination -Recurse -Force
}

Copy-Item -LiteralPath $source -Destination $rootDestination -Recurse -Force

$skillsSource = Join-Path $source "skills"
if (Test-Path -LiteralPath $skillsSource) {
    Get-ChildItem -LiteralPath $skillsSource -Directory | ForEach-Object {
        $target = Join-Path $DestinationRoot $_.Name
        if (Test-Path -LiteralPath $target) {
            Remove-Item -LiteralPath $target -Recurse -Force
        }
        Copy-Item -LiteralPath $_.FullName -Destination $target -Recurse -Force
    }
}

Write-Host "已安装根入口到：$rootDestination"
Write-Host "已安装子 skills 到：$DestinationRoot"
