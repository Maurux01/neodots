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

echo 🗑️ Removing existing Neovim configuration...
if exist "%LOCALAPPDATA%\nvim" (
    rmdir /s /q "%LOCALAPPDATA%\nvim"
    echo ✅ Removed existing config
)
if exist "%LOCALAPPDATA%\nvim-data" (
    rmdir /s /q "%LOCALAPPDATA%\nvim-data"
    echo ✅ Removed existing data
)

echo 📦 Installing Scoop and dependencies...
powershell -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; irm get.scoop.sh | iex"

echo 🔧 Installing tools...
powershell -ExecutionPolicy Bypass -Command "scoop install git neovim nodejs python make gcc"

echo 📥 Copying Neodots configuration...
xcopy /e /i /h /y "." "%LOCALAPPDATA%\nvim"
echo ✅ Configuration copied

echo.
echo ✅ Installation complete!
echo.
echo 🚀 Starting Neovim automatically...
echo.

REM Start Neovim automatically
nvim