# Script para solucionar problemas comunes de Neodots
# Ejecutar como administrador si es necesario

Write-Host "🔧 Solucionando problemas de Neodots..." -ForegroundColor Cyan

# 1. Limpiar cache de Neovim
Write-Host "🧹 Limpiando cache de Neovim..." -ForegroundColor Yellow
$nvimData = "$env:LOCALAPPDATA\nvim-data"
$nvimState = "$env:LOCALAPPDATA\nvim"
$nvimCache = "$env:LOCALAPPDATA\Temp\nvim"

if (Test-Path $nvimData) {
    Remove-Item -Recurse -Force $nvimData
    Write-Host "✅ Cache de datos eliminado" -ForegroundColor Green
}

if (Test-Path $nvimState) {
    Remove-Item -Recurse -Force $nvimState
    Write-Host "✅ Estado de Neovim eliminado" -ForegroundColor Green
}

if (Test-Path $nvimCache) {
    Remove-Item -Recurse -Force $nvimCache
    Write-Host "✅ Cache temporal eliminado" -ForegroundColor Green
}

# 2. Verificar dependencias
Write-Host "🔍 Verificando dependencias..." -ForegroundColor Yellow

# Verificar Node.js
try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js no encontrado. Instalar desde: https://nodejs.org" -ForegroundColor Red
}

# Verificar Python
try {
    $pythonVersion = python --version
    Write-Host "✅ Python: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Python no encontrado. Instalar desde: https://python.org" -ForegroundColor Red
}

# Verificar Git
try {
    $gitVersion = git --version
    Write-Host "✅ Git: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git no encontrado. Instalar desde: https://git-scm.com" -ForegroundColor Red
}

# 3. Instalar herramientas necesarias con npm
Write-Host "📦 Instalando herramientas de desarrollo..." -ForegroundColor Yellow
try {
    npm install -g live-server prettier eslint typescript
    Write-Host "✅ Herramientas de desarrollo instaladas" -ForegroundColor Green
} catch {
    Write-Host "⚠️ Error instalando herramientas npm" -ForegroundColor Yellow
}

# 4. Crear directorio de sesiones
$sessionsDir = "$env:LOCALAPPDATA\nvim-data\sessions"
if (!(Test-Path $sessionsDir)) {
    New-Item -ItemType Directory -Force -Path $sessionsDir
    Write-Host "✅ Directorio de sesiones creado" -ForegroundColor Green
}

Write-Host "🎉 ¡Problemas solucionados! Ahora ejecuta Neovim:" -ForegroundColor Green
Write-Host "   nvim" -ForegroundColor Cyan
Write-Host ""
Write-Host "📝 Comandos útiles:" -ForegroundColor Yellow
Write-Host "   :Lazy sync          - Sincronizar plugins" -ForegroundColor White
Write-Host "   :Mason              - Instalar LSP servers" -ForegroundColor White
Write-Host "   :checkhealth        - Verificar configuración" -ForegroundColor White
Write-Host "   :ThemePicker        - Cambiar tema" -ForegroundColor White
Write-Host "   :ForceTransparency  - Aplicar transparencia" -ForegroundColor White
Write-Host ""
Write-Host "⌨️ Atajos importantes:" -ForegroundColor Yellow
Write-Host "   <leader>th          - Selector de temas" -ForegroundColor White
Write-Host "   <leader>ff          - Buscar archivos" -ForegroundColor White
Write-Host "   <leader>e           - Explorador de archivos" -ForegroundColor White
Write-Host "   <Tab>/<S-Tab>       - Cambiar entre buffers" -ForegroundColor White
Write-Host "   <leader>?           - Mostrar ayuda de teclas" -ForegroundColor White

pause