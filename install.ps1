# Neodots - Neovim Configuration Installer for Windows
# Script de instalacion automatica para PowerShell

param(
    [switch]$Force
)

# Funcion para imprimir mensajes con colores
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

# Funcion para una barra de progreso personalizada
function Write-CustomProgress {
    param(
        [int]$Percent,
        [string]$Title = "Progreso"
    )
    $width = 50
    $complete = [int](($Percent / 100) * $width)
    $incomplete = $width - $complete
    $bar = '█' * $complete + '░' * $incomplete
    Write-Host "`r$Title`: [$bar] $Percent% " -NoNewline
}

# Funcion para verificar si un comando existe
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

# Funcion para verificar Neovim
function Test-Neovim {
    if (-not (Test-Command "nvim")) {
        Write-Error "Neovim no esta instalado. Por favor, instalalo primero:"
        Write-Host "  choco install neovim" -ForegroundColor Yellow
        exit 1
    }
    
    # Verificar versión mínima
    $nvimVersion = ((nvim --version | Select-Object -First 1) -split " " | Select-Object -Index 1) -replace '^v'
    $requiredVersion = "0.8.0"
    
    if ([version]$nvimVersion -lt [version]$requiredVersion) {
        Write-Error "Neovim version $nvimVersion detectada. Se requiere version $requiredVersion o superior."
        exit 1
    }
    
    Write-Success "Neovim $nvimVersion detectado"
}

# Funcion para instalar Chocolatey
function Install-Chocolatey {
    if (-not (Test-Command "choco")) {
        Write-Status "Instalando Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        # Refrescar variables de entorno
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    }
}

# Funcion para instalar dependencias
function Install-Dependencies {
    Write-Status "Instalando dependencias..."
    
    $packages = @(
        "git", "nodejs", "python", "rust", "fd", "ripgrep", "fzf", "debugpy", 
        "delve", "stylua", "black", "isort", "prettier", "rustfmt", "gofmt", 
        "clang-format", "make", "cmake", "ninja"
    )
    
    $total = $packages.Count
    $completed = 0

    foreach ($package in $packages) {
        $completed++
        $percent = [int](($completed / $total) * 100)
        $op = "Instalando {0,-15}" -f $package
        Write-CustomProgress -Percent $percent -Title $op

        if (-not (Test-Command $package)) {
            choco install $package -y --no-progress | Out-Null
        }
    }
    Write-Host "" # Salto de línea final para la barra de progreso
}

# Funcion para crear directorios
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

# Funcion para configurar variables de entorno
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
        Write-Warning "Variable de entorno $envVar ya esta configurada"
    }
}


# Funcion para sincronizar los archivos de configuracion
function Sync-ConfigFiles {
    Write-Status "Sincronizando archivos de configuracion a $env:LOCALAPPDATA\nvim..."
    $configDir = "$env:LOCALAPPDATA\nvim"
    $sourceDir = (Get-Location).Path

    # Crear el directorio si no existe
    if (-not (Test-Path $configDir)) {
        New-Item -ItemType Directory -Path $configDir -Force | Out-Null
    }

    # Usar robocopy para una copia mas robusta
    Write-Status "Copiando archivos de configuracion con robocopy..."
    robocopy $sourceDir $configDir /E /XF install.sh install.ps1 README.md /XD .git .github
    if ($LASTEXITCODE -ge 8) {
        Write-Error "Robocopy fallo con el codigo de salida: $LASTEXITCODE"
        exit 1
    }

    Write-Success "Archivos de configuracion sincronizados."
}

# Funcion principal
function Main {
    Write-Host @"
+--------------------------------------------------------------+
|                    Neodots - Neovim Setup                    |
|                Configuracion Moderna y Completa              |
+--------------------------------------------------------------+
"@ -ForegroundColor Blue

    # Confirmacion del usuario
    $confirmation = Read-Host -Prompt "El script instalara todas las dependencias y configurara Neodots. Deseas continuar? (s/n)"
    if ($confirmation -ne 's') {
        Write-Warning "Instalacion cancelada por el usuario."
        exit
    }
    
    # Sincronizar archivos de configuracion primero
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
    
    Write-Success "Instalacion completada!"
    Write-Host ""
    Write-Host "Proximos pasos:" -ForegroundColor Yellow
    Write-Host "1. Configura tu API key de OpenAI:"
    Write-Host "   [Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'tu-api-key-aqui', 'User')"
    Write-Host ""
    Write-Host "2. Inicia Neovim para instalar plugins automaticamente:"
    Write-Host "   nvim"
    Write-Host ""
    Write-Host "3. Consulta el README.md para mas informacion sobre el uso"
    Write-Host ""
    Write-Host "Disfruta programando con Neodots!" -ForegroundColor Green
}

# Ejecutar funcion principal
Main
