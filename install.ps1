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

# Install Chocolatey if not installed
function Install-Chocolatey {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Info "Installing Chocolatey..."
        try {
            Set-ExecutionPolicy Bypass -Scope Process -Force
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
            Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
            $env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
            Write-Success "Chocolatey installed successfully"
        } catch {
            Write-Error "Failed to install Chocolatey: $_"
        }
    } else {
        Write-Success "Chocolatey is already installed"
    }
}

# Install a package using Chocolatey
function Install-Package($package) {
    if (-not (Get-Command $package -ErrorAction SilentlyContinue)) {
        Write-Info "Installing $package..."
        # Install with user scope
        choco install $package -y --no-progress --force --allow-downgrade --scope=user | Out-Null
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Failed to install $package"
            return $false
        }
        Write-Success "$package installed successfully"
        return $true
    }
    Write-Success "$package is already installed"
    return $true
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
        $NEOVIM_DATA_DIR,
        "$NEOVIM_DATA_DIR\site",
        "$NEOVIM_DATA_DIR\site\pack",
        "$NEOVIM_DATA_DIR\site-data",
        "$NEOVIM_DATA_DIR\site-data\pack"
    )

    # Create all necessary directories
    foreach ($dir in $directories) {
        if (-not (Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
            Write-Success "Created directory: $dir"
        }
    }
    
    # Files and directories to exclude from copying
    $exclude = @(
        '.git',
        '.github',
        'README.md',
        'install.ps1',
        'install-fixed.ps1',
        'install-neodots.ps1',
        'install.sh',
        '*.md',
        '*.log'
    )
    
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
    
    # Ensure init.lua exists
    $initLua = Join-Path $NEOVIM_CONFIG_DIR "init.lua"
    if (-not (Test-Path $initLua)) {
        Set-Content -Path $initLua -Value "-- Neovim configuration entry point"
        Write-Warning "Created empty init.lua file. You may need to configure it manually."
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
    
    # 1. Try to use existing Chocolatey or prompt user to install it
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Warning "Chocolatey is not installed. Some features might not work."
        Write-Host "  You can install it manually from: https://chocolatey.org/install" -ForegroundColor Yellow
        $installChoco = Read-Host "Do you want to try installing Chocolatey? (y/n)"
        if ($installChoco -eq 'y') {
            Write-Info "Installing Chocolatey for current user..."
            try {
                Set-ExecutionPolicy Bypass -Scope Process -Force
                [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
                iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
                $env:Path = [System.Environment]::GetEnvironmentVariable('Path','User') + ';' + [System.Environment]::GetEnvironmentVariable('Path','Machine')
                Write-Success "Chocolatey installed successfully"
            } catch {
                Write-Warning "Failed to install Chocolatey. Some features might not work."
            }
        }
    }
    
    # 2. Install required packages (except Neovim)
    $packages = @(
        "git",       # Version control
        "nodejs",    # For LSP and other tools
        "python"     # For Python support
    )
    
    foreach ($pkg in $packages) {
        Install-Package $pkg | Out-Null
    }
    
    # 3. Copy configuration files
    Copy-NeovimConfig

    # 4. Install Neovim plugins using lazy.nvim
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

    # 5. Ask to open Neovim
    $choice = Read-Host "`nDo you want to open Neovim now? (y/n)"
    try {
        if ($choice -eq 'y') {
            Write-Info "Opening Neovim..."
            Start-Process -FilePath "nvim" -NoNewWindow -ErrorAction Stop
        } else {
            Write-Host "`nInstallation complete! You can now open Neovim with the command: nvim" -ForegroundColor Green
        }
    } catch {
        Write-Warning "Failed to open Neovim: $_"
        Write-Host "You can start Neovim manually by running: nvim" -ForegroundColor Green
    }
}

# Run the installation
Install-Neodots
