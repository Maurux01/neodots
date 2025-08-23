# Neodots - Neovim Configuration

A modern and complete Neovim configuration with all the features you need to program efficiently.

## 🚀 Features

### ✨ Main Features

- **🎨 Custom Dashboard**: Home screen with quick access
- **📸 Screenshots**: Take screenshots directly from the editor
- **⚠️ Visual Errors and Warnings**: Display errors clearly and attractively
- **💡 Intelligent Autocompletion**: Real-time suggestions for code and commands
- **🎭 Adjustable Transparency**: Control editor transparency
- **🖼️ Customizable Wallpaper**: Change desktop background from the editor
- **🎬 Video Recording**: Record everything you write and execute
- **🖼️ Image Visualization**: Support for viewing images and SVG in the editor
- **🐙 Git/Docker Integration**: LazyGit and LazyDocker integrated
- **🐛 Advanced Debugging**: Integrated debugger for multiple languages
- **🧪 Testing Framework**: Test execution and management
- **📊 Code Analysis**: Advanced diagnostic tools
- **🎯 Automatic Formatting**: Code formatting on save
- **📚 Project Management**: Project detection and navigation
- **📝 Notes and Documentation**: Integrated note system
- **🎨 Improved UI**: Modern and responsive interface

### 🔧 Integrated Tools

- **LSP**: Complete support for multiple languages
- **Telescope**: Advanced search and navigation
- **Treesitter**: Enhanced syntax highlighting
- **LazyGit**: Visual Git management
- **LazyDocker**: Container management
- **ChatGPT**: AI programming assistant
- **nvim-dap**: Advanced debugging
- **neotest**: Testing framework
- **Trouble**: Problem analysis
- **Conform**: Automatic formatting
- **Neorg/Vimwiki**: Note system
- **Noice**: Improved UI
- **Aerial**: Code outline

## 📋 Prerequisites

### Required Software

1. **Neovim** (version 0.8.0 or higher)
2. **Git**
3. **Node.js** (for LSP)
4. **Python** (for some LSP)
5. **Rust** (optional, for rust-analyzer)

### Optional Tools

- **fd** (for fast file search)
- **ripgrep** (for file search)
- **fzf** (for fuzzy finding)
- **Kitty** (for image visualization)
- **ffmpeg** (for video recording)
- **feh** (Linux, for wallpapers)

## 🛠️ Installation

### 1. Clone the Repository

First, clone the Neodots repository to any location on your local machine:

```bash
git clone https://github.com/your-username/neodots.git
cd neodots
```

### 2. Run the Automatic Installer

The installer will automatically perform the following actions:

- **Copy Configuration**: The configuration files will be copied to the default Neovim directory for your operating system:
  - **Linux/macOS**: `~/.config/nvim`
  - **Windows**: `%LOCALAPPDATA%\nvim`
- **Install Dependencies**: All required software and tools will be installed.

Run the appropriate installer for your system:

**Linux/macOS:**
```bash
# Make script executable
chmod +x install.sh

# Run installer
./install.sh
```

**Windows (PowerShell):**
```powershell
# Run installer
Set-ExecutionPolicy Bypass -Scope Process -Force; .\install.ps1
```

#### 📦 **Manual Installation**

#### Windows (PowerShell)
```powershell
# Install Chocolatey if you don't have it
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install tools
choco install git nodejs python rust fd ripgrep fzf
```

#### macOS
```bash
# Install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install tools
brew install git node python rust fd ripgrep fzf ffmpeg
```

#### Linux (Multiple Distributions)

**Ubuntu/Debian:**
```bash
# Install tools
sudo apt update
sudo apt install git nodejs npm python3 python3-pip rustc cargo fd-find ripgrep fzf ffmpeg feh

# Install fd as fd
sudo ln -s /usr/bin/fd-find /usr/bin/fd
```

**Arch Linux:**
```bash
# Install tools
sudo pacman -Syu
sudo pacman -S git nodejs npm python python-pip rust cargo fd ripgrep fzf ffmpeg feh
```

**Fedora:**
```bash
# Install tools
sudo dnf install git nodejs npm python3 python3-pip rust cargo fd-find ripgrep fzf ffmpeg feh
```

**openSUSE:**
```bash
# Install tools
sudo zypper install git nodejs npm python3 python3-pip rust cargo fd ripgrep fzf ffmpeg feh
```

**Gentoo:**
```bash
# Install tools
sudo emerge --ask dev-vcs/git net-libs/nodejs dev-lang/python dev-lang/rust app-misc/fd sys-apps/ripgrep app-misc/fzf media-video/ffmpeg media-gfx/feh
```

### 3. Configure environment variables

```bash
# Configure OpenAI API key for ChatGPT
export OPENAI_API_KEY="your-api-key-here"
```

### 4. Start Neovim

```bash
nvim
```

The first time you start Neovim, all necessary plugins and LSP will be installed automatically.

## ⌨️ Keybindings

### General Navigation
- `<Space>` - Leader key
- `<C-h/j/k/l>` - Navigate between windows
- `<leader>ff` - Find files
- `<leader>fg` - Search in files
- `<leader>fb` - List buffers
- `<leader>e` - File explorer

### LSP and Autocompletion
- `gd` - Go to definition
- `gr` - View references
- `K` - View information (hover)
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<C-Space>` - Activate autocompletion
- `<Tab>` - Next suggestion
- `<S-Tab>` - Previous suggestion

### AI and Assistance
- `<leader>ai` - Open AI chat
- `<leader>ae` - Edit with AI instructions

### Screenshots and Recording
- `<leader>ss` - Take screenshot
- `<leader>sr` - Start/Stop recording
- `<leader>srs` - Start recording
- `<leader>srt` - Stop recording

### Transparency and Wallpaper
- `<leader>t+` - Increase transparency
- `<leader>t-` - Decrease transparency
- `<leader>tr` - Reset transparency
- `<leader>tw` - Toggle wallpaper
- `<leader>ws` - Select wallpaper
- `<leader>wr` - Random wallpaper

### 🎨 Quick Theme Switching
- `<leader>tn` - Next dark theme
- `<leader>tp` - Previous theme
- `<leader>ts` - Select theme with Telescope
- `<leader>tc` - Show current theme

### Git and Docker
- `<leader>gg` - Open LazyGit
- `<leader>gd` - Open LazyDocker

### Buffer Management
- `<leader>bd` - Close buffer
- `<leader>bn` - Next buffer
- `<leader>bp` - Previous buffer

### Enhanced Comments
- `<leader>cc` - Comment/uncomment line
- `<leader>cb` - Comment/uncomment block
- `<leader>c` - Comment selection (visual mode)
- `<leader>b` - Comment block (visual mode)

### Brackets and Syntax
- **Rainbow brackets**: Automatic colors for parentheses/brackets
- **Auto-tags**: Automatic closing of HTML/JSX/XML tags
- **Color highlighting**: Color code visualization

## 🎨 Customization

### 🎨 Available Dark Themes

Your configuration includes **15 preconfigured dark themes** that you can change quickly:

#### Included Themes:
1. **Catppuccin** - Main theme (default)
2. **Tokyo Night** - Elegant and modern
3. **One Dark** - Atom inspired
4. **Gruvbox** - Classic and warm
5. **Nord** - Cold and minimalist
6. **Dracula** - Vibrant and colorful
7. **Nightfox** - Soft and elegant
8. **Carbonfox** - Dark and sophisticated
9. **Kanagawa** - Japanese art inspired
10. **Rose Pine** - Romantic and soft
11. **Everforest** - Natural and relaxing
12. **Sonokai** - Vibrant and modern
13. **Material** - Material Design inspired
14. **Monokai** - Classic and colorful
15. **Palenight** - Soft and elegant

#### Quick Theme Switching:
- **`<leader>tn`** - Change to next theme
- **`<leader>tp`** - Change to previous theme
- **`<leader>ts`** - Select theme with Telescope
- **`<leader>tc`** - View current theme

#### Features:
- **Transparency enabled** in all themes
- **Instant change** without restarting Neovim
- **Visual notifications** when changing theme
- **Dashboard integration** for quick switching

### Transparency Configuration

Adjust default transparency in `lua/transparency.lua`:

```lua
local current_transparency = 0.8  -- Change this value
```

### Wallpaper Directories

Wallpapers are saved in `~/Pictures/wallpapers/`. You can change this by editing `lua/wallpaper.lua`:

```lua
local wallpaper_dir = vim.fn.expand("~/your/custom/path")
```

## 🔧 LSP Configuration

The following LSP are installed automatically:

- **Lua**: lua_ls
- **JavaScript/TypeScript**: tsserver
- **Python**: pyright
- **Rust**: rust_analyzer
- **Go**: gopls
- **C/C++**: clangd
- **JSON**: jsonls
- **YAML**: yamlls
- **HTML**: html
- **CSS**: cssls
- **Tailwind**: tailwindcss

## 🐛 Advanced Debugging

### nvim-dap
Complete debugging configuration for multiple languages:

- **Python**: debugpy
- **JavaScript/TypeScript**: node-debug2-adapter
- **C/C++**: cppdbg
- **Go**: delve
- **Lua**: nlua

### Debugging Commands
- `<leader>db` - Toggle breakpoint
- `<leader>dc` - Continue
- `<leader>di` - Step into
- `<leader>do` - Step over
- `<leader>dO` - Step out
- `<leader>dr` - Toggle REPL
- `<leader>dl` - Run last
- `<leader>du` - Toggle DAP UI

## 🧪 Testing Framework

### neotest
Testing framework for multiple languages:

- **Python**: pytest
- **JavaScript**: jest
- **Go**: go test
- **Rust**: cargo test

### Testing Commands
- `<leader>tt` - Run test
- `<leader>tf` - Run test file
- `<leader>td` - Debug test
- `<leader>ts` - Toggle test summary
- `<leader>to` - Open test output

## 📊 Code Analysis

### Trouble
Advanced tool for problem analysis:

- `<leader>xx` - Toggle trouble
- `<leader>xw` - Workspace diagnostics
- `<leader>xd` - Document diagnostics
- `<leader>xl` - Location list
- `<leader>xq` - Quickfix list

## 🎯 Automatic Formatting

### Conform
Automatic formatting on save for:

- **Lua**: stylua
- **Python**: isort + black
- **JavaScript/TypeScript**: prettier
- **JSON/YAML**: prettier
- **HTML/CSS**: prettier
- **Rust**: rustfmt
- **Go**: gofmt
- **C/C++**: clang_format

### Commands
- `<leader>cf` - Format code manually

## 📚 Project Management

### project.nvim
Automatic project detection:

- `<leader>pp` - Project picker
- Detection by patterns: .git, package.json, Makefile, etc.
- Quick navigation between projects

## 📝 Note System

### Neorg
Advanced note system with:

- Organized workspaces
- Enhanced conceal
- Directory management

### Vimwiki
Alternative note system:

- `<leader>ww` - Vimwiki index
- `<leader>wt` - Vimwiki tab index
- `<leader>ws` - Vimwiki UI select

### Markdown Preview
- `<leader>mp` - Toggle markdown preview

## 🎨 Improved UI

### Noice
Modern interface with:

- Better LSP presentation
- Enhanced command palette
- Elegant notifications

### Scrollbar
Intelligent scrollbar with:

- Error markers
- Search indicators
- Fold management

### Aerial
Code outline:

- `<leader>aa` - Toggle aerial
- `<leader>an` - Next aerial
- `<leader>ap` - Previous aerial

## 💾 Session Management

### Auto-session
Automatic session management:

- `<leader>ss` - Save session
- `<leader>sl` - Load session
- `<leader>sd` - Delete session
- Auto-save on exit
- Automatic restoration

## 🖥️ Enhanced Terminal

### Toggleterm
Floating terminal with:

- `<C-\>` - Toggle terminal
- Navigation with Ctrl+h/j/k/l
- Floating terminal
- Multiple terminals

## 📁 File Explorer

### Nvim-tree
Alternative file explorer:

- `<leader>e` - Toggle file explorer
- `<leader>ef` - Focus file explorer
- Adaptive view
- Smart filters

## ⚡ Advanced Utilities

### Emmet
Fast HTML/CSS expansion:

- `<C-y>,` - Expand emmet
- Custom snippets
- Support for multiple frameworks

### Legendary
Advanced command palette:

- `<leader>:` - Legendary command palette
- Automatic command registration
- Intelligent search

### Text Objects
Advanced text objects:

- `af/if` - Function
- `ac/ic` - Class
- `aa/ia` - Parameter
- `ab/ib` - Block
- `al/il` - Loop
- `as/is` - Statement

### Advanced Movement
- `]m/[m` - Next/previous function
- `]c/[c` - Next/previous class
- `]a/[a` - Next/previous parameter
- `]b/[b` - Next/previous block

## 🌈 Syntax and Bracket Improvements

### Rainbow Delimiters
Parentheses, brackets, and braces are displayed in different colors according to their nesting level:
- **Red**: First level
- **Yellow**: Second level  
- **Blue**: Third level
- **Orange**: Fourth level
- **Green**: Fifth level
- **Purple**: Sixth level
- **Cyan**: Seventh level

### Enhanced Auto-tags
- **HTML/JSX/XML**: Automatic tag closing
- **Auto-closed tags**: `img`, `br`, `hr`, `input`, etc.
- **Support for**: React, Vue, Svelte, Astro

### Color Highlighting
- **CSS/SCSS**: Color code visualization
- **HTML**: Colors in style attributes
- **Tailwind**: Support for Tailwind CSS classes
- **Named colors**: Red, blue, green, etc.

### Intelligent Comments
- **Context-aware**: Automatically detects file type
- **Enhanced formatting**: Consistent spacing and formatting
- **Multiline support**: Block comments for all languages
- **JavaScript/TypeScript**: tsserver
- **Python**: pyright
- **Rust**: rust_analyzer
- **Go**: gopls
- **C/C++**: clangd
- **JSON**: jsonls
- **YAML**: yamlls
- **HTML**: html
- **CSS**: cssls
- **Tailwind**: tailwindcss

### Install additional LSP

To install additional LSP, edit `lua/lsp.lua` and add the LSP to the `ensure_installed` list.

## 🖼️ Image Visualization

### Kitty Configuration

To view images in the terminal, make sure you use Kitty and have the correct configuration:

```bash
# In your kitty.conf
term xterm-kitty
```

### Supported Formats

- PNG, JPG, JPEG, GIF, WebP
- SVG (with Kitty support)
- Images in Markdown

## 🎬 Video Recording

### Tools by Operating System

- **Windows**: OBS Studio
- **macOS**: QuickTime Player
- **Linux**: ffmpeg

### Configuration

Videos are saved in `~/Videos/neovim_recordings/`. You can change this by editing `lua/recording.lua`.

## 🤖 ChatGPT Configuration

### API Key

Configure your OpenAI API key:

```bash
export OPENAI_API_KEY="your-api-key-here"
```

### Available Models

- GPT-3.5-turbo (default)
- GPT-4 (change in configuration)

### Customization

Edit the ChatGPT configuration in `lua/plugins.lua` to customize behavior.

## 🐛 Troubleshooting

### Plugins don't install

```bash
# Clear Lazy cache
rm -rf ~/.local/share/nvim/lazy
nvim --headless -c "Lazy! sync" -c "qa"
```

### LSP doesn't work

```bash
# Check Mason installation
:Mason
# Install LSP manually if necessary
```

### Transparency doesn't work

Make sure your terminal supports transparency:
- **Windows**: Windows Terminal
- **macOS**: iTerm2 or Terminal.app
- **Linux**: Any modern terminal

### Images don't display

1. Verify you use Kitty
2. Make sure `image.nvim` is configured correctly
3. Verify images are in supported formats

## 📝 Contributing

1. Fork the repository
2. Create a branch for your feature (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Create a Pull Request

## 📄 License

This project is under the MIT License. See the `LICENSE` file for more details.

## 🙏 Acknowledgments

- [Lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [Catppuccin](https://github.com/catppuccin/nvim) - Color theme
- [ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim) - AI integration
- [Telescope](https://github.com/nvim-telescope/telescope.nvim) - Search and navigation
- [LazyGit](https://github.com/kdheepak/lazygit.nvim) - Visual Git
- [LazyDocker](https://github.com/lazytanuki/nvim-docker) - Visual Docker

---

**Enjoy programming with Neodots! 🚀**