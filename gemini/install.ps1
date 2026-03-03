# CareerProof Skills Installer for Gemini CLI (Windows)
# Usage: .\install.ps1 [-Global]
#
# -Global: Install to ~/.gemini/skills/ (available in all projects)
# Default: Install to ./.gemini/skills/ (current project only)

param(
    [switch]$Global
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoDir = Split-Path -Parent $ScriptDir
$SkillsSource = Join-Path $RepoDir "skills"

if ($Global) {
    $Target = Join-Path $HOME ".gemini\skills"
    Write-Host "Installing CareerProof skills globally to $Target"
} else {
    $Target = Join-Path (Get-Location) ".gemini\skills"
    Write-Host "Installing CareerProof skills to project: $Target"
}

if (-not (Test-Path $Target)) {
    New-Item -ItemType Directory -Path $Target -Force | Out-Null
}

$SkillCount = 0
foreach ($SkillDir in Get-ChildItem -Path $SkillsSource -Directory) {
    $SkillName = $SkillDir.Name
    $Dest = Join-Path $Target $SkillName

    if (Test-Path $Dest) {
        Write-Host "  Updating: $SkillName"
        Remove-Item -Path $Dest -Recurse -Force
    } else {
        Write-Host "  Installing: $SkillName"
    }

    Copy-Item -Path $SkillDir.FullName -Destination $Dest -Recurse
    $SkillCount++
}

Write-Host ""
Write-Host "Installed $SkillCount skills successfully."
Write-Host ""
Write-Host "Next: Configure the CareerProof MCP server in your Gemini CLI settings."
Write-Host ""
Write-Host "Add this to your settings.json (usually ~\.gemini\settings.json):"
Write-Host ""
Get-Content (Join-Path $ScriptDir "settings.json")
Write-Host ""
Write-Host "Replace YOUR_API_KEY_HERE with your CareerProof API key (cpk_...)."
Write-Host "Get your API key at: https://careerproof.ai/dashboard/settings"
