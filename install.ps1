# Install saas-promo-studio Claude Code skill
# Usage: irm https://raw.githubusercontent.com/anuragsingk/saas-promo-studio/main/install.ps1 | iex

$Repo   = "anuragsingk/saas-promo-studio"
$Branch = "main"
$BaseUrl = "https://raw.githubusercontent.com/$Repo/$Branch"
$SkillDir = Join-Path $env:USERPROFILE ".claude\skills\saas-promo-studio"

function Write-Step { param($msg) Write-Host "  -> $msg" -ForegroundColor Cyan }
function Write-Ok   { param($msg) Write-Host "  OK  $msg" -ForegroundColor Green }
function Write-Warn { param($msg) Write-Host "  !!  $msg" -ForegroundColor Yellow }

Write-Host ""
Write-Host "=====================================================" -ForegroundColor Magenta
Write-Host "  saas-promo-studio -- Claude Code Skill Installer" -ForegroundColor Magenta
Write-Host "=====================================================" -ForegroundColor Magenta
Write-Host ""

# Check Claude Code
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Warn "Claude Code not found. Install from: https://claude.ai/claude-code"
    Write-Warn "Then re-run this installer."
    Write-Host ""
}

# Create directories
Write-Step "Installing to: $SkillDir"
New-Item -ItemType Directory -Force -Path "$SkillDir\references" | Out-Null

# Download helper
function Get-SkillFile {
    param($RemotePath, $LocalPath)
    Write-Step "Downloading $RemotePath..."
    try {
        Invoke-WebRequest "$BaseUrl/$RemotePath" -OutFile $LocalPath -UseBasicParsing
    } catch {
        Write-Host "  FAILED: $_" -ForegroundColor Red
        exit 1
    }
}

Get-SkillFile "SKILL.md"                    "$SkillDir\SKILL.md"
Get-SkillFile "README.md"                   "$SkillDir\README.md"
Get-SkillFile "references/tech-stack.md"    "$SkillDir\references\tech-stack.md"

Write-Host ""
Write-Host "=====================================================" -ForegroundColor Green
Write-Host "  Skill installed!" -ForegroundColor Green
Write-Host "=====================================================" -ForegroundColor Green
Write-Host ""
Write-Host "  How to use:" -ForegroundColor White
Write-Host "  1. Open your SaaS project:" -ForegroundColor Gray
Write-Host "       cd C:\path\to\your-app" -ForegroundColor Cyan
Write-Host "       claude" -ForegroundColor Cyan
Write-Host "  2. Type the skill:" -ForegroundColor Gray
Write-Host "       /saas-promo-studio" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Already have Claude Code open? Restart it." -ForegroundColor Gray
Write-Host ""
