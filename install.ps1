# Neodots - Neovim Configuration Installer for Windows
# Script de instalacion automatica para PowerShell

# Requiere PowerShell 5.1 o superior
# Ejecutar como administrador para instalar dependencias

# Configuración de ejecución
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ErrorActionPreference = "Stop"

param(
    [switch]$Force
)

# Verificar si se está ejecutando como administrador
function Test-Administrator {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

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


# Función para sincronizar los archivos de configuración
function Sync-ConfigFiles {
    Write-Status "Sincronizando archivos de configuración a $env:LOCALAPPDATA\nvim..."
    $configDir = "$env:LOCALAPPDATA\nvim"
    $sourceDir = (Get-Location).Path

    try {
        # Crear el directorio si no existe
        if (-not (Test-Path $configDir)) {
            New-Item -ItemType Directory -Path $configDir -Force -ErrorAction Stop | Out-Null
            Write-Success "Directorio de configuración creado: $configDir"
        }

        # Usar robocopy para una copia más robusta
        Write-Status "Copiando archivos de configuración..."
        $excludeFiles = @('install.sh', 'install.ps1', 'README.md', '.gitignore')
        $excludeDirs = @('.git', '.github')
        
        # Construir argumentos para robocopy
        $robocopyArgs = @(
            '"$sourceDir"',
            '"$configDir"',
            '/E',          # Copiar subdirectorios, incluyendo vacíos
            '/COPY:DAT',   # Copiar datos, atributos y marcas de tiempo
            '/R:3',        # Reintentar 3 veces
            '/W:5',        # Esperar 5 segundos entre reintentos
            '/NP',         # No mostrar porcentaje de progreso
            '/NFL',        # No mostrar nombres de archivos
            '/NDL',        # No mostrar nombres de directorios
            '/NJH',        # No mostrar encabezado de trabajo
            '/NJS'         # No mostrar resumen
        )
        
        # Añadir exclusiones
        foreach ($file in $excludeFiles) {
            $robocopyArgs += "/XF"
            $robocopyArgs += "$file"
        }
        
        foreach ($dir in $excludeDirs) {
            $robocopyArgs += "/XD"
            $robocopyArgs += "$dir"
        }
        
        # Ejecutar robocopy
        $process = Start-Process -FilePath "robocopy.exe" -ArgumentList $robocopyArgs -NoNewWindow -PassThru -Wait
        
        # Robocopy devuelve códigos de salida especiales
        if ($process.ExitCode -ge 8) {
            throw "Robocopy falló con el código de salida: $($process.ExitCode)"
        }
        
        Write-Success "Archivos de configuración sincronizados correctamente."
    }
    catch {
        Write-Error "Error al sincronizar archivos: $_"
        exit 1
    }
}

# Función principal
function Main {
    # Mostrar banner
    Write-Host @"
+--------------------------------------------------------------+
|                    Neodots - Neovim Setup                    |
|                Configuración Moderna y Completa              |
+--------------------------------------------------------------+
"@ -ForegroundColor Blue
    
    # Mostrar información del sistema
    Write-Status "Sistema operativo: $((Get-CimInstance -ClassName Win32_OperatingSystem).Caption)"
    Write-Status "Versión de PowerShell: $($PSVersionTable.PSVersion)"
    
    # Verificar si se está ejecutando como administrador
    if (-not (Test-Administrator)) {
        Write-Warning "Este script requiere privilegios de administrador para instalar dependencias."
        Write-Host "  Por favor, ejecuta PowerShell como administrador y vuelve a intentarlo." -ForegroundColor Yellow
        Write-Host "  También puedes instalar manualmente las dependencias con Chocolatey." -ForegroundColor Yellow
        $choice = Read-Host "¿Deseas continuar sin privilegios de administrador? (s/n)"
        if ($choice -ne 's') {
            Write-Warning "Instalación cancelada."
            exit 1
        }
    }

    # Confirmación del usuario
    Write-Host ""
    Write-Host "Este script realizará las siguientes acciones:" -ForegroundColor Cyan
    Write-Host "1. Instalar dependencias (Chocolatey, Git, Node.js, etc.)"
    Write-Host "2. Copiar archivos de configuración a $env:LOCALAPPDATA\nvim"
    Write-Host "3. Configurar variables de entorno"
    Write-Host ""
    
    $confirmation = Read-Host -Prompt "¿Deseas continuar con la instalación? (s/n)"
    if ($confirmation -ne 's') {
        Write-Warning "Instalación cancelada por el usuario."
        exit 0
    }
    
    # Mostrar advertencia sobre el tiempo de instalación
    Write-Host ""
    Write-Warning "La instalación puede tomar varios minutos dependiendo de tu conexión a Internet."
    Write-Host "  No cierres esta ventana hasta que se complete la instalación." -ForegroundColor Yellow
    
    try {
        # 1. Sincronizar archivos de configuración primero
        Sync-ConfigFiles
        
        # 2. Verificar Neovim
        Test-Neovim
        
        # 3. Instalar Chocolatey si es necesario
        Install-Chocolatey
        
        # 4. Instalar dependencias
        Install-Dependencies
        
        # 5. Crear directorios
        New-Directories
        
        # 6. Configurar variables de entorno
        Set-EnvironmentVariables
        
        Write-Success "¡Instalación completada con éxito!"
    }
    catch {
        Write-Error "Error durante la instalación: $_"
        Write-Host ""
        Write-Host "Si el problema persiste, puedes intentar:" -ForegroundColor Yellow
        Write-Host "1. Ejecutar PowerShell como administrador"
        Write-Host "2. Verificar tu conexión a Internet"
        Write-Host "3. Instalar manualmente las dependencias con Chocolatey"
        exit 1
    }
    
    # Mostrar mensaje de finalización
    Write-Host ""
    Write-Host "+--------------------------------------------------------------+" -ForegroundColor Green
    Write-Host "|                 INSTALACIÓN COMPLETADA CON ÉXITO             |" -ForegroundColor Green
    Write-Host "+--------------------------------------------------------------+" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Siguientes pasos:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. Configura tu API key de OpenAI (opcional pero recomendado):"
    Write-Host "   [Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'tu-api-key-aqui', 'User')" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "2. Inicia Neovim para instalar los plugins automáticamente:"
    Write-Host "   nvim" -ForegroundColor Cyan
    Write-Host "   (La primera vez puede tardar varios minutos en instalar los plugins)"
    Write-Host ""
    Write-Host "3. Si tienes problemas, consulta la documentación en:"
    Write-Host "   https://github.com/Maurux01/neodots" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "¡Gracias por instalar Neodots! Disfruta programando. 🚀" -ForegroundColor Green
    Write-Host ""
    
    # Ofrecer abrir Neovim automáticamente
    $choice = Read-Host -Prompt "¿Deseas abrir Neovim ahora? (s/n)"
    if ($choice -eq 's') {
        nvim
    }
}

# Ejecutar funcion principal
Main
