# Neodots - Neovim Configuration Installer for Windows
# Script de instalación automática para PowerShell

param(
    [switch]$Force
)

# Función para imprimir mensajes con colores
function Write-Status {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Blue
}

function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

# Función para verificar si un comando existe
function Test-Command {
    param([string]$Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

# Función para verificar Neovim
function Test-Neovim {
    if (-not (Test-Command "nvim")) {
        Write-Error "Neovim no está instalado. Por favor, instálalo primero:"
        Write-Host "  choco install neovim" -ForegroundColor Yellow
        exit 1
    }
    
    # Verificar versión mínima
    $nvimVersion = (nvim --version | Select-Object -First 1) -split " " | Select-Object -Index 1
    $requiredVersion = "0.8.0"
    
    if ([version]$nvimVersion -lt [version]$requiredVersion) {
        Write-Error "Neovim versión $nvimVersion detectada. Se requiere versión $requiredVersion o superior."
        exit 1
    }
    
    Write-Success "Neovim $nvimVersion detectado"
}

# Función para instalar Chocolatey
function Install-Chocolatey {
    if (-not (Test-Command "choco")) {
        Write-Status "Instalando Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        # Refrescar variables de entorno
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    }
}

# Función para instalar dependencias
function Install-Dependencies {
    Write-Status "Instalando dependencias..."
    
    $packages = @(
        "git",
        "nodejs",
        "python",
        "rust",
        "fd",
        "ripgrep",
        "fzf",
        "debugpy",
        "delve",
        "stylua",
        "black",
        "isort",
        "prettier",
        "rustfmt",
        "gofmt",
        "clang-format",
        "make",
        "cmake",
        "ninja"
    )
    
    foreach ($package in $packages) {
        if (-not (Test-Command $package)) {
            Write-Status "Instalando $package..."
            choco install $package -y
        } else {
            Write-Success "$package ya está instalado"
        }
    }
}

# Función para crear directorios
function New-Directories {
    Write-Status "Creando directorios necesarios..."
    
    $directories = @(
        "$env:USERPROFILE\Pictures\screenshots",
        "$env:USERPROFILE\Pictures\wallpapers",
        "$env:USERPROFILE\Videos\neovim_recordings"
    )
    
    foreach ($dir in $directories) {
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
            Write-Success "Directorio creado: $dir"
        } else {
            Write-Success "Directorio ya existe: $dir"
        }
    }
}

# Función para configurar variables de entorno
function Set-EnvironmentVariables {
    Write-Status "Configurando variables de entorno..."
    
    $envVar = "OPENAI_API_KEY"
    $envValue = "tu-api-key-aqui"
    
    # Verificar si ya existe
    $currentValue = [Environment]::GetEnvironmentVariable($envVar, "User")
    
    if (-not $currentValue) {
        [Environment]::SetEnvironmentVariable($envVar, $envValue, "User")
        Write-Success "Variable de entorno $envVar configurada"
    } else {
        Write-Warning "Variable de entorno $envVar ya está configurada"
    }
}

# Función principal
function Main {
    Write-Host @"
╔══════════════════════════════════════════════════════════════╗
║                    Neodots - Neovim Setup                   ║
║                Configuración Moderna y Completa             ║
╚══════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Blue
    
    Write-Status "Sistema operativo detectado: Windows"
    
    # Verificar Neovim
    Test-Neovim
    
    # Instalar Chocolatey si es necesario
    Install-Chocolatey
    
    # Instalar dependencias
    Install-Dependencies
    
    # Crear directorios
    New-Directories
    
    # Configurar variables de entorno
    Set-EnvironmentVariables
    
    Write-Success "¡Instalación completada!"
    Write-Host ""
    Write-Host "Próximos pasos:" -ForegroundColor Yellow
    Write-Host "1. Configura tu API key de OpenAI:"
    Write-Host "   [Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'tu-api-key-aqui', 'User')"
    Write-Host ""
    Write-Host "2. Inicia Neovim para instalar plugins automáticamente:"
    Write-Host "   nvim"
    Write-Host ""
    Write-Host "3. Consulta el README.md para más información sobre el uso"
    Write-Host ""
    Write-Host "¡Disfruta programando con Neodots! 🚀" -ForegroundColor Green
}

# Función para sincronizar los archivos de configuración
function Sync-ConfigFiles {
    Write-Status "Sincronizando archivos de configuración a $env:LOCALAPPDATA\nvim..."
    $configDir = "$env:LOCALAPPDATA\nvim"
    $sourceDir = (Get-Location).Path

    # Crear el directorio si no existe
    if (-not (Test-Path $configDir)) {
        New-Item -ItemType Directory -Path $configDir -Force | Out-Null
    }

    # Copiar archivos, excluyendo el control de versiones y los propios instaladores
    $exclude = @(".git", ".github", "install.sh", "install.ps1", "README.md")
    Get-ChildItem -Path $sourceDir -Recurse -Exclude $exclude | ForEach-Object {
        $destination = $_.FullName.Replace($sourceDir, $configDir)
        if ($_.PSIsContainer) {
            if (-not (Test-Path $destination)) {
                New-Item -ItemType Directory -Path $destination -Force | Out-Null
            }
        } else {
            Copy-Item -Path $_.FullName -Destination $destination -Force
        }
    }

    Write-Success "Archivos de configuración sincronizados."
}

# Función principal
function Main {
    Write-Host @"
   ╔══════════════════════════════════════════════════════════════╗
   ║                    Neodots - Neovim Setup                   ║
   ║                Configuración Moderna y Completa             ║
   ╚══════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Blue
    
    # Sincronizar archivos de configuración primero
    Sync-ConfigFiles

    Write-Status "Sistema operativo detectado: Windows"
    
    # Verificar Neovim
    Test-Neovim
    
    # Instalar Chocolatey si es necesario
    Install-Chocolatey
    
    # Instalar dependencias
    Install-Dependencies
    
    # Crear directorios
    New-Directories
    
    # Configurar variables de entorno
    Set-EnvironmentVariables
    
    Write-Success "¡Instalación completada!"
    Write-Host ""
    Write-Host "Próximos pasos:" -ForegroundColor Yellow
    Write-Host "1. Configura tu API key de OpenAI:"
    Write-Host "   [Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'tu-api-key-aqui', 'User')"
    Write-Host ""
    Write-Host "2. Inicia Neovim para instalar plugins automáticamente:"
    Write-Host "   nvim"
    Write-Host ""
    Write-Host "3. Consulta el README.md para más información sobre el uso"
    Write-Host ""
    Write-Host "¡Disfruta programando con Neodots! 🚀" -ForegroundColor Green
}

# Ejecutar función principal
Main
