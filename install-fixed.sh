#!/bin/bash

# Neodots - Modern Neovim Configuration Installer
# Fast and reliable installer for Linux/macOS systems

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print messages
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

# Function to detect operating system
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

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect Linux distribution
detect_linux_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    elif [ -f /etc/redhat-release ]; then
        echo "rhel"
    elif [ -f /etc/arch-release ]; then
        echo "arch"
    else
        echo "unknown"
    fi
}

# Function to install dependencies
install_deps() {
    print_status "Installing dependencies..."
    
    OS=$(detect_os)
    
    if [[ "$OS" == "linux" ]]; then
        # Detect specific distribution
        DISTRO=$(detect_linux_distro)
        print_status "Detected distribution: $DISTRO"
        
        # Essential packages for Neodots
        case $DISTRO in
            "ubuntu"|"debian")
                PACKAGES=("git" "curl" "nodejs" "npm" "python3" "python3-pip" "build-essential" "ripgrep" "fd-find" "fzf" "unzip")
                ;;
            "fedora"|"rhel"|"centos")
                PACKAGES=("git" "curl" "nodejs" "npm" "python3" "python3-pip" "gcc" "gcc-c++" "make" "ripgrep" "fd-find" "fzf" "unzip")
                ;;
            "arch"|"manjaro")
                PACKAGES=("git" "curl" "nodejs" "npm" "python" "python-pip" "base-devel" "ripgrep" "fd" "fzf" "unzip")
                ;;
            "opensuse"|"suse")
                PACKAGES=("git" "curl" "nodejs" "npm" "python3" "python3-pip" "gcc" "gcc-c++" "make" "ripgrep" "fd" "fzf" "unzip")
                ;;
            *)
                PACKAGES=("git" "curl" "nodejs" "npm" "python3" "build-essential" "unzip")
                print_warning "Distribution not specifically supported. Installing basic packages."
                ;;
        esac
    elif [[ "$OS" == "macos" ]]; then
        print_status "Installing dependencies for macOS..."
        # Check if Homebrew is installed
        if ! command_exists brew; then
            print_status "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        
        PACKAGES=("git" "node" "python3" "ripgrep" "fd" "fzf")
        
        for pkg in "${PACKAGES[@]}"; do
            if brew install "$pkg"; then
                print_success "Installed: $pkg"
            else
                print_warning "Could not install: $pkg"
            fi
        done
        return 0
    fi

    # Install packages based on available package manager
    if command_exists apt; then
        print_status "Installing dependencies for Debian/Ubuntu systems..."
        sudo apt update
        for pkg in "${PACKAGES[@]}"; do
            if sudo apt install -y "$pkg"; then
                print_success "Installed: $pkg"
            else
                print_warning "Could not install: $pkg"
            fi
        done
    elif command_exists dnf; then
        print_status "Installing dependencies for Fedora/RHEL systems..."
        for pkg in "${PACKAGES[@]}"; do
            if sudo dnf install -y "$pkg"; then
                print_success "Installed: $pkg"
            else
                print_warning "Could not install: $pkg"
            fi
        done
    elif command_exists pacman; then
        print_status "Installing dependencies for Arch systems..."
        sudo pacman -Syu --noconfirm
        for pkg in "${PACKAGES[@]}"; do
            if sudo pacman -S --noconfirm "$pkg"; then
                print_success "Installed: $pkg"
            else
                print_warning "Could not install: $pkg"
            fi
        done
    elif command_exists zypper; then
        print_status "Installing dependencies for openSUSE systems..."
        for pkg in "${PACKAGES[@]}"; do
            if sudo zypper install -y "$pkg"; then
                print_success "Installed: $pkg"
            else
                print_warning "Could not install: $pkg"
            fi
        done
    else
        print_error "Could not detect a compatible package manager."
        print_warning "Please manually install the following packages:"
        printf '%s\n' "${PACKAGES[@]}"
        return 1
    fi

    print_success "Dependency installation completed"
}

# Function to install Neovim
install_neovim() {
    if command_exists nvim; then
        NVIM_VERSION=$(nvim --version | head -n1 | cut -d' ' -f2)
        print_success "Neovim $NVIM_VERSION already installed"
        return 0
    fi
    
    print_status "Installing Neovim..."
    
    OS=$(detect_os)
    
    if [[ "$OS" == "linux" ]]; then
        DISTRO=$(detect_linux_distro)
        
        case $DISTRO in
            "ubuntu"|"debian")
                # Install latest Neovim from PPA for Ubuntu/Debian
                sudo add-apt-repository ppa:neovim-ppa/unstable -y
                sudo apt update
                sudo apt install -y neovim
                ;;
            "fedora"|"rhel"|"centos")
                sudo dnf install -y neovim
                ;;
            "arch"|"manjaro")
                sudo pacman -S --noconfirm neovim
                ;;
            "opensuse"|"suse")
                sudo zypper install -y neovim
                ;;
            *)
                # Fallback: download AppImage
                print_status "Downloading Neovim AppImage..."
                curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
                chmod u+x nvim.appimage
                sudo mv nvim.appimage /usr/local/bin/nvim
                ;;
        esac
    elif [[ "$OS" == "macos" ]]; then
        brew install neovim
    fi
    
    if command_exists nvim; then
        print_success "Neovim installed successfully!"
    else
        print_error "Failed to install Neovim"
        exit 1
    fi
}

# Function to backup existing config
backup_config() {
    NVIM_CONFIG="$HOME/.config/nvim"
    
    if [ -d "$NVIM_CONFIG" ]; then
        BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d-%H%M%S)"
        print_status "Backing up existing Neovim config to $BACKUP_DIR"
        mv "$NVIM_CONFIG" "$BACKUP_DIR"
        print_success "Backup created: $BACKUP_DIR"
    fi
}

# Function to install Neodots config
install_neodots() {
    print_status "Installing Neodots configuration..."
    
    NVIM_CONFIG="$HOME/.config/nvim"
    
    # Clone the repository
    git clone https://github.com/maurux01/neodots.git "$NVIM_CONFIG"
    
    print_success "Neodots configuration installed!"
}

# Function to install Nerd Font
install_nerd_font() {
    print_status "Installing JetBrains Mono Nerd Font..."
    
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
    
    # Download and install JetBrains Mono Nerd Font
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
    
    if command_exists curl; then
        curl -fLo "/tmp/JetBrainsMono.zip" "$FONT_URL"
    elif command_exists wget; then
        wget -O "/tmp/JetBrainsMono.zip" "$FONT_URL"
    else
        print_warning "Neither curl nor wget found. Skipping font installation."
        return 1
    fi
    
    unzip -o "/tmp/JetBrainsMono.zip" -d "$FONT_DIR"
    rm "/tmp/JetBrainsMono.zip"
    
    # Refresh font cache
    if command_exists fc-cache; then
        fc-cache -fv
    fi
    
    print_success "JetBrains Mono Nerd Font installed!"
}

# Main function
main() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    Neodots - Neovim Setup                   ║"
    echo "║                Modern and Complete Configuration            ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"

    read -p "The script will install all dependencies and configure Neodots. Do you want to continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Installation cancelled by user."
        exit 1
    fi
    
    # Install Neovim
    install_neovim
    
    # Install dependencies
    install_deps
    
    # Install Nerd Font
    install_nerd_font
    
    # Backup existing config
    backup_config
    
    # Install Neodots
    install_neodots
    
    print_success "Installation completed!"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Start Neovim to automatically install plugins:"
    echo "   nvim"
    echo ""
    echo "2. Check README.md for more usage information"
    echo ""
    echo -e "${GREEN}Happy coding with Neodots! 🚀${NC}"
}

# Execute main function
main "$@"
