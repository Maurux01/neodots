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
    
    PACKAGES=("git" "nodejs" "npm" "python3" "python3-pip" "rustc" "cargo" "fd-find" "ripgrep" "fzf" "ffmpeg" "feh" "make" "cmake" "ninja-build")
    
    # Función de barra de progreso mejorada
    progress_bar() {
        local duration=${1}
        local elapsed=0
        already_done() { for ((done=0; done<$elapsed; done++)); do printf "#"; done }
        remaining() { for ((remain=$elapsed; remain<$duration; remain++)); do printf "."; done }
        percentage() { printf "| %s%%" $(( ($elapsed * 100) / $duration )); }
        clean_line() { printf "\r"; }

        for (( elapsed=1; elapsed<=$duration; elapsed++ )); do
            already_done; remaining; percentage
            sleep 1  # Más tiempo para mejor visibilidad
            clean_line
        done
        clean_line
    }

    if command_exists apt; then
        print_status "Instalando dependencias para Ubuntu/Debian..."
        sudo apt update
        if ! sudo apt install -y "${PACKAGES[@]}"; then
            print_error "Error al instalar paquetes con apt"
            return 1
        fi
        progress_bar ${#PACKAGES[@]}
    elif command_exists dnf; then
        print_status "Instalando dependencias para Fedora..."
        if ! sudo dnf install -y "${PACKAGES[@]}"; then
            print_error "Error al instalar paquetes con dnf"
            return 1
        fi
        progress_bar ${#PACKAGES[@]}
    elif command_exists pacman; then
        print_status "Instalando dependencias para Arch Linux..."
        sudo pacman -Syu --noconfirm
        if ! sudo pacman -S --noconfirm "${PACKAGES[@]}"; then
            print_error "Error al instalar paquetes con pacman"
            return 1
        fi
        progress_bar ${#PACKAGES[@]}
    elif command_exists zypper; then
        print_status "Instalando dependencias para openSUSE..."
        if ! sudo zypper install -y "${PACKAGES[@]}"; then
            print_error "Error al instalar paquetes con zypper"
            return 1
        fi
        progress_bar ${#PACKAGES[@]}
    elif command_exists emerge; then
        print_status "Instalando dependencias para Gentoo..."
        if ! sudo emerge --ask --noreplace "${PACKAGES[@]}"; then
            print_error "Error al instalar paquetes con emerge"
            return 1
        fi
        progress_bar ${#PACKAGES[@]}
    else
        print_error "No se pudo detectar el gestor de paquetes. Instala manualmente..."
        return 1
    fi

    # Instalar herramientas adicionales con verificación
    print_status "Instalando herramientas adicionales..."
    
    if command_exists pip3; then
        if pip3 install debugpy pytest black isort; then
            print_success "Herramientas Python instaladas correctamente"
        else
            print_warning "Error al instalar herramientas Python"
        fi
    else
        print_warning "pip3 no encontrado, omitiendo instalación de herramientas Python"
    fi
    
    if command_exists npm; then
        if npm install -g prettier; then
            print_success "Prettier instalado correctamente"
        else
            print_warning "Error al instalar Prettier"
        fi
    else
        print_warning "npm no encontrado, omitiendo instalación de Prettier"
    fi
    
    if command_exists rustup; then
        if rustup component add rustfmt; then
            print_success "rustfmt instalado correctamente"
        else
            print_warning "Error al instalar rustfmt"
        fi
    else
        print_warning "rustup no encontrado, omitiendo instalación de rustfmt"
    fi
    
    if command_exists go; then
        if go install mvdan.cc/sh/v3/cmd/shfmt@latest; then
            print_success "shfmt instalado correctamente"
        else
            print_warning "Error al instalar shfmt"
        fi
    else
        print_warning "go no encontrado, omitiendo instalación de shfmt"
    fi
}

# Función para instalar dependencias en macOS
install_macos_deps() {
    print_status "Instalando dependencias para macOS..."
    

    PACKAGES=("git" "node" "python" "rust" "fd" "ripgrep" "fzf" "ffmpeg" "make" "cmake" "ninja")

    # Función de barra de progreso mejorada
    progress_bar() {
        local duration=${1}
        local elapsed=0
        already_done() { for ((done=0; done<$elapsed; done++)); do printf "#"; done }
        remaining() { for ((remain=$elapsed; remain<$duration; remain++)); do printf "."; done }
        percentage() { printf "| %s%%" $(( ($elapsed * 100) / $duration )); }
        clean_line() { printf "\r"; }

        for (( elapsed=1; elapsed<=$duration; elapsed++ )); do
            already_done; remaining; percentage
            sleep 1  # Más tiempo para mejor visibilidad
            clean_line
        done
        clean_line
    }

    if ! command_exists brew; then
        print_status "Instalando Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    if ! brew install "${PACKAGES[@]}"; then
        print_error "Error al instalar paquetes con brew"
        return 1
    fi
    progress_bar ${#PACKAGES[@]}

    # Instalar herramientas adicionales con verificación
    print_status "Instalando herramientas adicionales..."
    
    if command_exists pip3; then
        if pip3 install debugpy pytest black isort; then
            print_success "Herramientas Python instaladas correctamente"
        else
            print_warning "Error al instalar herramientas Python"
        fi
    else
        print_warning "pip3 no encontrado, omitiendo instalación de herramientas Python"
    fi
    
    if command_exists npm; then
        if npm install -g prettier; then
            print_success "Prettier instalado correctamente"
        else
            print_warning "Error al instalar Prettier"
        fi
    else
        print_warning "npm no encontrado, omitiendo instalación de Prettier"
    fi
    
    if command_exists rustup; then
        if rustup component add rustfmt; then
            print_success "rustfmt instalado correctamente"
        else
            print_warning "Error al instalar rustfmt"
        fi
    else
        print_warning "rustup no encontrado, omitiendo instalación de rustfmt"
    fi
    
    if command_exists go; then
        if go install mvdan.cc/sh/v3/cmd/shfmt@latest; then
            print_success "shfmt instalado correctamente"
        else
            print_warning "Error al instalar shfmt"
        fi
    else
        print_warning "go no encontrado, omitiendo instalación de shfmt"
    fi
}

# Función para instalar dependencias en Windows
install_windows_deps() {
    print_warning "Este script no está diseñado para instalar dependencias directamente en Windows."
    print_status "Por favor, ejecuta el script 'install.ps1' en una terminal de PowerShell con permisos de administrador."
    echo "Para hacerlo, abre PowerShell y ejecuta:"
    echo "Set-ExecutionPolicy Unrestricted -Scope Process -Force; .\install.ps1"
    exit 1
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

# Función para sincronizar los archivos de configuración
sync_config_files() {
    print_status "Sincronizando archivos de configuración a ~/.config/nvim..."
    CONFIG_DIR="$HOME/.config/nvim"
    SOURCE_DIR="$(pwd)"

    # Crear el directorio si no existe
    mkdir -p "$CONFIG_DIR"

    # Copiar archivos, excluyendo el control de versiones y los propios instaladores
    if command_exists rsync; then
        print_status "Usando rsync para sincronización eficiente..."
        if rsync -av --delete "$SOURCE_DIR/" "$CONFIG_DIR/" --exclude ".git" --exclude ".github" --exclude "install.sh" --exclude "install.ps1" --exclude "README.md" --exclude "*.md" --exclude "*.log"; then
            print_success "Archivos sincronizados correctamente con rsync"
        else
            print_warning "Error al usar rsync, intentando con cp..."
            sync_with_cp
        fi
    else
        print_warning "rsync no encontrado. Usando 'cp' para copiar archivos..."
        sync_with_cp
    fi
}

# Función auxiliar para copiar archivos con cp
sync_with_cp() {
    local source_dir="$1"
    local config_dir="$2"
    
    # Usamos 'shopt -s dotglob' para incluir archivos ocultos (dotfiles) en la copia
    shopt -s dotglob
    if cp -r "$source_dir"/* "$config_dir/"; then
        print_success "Archivos copiados correctamente con cp"
    else
        print_error "Error al copiar archivos con cp"
        shopt -u dotglob
        return 1
    fi
    shopt -u dotglob
    
    # Eliminar archivos que no deberían estar en la configuración
    local files_to_remove=("install.sh" "install.ps1" "README.md" ".git" ".github")
    for file in "${files_to_remove[@]}"; do
        if [ -e "$config_dir/$file" ]; then
            rm -rf "$config_dir/$file"
        fi
    done
}

# Función principal
main() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    Neodots - Neovim Setup                   ║"
    echo "║                Configuración Moderna y Completa             ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"

    read -p "El script instalará todas las dependencias y configurará Neodots. ¿Deseas continuar? (s/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        print_warning "Instalación cancelada por el usuario."
        exit 1
    fi
    
    # Sincronizar archivos de configuración primero
    sync_config_files

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
    echo "1. Configura tu API key de OpenAI en tu archivo de shell (.bashrc, .zshrc, etc.):"
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
