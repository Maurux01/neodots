# Simple Neodots Setup
# Solo copia los archivos de configuración

$NEOVIM_DIR = "$env:LOCALAPPDATA\nvim"
$REPO_DIR = (Get-Item -Path ".").FullName

# Crear directorio si no existe
if (-not (Test-Path $NEOVIM_DIR)) {
    New-Item -ItemType Directory -Path $NEOVIM_DIR -Force | Out-Null
}

# Copiar archivos excluyendo los de instalación
$exclude = @('*.ps1', '*.sh', 'README.md', '.git*')
Get-ChildItem -Path $REPO_DIR -Exclude $exclude | ForEach-Object {
    $dest = Join-Path $NEOVIM_DIR $_.Name
    if ($_.PSIsContainer) {
        if (-not (Test-Path $dest)) {
            Copy-Item -Path $_.FullName -Destination $dest -Recurse -Force
        }
    } else {
        Copy-Item -Path $_.FullName -Destination $dest -Force
    }
}

Write-Host "¡Configuración copiada a $NEOVIM_DIR!" -ForegroundColor Green
Write-Host "Ahora puedes abrir Neovim con el comando: nvim" -ForegroundColor Cyan
