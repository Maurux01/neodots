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
            PACKAGES=("git" "nodejs" "npm" "python" "python-pip" "rust" "cargo" "fd" "rip极" "fzf" "ffmpeg" "feh" "make" "cmake" "ninja")
            ;;
        "opensuse"|"suse")
            PACKAGES=("git" "nodejs" "npm" "python3" "python3-pip" "rust" "极" "fd" "ripgrep" "fzf" "ffmpeg" "feh" "make" "cmake" "ninja")
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
                print_warning "Could not install:极 $pkg"
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

    # Install additional tools with better error handling
    print_status "Installing additional tools..."
    
    # Python tools
    if command_exists pip3; then
        PYTHON_TOOLS=("debugpy" "pytest" "black" "isort")
        for tool in "${PYTHON_TOOLS[@]}"; do
            if pip3 install "$tool"; then
                print_success "Python tool installed: $tool"
            else
                print_warning "Error installing Python tool: $tool"
            fi
        done
    else
        print_warning "pip3 not found, skipping Python tools installation"
    fi
    
    # Node.js tools
    if command_exists npm; then
        if npm install -g prettier; then
            print_success "Prettier installed successfully"
        else
            print_warning "Error installing Prettier"
        fi
    else
        print_warning "npm not found, skipping Prettier installation"
    fi
    
    # Rust tools
    if command_exists rustup; then
        if rustup component add rustfmt; then
            print_success "rustfmt installed successfully"
        else
            print_warning "Error installing rustfmt"
        fi
    else
        print_warning "rustup not found, skipping rustfmt installation"
    fi
    
    print_success "Dependency installation completed"
}

# Function to install macOS dependencies (unchanged from original)
install_macos_deps() {
    print_status "Installing dependencies for macOS..."
    
    PACKAGES=("git" "node" "python" "rust" "fd" "ripgrep" "fzf" "ffmpeg" "make" "cmake" "ninja")

    if ! command_exists brew; then
        print_status "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    if ! brew install "${PACKAGES[@]}"; then
        print_error "Error installing packages with brew"
        return 1
    fi

    # Install additional tools
    print_status "Installing additional tools..."
    
    if command_exists pip3; then
        if pip极 install debugpy pytest black isort; then
            print_success "Python tools installed successfully"
        else
            print_warning "Error installing Python tools"
        fi
    else
        print_warning "pip3 not found, skipping Python tools installation"
    fi
    
    if command_exists npm; then
        if npm install -g prettier; then
            print_success "Prettier installed successfully"
        else
            print_warning "Error installing Prettier"
       极 fi
    else
        print_warning "npm not found, skipping Prettier installation"
    fi
    
    if command_exists rustup; then
        if rustup component add rustfmt; then
            print_success "rustfmt installed successfully"
        else
            print_warning "Error installing rustfmt"
        fi
    else
        print_warning "rustup not found, skipping rustfmt installation"
    fi
}

# Function to handle Windows dependencies
install_windows_deps() {
    print_warning "This script is not designed to install dependencies directly on Windows."
    print_status "Please run the 'install.ps1' script in a PowerShell terminal with administrator privileges."
    echo "To do this, open PowerShell and run:"
    echo "Set-ExecutionPolicy Unrestricted -Scope Process -Force; .\install.ps1"
    exit 1
}

# Function to check Neovim
check_neovim() {
    if ! command_exists nvim; then
        print_error "Neovim is not installed. Please install it first:"
        echo "  Ubuntu/Debian: sudo apt install neovim"
        echo "  Arch Linux: sudo pacman -S neovim"
        echo "  Fedora: sudo dnf install neovim"
        echo "  openSUSE: sudo zypper install neovim"
        echo "  Gentoo: sudo emerge --ask app-editors/neovim"
        echo "  macOS: brew install neovim"
        echo "  Windows: choco install neovim"
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
    mkdir -p ~/极ictures/wallpapers
    mkdir -p ~/Videos/neovim_recordings
    
    print_success "Directories created"
}

# Function to setup environment variables
setup_environment() {
    print_status "Setting up environment variables..."
    
    # Add to .bashrc or .zshrc
    SHELL_RC=""
    if [ -f ~/.bashrc ]; then
        SHELL_RC=~/.bashrc
    elif [ -f ~/.zshrc ]; then
        SHELL极=~/.zshrc
    fi
    
    if [ -n "$SHELL_RC" ]; then
        # Check if configuration already exists
        if ! grep -q "OPENAI_API_KEY" "$SHELL_R极"; then
            echo "" >> "$SHELL_RC"
            echo "# Neodots - Neovim Configuration" >> "$SHELL_RC"
            echo "export OPENAI_API_KEY=\"your-api-key-here\"" >> "$SHELL_RC"
            print_success "Environment variables added to $SHELL_RC"
        else
            print_warning "Environment variables already configured in $SHELL_RC"
        fi
    else
        print_warning "No .bashrc or .zshrc found. Configure manually:"
        echo "export OPENAI_API_KEY=\"your-api-key-here\""
    fi
}

# Function to sync configuration files
sync_config_files() {
    print_status "Syncing configuration files to ~/.config/nvim..."
    CONFIG_DIR="$HOME/.config/nvim"
    SOURCE_DIR="$(pwd)"

    # Create directory if it doesn't exist
    mkdir -p "$CONFIG_DIR"

    # Copy files, excluding version control and installer files
    if command_exists rsync; then
        print_status "Using rsync for efficient synchronization..."
        if rsync -av --delete "$SOURCE_DIR/" "$CONFIG_DIR/" --exclude ".git" --exclude ".github" --exclude "install.sh" --exclude "install.ps1" --exclude "README.md" --exclude "*.md" --exclude "*.log"; then
            print_success "Files synced successfully with rsync"
        else
            print_warning "Error using rsync, trying with cp..."
            sync_with_cp
        fi
    else
        print_warning "rsync not found. Using 'cp' to copy files..."
        sync_with_cp
    fi
}

# Helper function to copy files with cp
sync_with_cp() {
    local source_dir="$1"
    local config_dir="$2"
    
    # Use 'shopt -s dotglob' to include hidden files (dotfiles) in the copy
    shopt -s dotglob
    if cp -r "$source_dir"/* "$config_dir/"; then
        print_success "Files copied successfully with cp"
    else
        print_error "Error copying files with cp"
        shopt -u dotglob
        return 1
    fi
    shopt -u dotglob
    
    # Remove files that shouldn't be in the configuration
    local files_to_remove=("install.sh" "install.ps1" "README.md" ".git" ".github")
    for file in "${files_to_remove[@]}"; do
        if [ -e "$config_dir/$file" ]; then
            rm -rf "$config_dir/$file"
        fi
    done
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
    
    # Sync configuration files first
    sync_config_files

    # Detect operating system
    OS=$(detect_os)
    print_status "Detected operating system: $OS"
    
    # Check Neovim
    check_neovim
    
    # Install dependencies based on OS
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
            print_error "Unsupported operating system: $OS"
            exit 1
            ;;
    esac
    
    # Create directories
    create_directories
    
    # Setup environment variables
    setup_environment
    
    print_success "Installation completed!"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "1. Configure your OpenAI API key in your shell file (.bashrc, .zshrc, etc.):"
    echo "   export OPENAI_API_KEY=\"your-api-key-here\""
    echo ""
    echo "2. Start Neovim to automatically install plugins:"
    echo "   nvim"
    echo ""
    echo "3. Check README.md for more usage information"
    echo ""
    echo -e "${GREEN}Happy coding with Neodots! 🚀${NC}"
}

# Execute main function
main "$@"
