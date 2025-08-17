#!/bin/bash

# Neodots - Neovim Configuration Installer
# Script de instalación automática

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Función para detectar el sistema operativo
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        OS="windows"
    else
        OS="unknown"
    fi
    echo $OS
}

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Función para instalar dependencias en Linux
install_linux_deps() {
    print_status "Instalando dependencias para Linux..."
    
    if command_exists apt; then
        # Ubuntu/Debian
        print_status "Instalando dependencias para Ubuntu/Debian..."
        sudo apt update
        sudo apt install -y git nodejs npm python3 python3-pip rustc cargo fd-find ripgrep fzf ffmpeg feh make cmake ninja-build
        
        # Crear symlink para fd
        if ! command_exists fd; then
            sudo ln -s /usr/bin/fd-find /usr/bin/fd
        fi
        
        # Instalar herramientas de debugging y testing
        pip3 install debugpy pytest black isort
        
        # Instalar formateadores
        npm install -g prettier
        rustup component add rustfmt
        go install mvdan.cc/sh/v3/cmd/shfmt@latest
    elif command_exists dnf; then
        # Fedora
        print_status "Instalando dependencias para Fedora..."
        sudo dnf install -y git nodejs npm python3 python3-pip rust cargo fd-find ripgrep fzf ffmpeg feh make cmake ninja-build
        
        # Instalar herramientas de debugging y testing
        pip3 install debugpy pytest black isort
        
        # Instalar formateadores
        npm install -g prettier
        rustup component add rustfmt
        go install mvdan.cc/sh/v3/cmd/shfmt@latest
    elif command_exists pacman; then
        # Arch Linux
        print_status "Instalando dependencias para Arch Linux..."
        sudo pacman -Syu --noconfirm
        sudo pacman -S --noconfirm git nodejs npm python python-pip rust cargo fd ripgrep fzf ffmpeg feh make cmake ninja
        
        # Instalar herramientas de debugging y testing
        pip3 install debugpy pytest black isort
        
        # Instalar formateadores
        npm install -g prettier
        rustup component add rustfmt
        go install mvdan.cc/sh/v3/cmd/shfmt@latest
    elif command_exists zypper; then
        # openSUSE
        print_status "Instalando dependencias para openSUSE..."
        sudo zypper install -y git nodejs npm python3 python3-pip rust cargo fd ripgrep fzf ffmpeg feh make cmake ninja
        
        # Instalar herramientas de debugging y testing
        pip3 install debugpy pytest black isort
        
        # Instalar formateadores
        npm install -g prettier
        rustup component add rustfmt
        go install mvdan.cc/sh/v3/cmd/shfmt@latest
    elif command_exists emerge; then
        # Gentoo
        print_status "Instalando dependencias para Gentoo..."
        sudo emerge --ask --noreplace dev-vcs/git net-libs/nodejs dev-lang/python dev-lang/rust app-misc/fd sys-apps/ripgrep app-misc/fzf media-video/ffmpeg media-gfx/feh dev-util/cmake dev-util/ninja
        
        # Instalar herramientas de debugging y testing
        pip3 install debugpy pytest black isort
        
        # Instalar formateadores
        npm install -g prettier
        rustup component add rustfmt
        go install mvdan.cc/sh/v3/cmd/shfmt@latest
    else
        print_error "No se pudo detectar el gestor de paquetes. Instala manualmente:"
        echo "  - git, nodejs, python3, rust, fd, ripgrep, fzf, ffmpeg, feh"
        echo "  - make, cmake, ninja"
        echo "  - debugpy, pytest, black, isort (via pip)"
        echo "  - prettier (via npm)"
        echo "  - rustfmt (via rustup)"
        return 1
    fi
}

# Función para instalar dependencias en macOS
install_macos_deps() {
    print_status "Instalando dependencias para macOS..."
    
    if ! command_exists brew; then
        print_status "Instalando Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    brew install git node python rust fd ripgrep fzf ffmpeg make cmake ninja
    
    # Instalar herramientas de debugging y testing
    pip3 install debugpy pytest black isort
    
    # Instalar formateadores
    npm install -g prettier
    rustup component add rustfmt
    go install mvdan.cc/sh/v3/cmd/shfmt@latest
}

# Función para instalar dependencias en Windows
install_windows_deps() {
    print_status "Instalando dependencias para Windows..."
    
    if ! command_exists choco; then
        print_status "Instalando Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    fi
    
    choco install -y git nodejs python rust fd ripgrep fzf
}

# Función para verificar Neovim
check_neovim() {
    if ! command_exists nvim; then
        print_error "Neovim no está instalado. Por favor, instálalo primero:"
        echo "  Ubuntu/Debian: sudo apt install neovim"
        echo "  Arch Linux: sudo pacman -S neovim"
        echo "  Fedora: sudo dnf install neovim"
        echo "  openSUSE: sudo zypper install neovim"
        echo "  Gentoo: sudo emerge --ask app-editors/neovim"
        echo "  macOS: brew install neovim"
        echo "  Windows: choco install neovim"
        exit 1
    fi
    
    # Verificar versión mínima
    NVIM_VERSION=$(nvim --version | head -n1 | cut -d' ' -f2)
    REQUIRED_VERSION="0.8.0"
    
    if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$NVIM_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
        print_error "Neovim versión $NVIM_VERSION detectada. Se requiere versión $REQUIRED_VERSION o superior."
        exit 1
    fi
    
    print_success "Neovim $NVIM_VERSION detectado"
}

# Función para crear directorios necesarios
create_directories() {
    print_status "Creando directorios necesarios..."
    
    mkdir -p ~/Pictures/screenshots
    mkdir -p ~/Pictures/wallpapers
    mkdir -p ~/Videos/neovim_recordings
    
    print_success "Directorios creados"
}

# Función para configurar variables de entorno
setup_environment() {
    print_status "Configurando variables de entorno..."
    
    # Agregar a .bashrc o .zshrc
    SHELL_RC=""
    if [ -f ~/.bashrc ]; then
        SHELL_RC=~/.bashrc
    elif [ -f ~/.zshrc ]; then
        SHELL_RC=~/.zshrc
    fi
    
    if [ -n "$SHELL_RC" ]; then
        # Verificar si ya existe la configuración
        if ! grep -q "OPENAI_API_KEY" "$SHELL_RC"; then
            echo "" >> "$SHELL_RC"
            echo "# Neodots - Neovim Configuration" >> "$SHELL_RC"
            echo "export OPENAI_API_KEY=\"tu-api-key-aqui\"" >> "$SHELL_RC"
            print_success "Variables de entorno agregadas a $SHELL_RC"
        else
            print_warning "Variables de entorno ya configuradas en $SHELL_RC"
        fi
    else
        print_warning "No se encontró .bashrc o .zshrc. Configura manualmente:"
        echo "export OPENAI_API_KEY=\"tu-api-key-aqui\""
    fi
}

# Función principal
main() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    Neodots - Neovim Setup                   ║"
    echo "║                Configuración Moderna y Completa             ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    # Detectar sistema operativo
    OS=$(detect_os)
    print_status "Sistema operativo detectado: $OS"
    
    # Verificar Neovim
    check_neovim
    
    # Instalar dependencias según el OS
    case $OS in
        "linux")
            install_linux_deps
            ;;
        "macos")
            install_macos_deps
            ;;
        "windows")
            install_windows_deps
            ;;
        *)
            print_error "Sistema operativo no soportado: $OS"
            exit 1
            ;;
    esac
    
    # Crear directorios
    create_directories
    
    # Configurar variables de entorno
    setup_environment
    
    print_success "¡Instalación completada!"
    echo ""
    echo -e "${YELLOW}Próximos pasos:${NC}"
    echo "1. Configura tu API key de OpenAI:"
    echo "   export OPENAI_API_KEY=\"tu-api-key-aqui\""
    echo ""
    echo "2. Inicia Neovim para instalar plugins automáticamente:"
    echo "   nvim"
    echo ""
    echo "3. Consulta el README.md para más información sobre el uso"
    echo ""
    echo -e "${GREEN}¡Disfruta programando con Neodots! 🚀${NC}"
}

# Ejecutar función principal
main "$@"
