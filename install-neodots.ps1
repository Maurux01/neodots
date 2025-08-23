# Neodots Installer for Windows
# This script will install all required dependencies and set up Neovim configuration

# We'll install everything in user space

# Configuration
$NEOVIM_DIR = "$env:LOCALAPPDATA\nvim"
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

# Copy configuration files to Neovim directory
function Copy-NeovimConfig {
    Write-Info "Setting up Neovim configuration..."
    
    # Create Neovim config directory if it doesn't exist
    if (-not (Test-Path $NEOVIM_DIR)) {
        New-Item -ItemType Directory -Path $NEOVIM_DIR -Force | Out-Null
    }
    
    # Files and directories to exclude from copying
    $exclude = @('install.ps1', 'install-fixed.ps1', 'install-neodots.ps1', 'README.md', '.git', '.github', 'setup.ps1')
    
    # Copy all files except excluded ones
    Get-ChildItem -Path $REPO_DIR -Exclude $exclude | ForEach-Object {
        $dest = Join-Path $NEOVIM_DIR $_.Name
        if ($_.PSIsContainer) {
            if (-not (Test-Path $dest)) {
                Copy-Item -Path $_.FullName -Destination $dest -Recurse -Force
            }
        } else {
            Copy-Item -Path $_.FullName -Destination $dest -Force
        }
    }
    
    Write-Success "Configuration files copied to $NEOVIM_DIR"
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
    
    # Show completion message
    Write-Host "`n=== Installation Complete ===" -ForegroundColor Green
    Write-Host "Neodots has been installed successfully!"
    Write-Host "`nNext steps:"
    Write-Host "1. Start Neovim to install plugins:"
    Write-Host "   nvim" -ForegroundColor Cyan
    Write-Host "   (First start may take a few minutes to install plugins)`n"
    Write-Host "2. Set your OpenAI API key (optional):"
    Write-Host "   [Environment]::SetEnvironmentVariable('OPENAI_API_KEY', 'your-api-key-here', 'User')" -ForegroundColor Cyan
    
    # Ask to open Neovim
    $choice = Read-Host "`nDo you want to open Neovim now? (y/n)"
    if ($choice -eq 'y') {
        nvim
    }
}

# Run the installation
Install-Neodots
