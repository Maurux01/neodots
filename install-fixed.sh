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
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        echo "windows"
    else
        echo "unknown"
    fi
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect Linux distribution
detect_linux_distro() {
    # shellcheck disable=SC1091
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

# Function to install packages with detected package manager
install_packages_with_manager() {
    local packages=("$@")
    
    if command_exists apt; then
        print_status "Installing dependencies for Debian/Ubuntu systems..."
        if ! sudo apt update; then
            print_error "Failed to update package list"
            return 1
        fi
        for pkg in "${packages[@]}"; do
            if sudo apt install -y "$pkg" 2>/dev/null; then
                print_success "Installed: $pkg"
            else
                print_warning "Could not install: $pkg"
            fi
        done
    elif command_exists dnf; then
        print_status "Installing dependencies for Fedora/RHEL systems..."
        for pkg in "${packages[@]}"; do
            if sudo dnf install -y "$pkg" 2>/dev/null; then
                print_success "Installed: $pkg"
            else
                print_warning "Could not install: $pkg"
            fi
        done
    elif command_exists pacman; then
        print_status "Installing dependencies for Arch systems..."
        if ! sudo pacman -Syu --noconfirm; then
            print_error "Failed to update package database"
            return 1
        fi
        for pkg in "${packages[@]}"; do
            if sudo pacman -S --noconfirm "$pkg" 2>/dev/null; then
                print_success "Installed: $pkg"
            else
                print_warning "Could not install: $pkg"
            fi
        done
    elif command_exists zypper; then
        print_status "Installing dependencies for openSUSE systems..."
        for pkg in "${packages[@]}"; do
            if sudo zypper install -y "$pkg" 2>/dev/null; then
                print_success "Installed: $pkg"
            else
                print_warning "Could not install: $pkg"
            fi
        done
    else
        print_error "Could not detect a compatible package manager."
        print_warning "Please manually install the following packages:"
        printf '%s\n' "${packages[@]}"
        return 1
    fi
}

# Function to install dependencies
install_deps() {
    local os="$1"
    local distro="$2"
    
    print_status "Installing dependencies..."
    
    if [[ "$os" == "linux" ]]; then
        print_status "Detected distribution: $distro"
        
        # Essential packages for Neodots
        case $distro in
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
        
        install_packages_with_manager "${PACKAGES[@]}"
        
    elif [[ "$os" == "macos" ]]; then
        print_status "Installing dependencies for macOS..."
        # Check if Homebrew is installed
        if ! command_exists brew; then
            print_status "Installing Homebrew..."
            if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
                print_error "Failed to install Homebrew"
                return 1
            fi
        fi
        
        PACKAGES=("git" "node" "python3" "ripgrep" "fd" "fzf")
        
        for pkg in "${PACKAGES[@]}"; do
            if brew install "$pkg" 2>/dev/null; then
                print_success "Installed: $pkg"
            else
                print_warning "Could not install: $pkg"
            fi
        done
    fi

    print_success "Dependency installation completed"
}

# Function to install Neovim
install_neovim() {
    local os="$1"
    local distro="$2"
    
    if command_exists nvim; then
        NVIM_VERSION=$(nvim --version | head -n1 | cut -d' ' -f2)
        print_success "Neovim $NVIM_VERSION already installed"
        return 0
    fi
    
    print_status "Installing Neovim..."
    
    if [[ "$os" == "linux" ]]; then
        case $distro in
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
                if ! curl -fLO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage; then
                    print_error "Failed to download Neovim AppImage"
                    return 1
                fi
                chmod u+x nvim.appimage
                sudo mv nvim.appimage /usr/local/bin/nvim
                ;;
        esac
    elif [[ "$os" == "macos" ]]; then
        if ! brew install neovim; then
            print_error "Failed to install Neovim via Homebrew"
            return 1
        fi
    fi
    
    if command_exists nvim; then
        print_success "Neovim installed successfully!"
    else
        print_error "Failed to install Neovim"
        exit 1
    fi
}

# Function to remove existing config
remove_existing_config() {
    NVIM_CONFIG="$HOME/.config/nvim"
    NVIM_DATA="$HOME/.local/share/nvim"
    NVIM_STATE="$HOME/.local/state/nvim"
    
    print_status "Removing existing Neovim configuration and data..."
    
    if [ -d "$NVIM_CONFIG" ]; then
        rm -rf "$NVIM_CONFIG"
        print_success "Removed existing config"
    fi
    
    if [ -d "$NVIM_DATA" ]; then
        rm -rf "$NVIM_DATA"
        print_success "Removed existing data"
    fi
    
    if [ -d "$NVIM_STATE" ]; then
        rm -rf "$NVIM_STATE"
        print_success "Removed existing state"
    fi
}

# Function to install Neodots config
install_neodots() {
    print_status "Copying Neodots configuration..."
    
    NVIM_CONFIG="$HOME/.config/nvim"
    
    # Create config directory
    mkdir -p "$HOME/.config"
    
    # Copy current directory to nvim config
    cp -r "." "$NVIM_CONFIG"
    
    print_success "Neodots configuration copied!"
}

# Function to install Nerd Font
install_nerd_font() {
    print_status "Installing JetBrains Mono Nerd Font..."
    
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"
    
    # Download and install JetBrains Mono Nerd Font
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
    
    if command_exists curl; then
        if ! curl -fLo "/tmp/JetBrainsMono.zip" "$FONT_URL"; then
            print_error "Failed to download font with curl"
            return 1
        fi
    elif command_exists wget; then
        if ! wget -O "/tmp/JetBrainsMono.zip" "$FONT_URL"; then
            print_error "Failed to download font with wget"
            return 1
        fi
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
    
    # Cache OS and distro detection
    local os distro
    os=$(detect_os)
    if [[ "$os" == "linux" ]]; then
        distro=$(detect_linux_distro)
    fi
    
    # Install Neovim
    install_neovim "$os" "$distro"
    
    # Install dependencies
    install_deps "$os" "$distro"
    
    # Install Nerd Font
    install_nerd_font
    
    # Remove existing config
    remove_existing_config
    
    # Install Neodots
    install_neodots
    
    print_success "Installation completed!"
    echo ""
    echo -e "${GREEN}Starting Neovim automatically...${NC}"
    echo ""
    
    # Start Neovim automatically
    nvim
}

# Execute main function
main "$@"