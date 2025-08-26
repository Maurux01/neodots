#!/usr/bin/env powershell
# Neodots Windows Installer - Fast & Easy Setup
# Modern Neovim configuration installer for Windows

Write-Host "🚀 Neodots Windows Installer" -ForegroundColor Cyan
Write-Host "Installing modern Neovim configuration..." -ForegroundColor Green

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if ($isAdmin) {
    Write-Host "⚠️  Running as Administrator detected. This is not recommended for Scoop installation." -ForegroundColor Yellow
    Write-Host "Please run this script as a regular user (not administrator)." -ForegroundColor Yellow
    Read-Host "Press Enter to continue anyway or Ctrl+C to exit"
}

# Function to check if command exists
function Test-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# Step 1: Install Scoop if not present
Write-Host "📦 Step 1: Installing Scoop package manager..." -ForegroundColor Blue
if (!(Test-Command scoop)) {
    try {
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Invoke-RestMethod get.scoop.sh | Invoke-Expression
        Write-Host "✅ Scoop installed successfully!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Failed to install Scoop: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✅ Scoop already installed!" -ForegroundColor Green
}

# Step 2: Install dependencies
Write-Host "🔧 Step 2: Installing dependencies..." -ForegroundColor Blue
$dependencies = @("git", "neovim", "nodejs", "python", "make", "gcc")

foreach ($dep in $dependencies) {
    Write-Host "Installing $dep..." -ForegroundColor Yellow
    try {
        scoop install $dep
        Write-Host "✅ $dep installed!" -ForegroundColor Green
    } catch {
        Write-Host "⚠️  $dep installation failed, continuing..." -ForegroundColor Yellow
    }
}

# Step 3: Install Nerd Font
Write-Host "🎨 Step 3: Installing Nerd Font..." -ForegroundColor Blue
try {
    scoop bucket add nerd-fonts
    scoop install JetBrainsMono-NF
    Write-Host "✅ JetBrains Mono Nerd Font installed!" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Font installation failed, you can install manually later" -ForegroundColor Yellow
}

# Step 4: Backup existing config
Write-Host "💾 Step 4: Backing up existing Neovim config..." -ForegroundColor Blue
$nvimPath = "$env:LOCALAPPDATA\nvim"
if (Test-Path $nvimPath) {
    $backupPath = "$env:LOCALAPPDATA\nvim.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Move-Item $nvimPath $backupPath
    Write-Host "✅ Existing config backed up to: $backupPath" -ForegroundColor Green
}

# Step 5: Clone Neodots configuration
Write-Host "📥 Step 5: Installing Neodots configuration..." -ForegroundColor Blue
try {
    git clone https://github.com/maurux01/neodots.git $nvimPath
    Write-Host "✅ Neodots configuration installed!" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to clone repository: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Step 6: Final setup
Write-Host "🎯 Step 6: Final setup..." -ForegroundColor Blue

# Refresh environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host ""
Write-Host "🎉 Installation Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Next Steps:" -ForegroundColor Cyan
Write-Host "1. Restart your terminal/PowerShell" -ForegroundColor White
Write-Host "2. Run: nvim" -ForegroundColor White
Write-Host "3. Wait for plugins to install automatically" -ForegroundColor White
Write-Host "4. Run: :NeodotsCheck to verify installation" -ForegroundColor White
Write-Host ""
Write-Host "🎨 Font Setup:" -ForegroundColor Cyan
Write-Host "Set your terminal font to 'JetBrainsMono Nerd Font' for best experience" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Enjoy your new Neovim setup!" -ForegroundColor Green
Write-Host ""

# Ask if user wants to start Neovim now
$response = Read-Host "Would you like to start Neovim now? (y/N)"
if ($response -eq "y" -or $response -eq "Y") {
    Write-Host "Starting Neovim..." -ForegroundColor Green
    nvim
}