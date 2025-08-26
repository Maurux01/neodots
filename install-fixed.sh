#!/bin/bash

# Neodots - Neovim Configuration Installer
# Improved Linux installer script with better error handling and distribution support

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

# Function to install Linux dependencies
install_linux_deps() {
    print_status "Installing dependencies for Linux..."
    
    # Detect specific distribution
    DISTRO=$(detect_linux_distro)
    print_status "Detected distribution: $DISTRO"
    
    # Define packages based on distribution
    case $DISTRO in
        "ubuntu"|"debian")
            PACKAGES=("git" "nodejs" "npm" "python3" "python3-pip" "rustc" "cargo" "fd-find" "ripgrep" "fzf" "ffmpeg" "feh" "make" "cmake" "ninja-build")
            ;;
        "fedora"|"rhel"|"centos")
            PACKAGES=("git" "nodejs" "npm" "python3" "python3-pip" "rust" "cargo" "fd-find" "ripgrep" "fzf" "ffmpeg" "feh" "make" "cmake" "ninja-build")
            ;;
        "arch"|"manjaro")
            PACKAGES=("git" "nodejs" "npm" "python" "python-pip" "rust" "cargo" "fd" "ripgrep" "fzf" "ffmpeg" "feh" "make" "cmake" "ninja")
            ;;
        "opensuse"|"suse")
            PACKAGES=("git" "nodejs" "npm" "python3" "python3-pip" "rust" "cargo" "fd" "ripgrep" "fzf" "ffmpeg" "feh" "make" "cmake" "ninja")
            ;;
        *)
            PACKAGES=("git" "nodejs" "npm" "python3" "python3-pip" "make" "cmake")
            print_warning "Distribution not specifically supported. Installing basic packages."
            ;;
    esac

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

# Function to check Neovim
check_neovim() {
    if ! command_exists nvim; then
        print_error "Neovim is not installed. Please install it first:"
        echo "  Ubuntu/Debian: sudo apt install neovim"
        echo "  Arch Linux: sudo pacman -S neovim"
        echo "  Fedora: sudo dnf install neovim"
        echo "  openSUSE: sudo zypper install neovim"
        exit 1
    fi
    
    # Check minimum version
    NVIM_VERSION=$(nvim --version | head -n1 | cut -d' ' -f2)
    REQUIRED_VERSION="0.8.0"
    
    if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$NVIM_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
        print_error "Neovim version $NVIM_VERSION detected. Version $REQUIRED_VERSION or higher is required."
        exit 1
    fi
    
    print_success "Neovim $NVIM_VERSION detected"
}

# Function to create necessary directories
create_directories() {
    print_status "Creating necessary directories..."
    
    mkdir -p ~/Pictures/screenshots
    mkdir -p ~/Pictures/wallpapers
    mkdir -p ~/Videos/neovim_recordings
    
    print_success "Directories created"
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
    
    # Check Neovim
    check_neovim
    
    # Install Linux dependencies
    install_linux_deps
    
    # Create directories
    create_directories
    
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
