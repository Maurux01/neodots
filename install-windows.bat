@echo off
echo 🚀 Neodots Windows Installer
echo.

REM Check if PowerShell is available
powershell -Command "Write-Host 'PowerShell is available'" >nul 2>&1
if errorlevel 1 (
    echo ❌ PowerShell not found
    pause
    exit /b 1
)

echo 📦 Installing Scoop and dependencies...
powershell -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; irm get.scoop.sh | iex"

echo 🔧 Installing tools...
powershell -ExecutionPolicy Bypass -Command "scoop install git neovim nodejs python make gcc"

echo 📥 Installing Neodots configuration...
powershell -ExecutionPolicy Bypass -Command "git clone https://github.com/maurux01/neodots.git $env:LOCALAPPDATA\nvim"

echo.
echo ✅ Installation complete!
echo.
echo Next steps:
echo 1. Restart your terminal
echo 2. Run: nvim
echo 3. Wait for plugins to install
echo.
pause