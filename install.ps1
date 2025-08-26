# Neodots Installer for Windows
# This script will install all required dependencies and set up Neovim configuration

# We'll install everything in user space

# Configuration
$NEOVIM_CONFIG_DIR = "$env:LOCALAPPDATA\nvim"
$NEOVIM_DATA_DIR = "$env:LOCALAPPDATA\nvim-data"
$REPO_DIR = (Get-Item -Path ".").FullName

# Colors for output
$colors = @{
    info = 'Cyan'
    success = 'Green'
    warning = 'Yellow'
    error = 'Red'
}

# Helper functions
function Write-Info($message) { Write-Host "[i] $message" -ForegroundColor $colors.info }
function Write-Success($message) { Write-Host "[+] $message" -ForegroundColor Green }
function Write-Warning($message) { Write-Host "[!] $message" -ForegroundColor $colors.warning }
function Write-Error($message) { Write-Host "[✗] $message" -ForegroundColor $colors.error; exit 1 }

# Check if Node.js is installed
function Test-NodeJsInstalled {
    return (Get-Command node -ErrorAction SilentlyContinue) -or (Get-Command nodejs -ErrorAction SilentlyContinue)
}

# Install Node.js with multiple fallback methods
function Install-NodeJs {
    Write-Info "Installing Node.js..."
    
    # Method 1: Try Chocolatey first
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        try {
            choco install nodejs -y --no-progress --scope=user
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Node.js installed via Chocolatey"
                return $true
            }
        } catch {
            Write-Warning "Chocolatey installation failed"
        }
    }
    
    # Method 2: Try winget
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        try {
            winget install -e --id OpenJS.NodeJS --silent
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Node.js installed via winget"
                return $true
            }
        } catch {
            Write-Warning "Winget installation failed"
        }
    }
    
    # Method 3: Manual download suggestion
    Write-Warning "Automatic Node.js installation failed"
    Write-Host "  Please install Node.js manually from: https://nodejs.org/" -ForegroundColor Yellow
    Write-Host "  After installation, restart PowerShell and run this script again" -ForegroundColor Yellow
    
    $choice = Read-Host "Do you want to continue without Node.js? (y/n)"
    if ($choice -ne 'y') {
        Write-Error "Node.js installation required for full functionality"
    }
    
    return $false
}

# Install a package using available package managers
function Install-Package($package) {
    # Special handling for nodejs
    if ($package -eq "nodejs") {
        if (Test-NodeJsInstalled) {
            Write-Success "Node.js is already installed"
            return $true
        }
        return Install-NodeJs
    }
    
    if (Get-Command $package -ErrorAction SilentlyContinue) {
        Write-Success "$package is already installed"
        return $true
    }
    
    Write-Info "Installing $package..."
    
    # Try winget first (built into Windows 10/11)
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        try {
            # Different package names for winget
            $wingetPackage = $package
            if ($package -eq "python") {
                $wingetPackage = "Python.Python.3"
            } elseif ($package -eq "git") {
                $wingetPackage = "Git.Git"
            }
            
            winget install --id $wingetPackage --silent --accept-package-agreements --accept-source-agreements
            if ($LASTEXITCODE -eq 0) {
                Write-Success "$package installed successfully via winget"
                return $true
            }
        } catch {
            Write-Warning "Failed to install $package via winget"
        }
    }
    
    # Try Chocolatey if available
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        try {
            choco install $package -y --no-progress --scope=user
            if ($LASTEXITCODE -eq 0) {
                Write-Success "$package installed successfully via Chocolatey"
                return $true
            } else {
                Write-Warning "Failed to install $package via Chocolatey"
            }
        } catch {
            Write-Warning "Error installing $package via Chocolatey: $_"
        }
    }
    
    Write-Warning "Could not install $package automatically"
    Write-Host "  Please install $package manually or try running the script again" -ForegroundColor Yellow
    return $false
}

# Copy configuration files to Neovim directories
function Copy-NeovimConfig {
    Write-Info "Setting up Neovim configuration..."
    
    # Create Neovim config and data directories if they don't exist
    $directories = @(
        $NEOVIM_CONFIG_DIR,
        "$NEOVIM_CONFIG_DIR\lua",
        "$NEOVIM_CONFIG_DIR\lua\config",
        "$NEOVIM_CONFIG_DIR\lua\plugins",
        $NEOVIM_DATA_DIR
    )

    # Create all necessary directories
    foreach ($dir in $directories) {
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
            Write-Success "Created directory: $dir"
        }
    }
    
    # Copy all Lua files to their respective directories
    Write-Info "Copying configuration files to $NEOVIM_CONFIG_DIR"
    
    # Copy root level .lua files
    Get-ChildItem -Path $REPO_DIR -Filter "*.lua" | ForEach-Object {
        $dest = Join-Path $NEOVIM_CONFIG_DIR $_.Name
        Copy-Item -Path $_.FullName -Destination $dest -Force
        Write-Info "Copied: $($_.Name) -> $dest"
    }
    
    # Copy lua directory contents
    $luaSrc = Join-Path $REPO_DIR "lua"
    if (Test-Path $luaSrc) {
        $luaDst = Join-Path $NEOVIM_CONFIG_DIR "lua"
        Copy-Item -Path "$luaSrc\*" -Destination $luaDst -Recurse -Force
        Write-Info "Copied lua directory contents to $luaDst"
    }
    
    Write-Success "Neovim configuration has been set up successfully!"
    Write-Success "Config directory: $NEOVIM_CONFIG_DIR"
    Write-Success "Data directory: $NEOVIM_DATA_DIR"
}

# Main installation process
function Install-Neodots {
    # Show banner
    Write-Host "`n=== Neodots Installation ===" -ForegroundColor Magenta
    Write-Host "A modern Neovim configuration for Windows`n"
    
    # Install in user space
    Write-Info "Installing in user space..."
    
    # 1. Install required packages
    $packages = @(
        "git",       # Version control
        "nodejs",    # For LSP and other tools (handled specially)
        "python"     # For Python support
    )
    
    foreach ($pkg in $packages) {
        Install-Package $pkg | Out-Null
    }
    
    # 2. Copy configuration files
    Copy-NeovimConfig

    # 3. Install lazy.nvim and plugins
    Write-Info "Installing Neovim plugins..."
    
    # First, ensure lazy.nvim is installed
    $lazyPath = "$env:LOCALAPPDATA\nvim-data\lazy\lazy.nvim"
    if (-not (Test-Path $lazyPath)) {
        try {
            Write-Info "Installing lazy.nvim..."
            $lazyUrl = "https://github.com/folke/lazy.nvim.git"
            $lazyDir = "$env:LOCALAPPDATA\nvim-data\lazy"
            
            if (-not (Test-Path $lazyDir)) {
                New-Item -ItemType Directory -Path $lazyDir -Force | Out-Null
            }
            
            git clone --filter=blob:none $lazyUrl $lazyPath
            if ($LASTEXITCODE -eq 0) {
                Write-Success "lazy.nvim installed successfully"
            } else {
                throw "Failed to clone lazy.nvim"
            }
        } catch {
            Write-Warning "Failed to install lazy.nvim: $_"
            Write-Warning "Please install it manually by running:"
            Write-Host "  git clone --filter=blob:none https://github.com/folke/lazy.nvim.git $env:LOCALAPPDATA\nvim-data\lazy\lazy.nvim" -ForegroundColor Yellow
        }
    }
    
    # Now install plugins using lazy.nvim
    if (Test-Path $lazyPath) {
        Write-Info "Installing plugins with lazy.nvim..."
        try {
            # Ensure Mason binaries are in PATH
            $env:PATH = "$env:LOCALAPPDATA\nvim-data\mason\bin;" + $env:PATH
            
            # First run to install plugins
            Write-Info "Running initial plugin installation..."
            nvim --headless -c 'autocmd User LazyInstall quitall' -c 'Lazy install' 2>&1 | Out-Null
            
            # Second run to ensure everything is properly set up
            Write-Info "Verifying plugin installation..."
            nvim --headless -c 'autocmd User LazyInstall quitall' -c 'Lazy install' 2>&1 | Out-Null
            
            Write-Success "Plugins installed successfully"
        } catch {
            Write-Warning "Failed to install plugins automatically: $_"
            Write-Warning "You can try running :Lazy install after opening Neovim"
        }
    } else {
        Write-Warning "lazy.nvim not found. Plugin installation skipped."
    }

    # 4. Final message
    Write-Host "`nInstallation complete! You can now open Neovim with the command: nvim" -ForegroundColor Green
    Write-Host "If you encounter issues, check the README.md file for troubleshooting tips" -ForegroundColor Yellow
}

# Run the installation
Install-Neodots
