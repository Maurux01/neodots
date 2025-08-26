# Neodots - Modern Neovim Configuration

A minimal, beautiful, and powerful Neovim configuration featuring VS Code-like functionality with smooth animations and modern UI enhancements. Perfect for developers who want a productive and visually appealing coding environment.

## ✨ Features

- **🎨 Beautiful UI**: Multiple dark themes (Tokyo Night, Catppuccin, Kanagawa, Rose Pine) with transparent backgrounds
- **⚡ Fast Performance**: Optimized startup time with lazy loading and disabled unused plugins
- **🔍 VS Code-like Experience**: Familiar keybindings, file explorer, and workflow patterns
- **🎭 Smooth Animations**: Animated notifications, scrolling, and UI transitions
- **🧩 Modern Plugin Ecosystem**: Latest Neovim plugins for maximum productivity
- **🚀 Easy Setup**: Automatic installation scripts for all major platforms
- **📦 Package Management**: Built-in support for Mason (LSP, DAP, linters, formatters)
- **🖱️ Multi-cursor Support**: VS Code-like multi-cursor editing with vim-visual-multi
- **🤖 AI Code Completion**: Inline code suggestions with Codeium (free GitHub Copilot alternative)
- **💻 Enhanced Terminal**: Floating, horizontal, and vertical terminal with ToggleTerm
- **🔄 Tmux Integration**: Seamless navigation between Neovim windows and tmux panes

## 🚀 Quick Installation

### Prerequisites
- **Neovim 0.9.0 or higher**
- **Git**
- **Nerd Font** (recommended: FiraCode Nerd Font, JetBrains Mono Nerd Font)
- **Node.js** (for LSP servers and tools)
- **Python** (for debugging and additional tools)
- **Build tools**: `make`, `npm` (for building some plugins)

### Step 1: Clean Previous Installation (Recommended)
```bash
# Linux / MacOS (unix)
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim

# Flatpak (linux)
rm -rf ~/.var/app/io.neovim.nvim/config/nvim
rm -rf ~/.var/app/io.neovim.nvim/data/nvim
rm -rf ~/.var/app/io.neovim.nvim/.local/state/nvim

# Windows CMD
rd -r ~\AppData\Local\nvim
rd -r ~\AppData\Local\nvim-data

# Windows PowerShell
rm -Force ~\AppData\Local\nvim
rm -Force ~\AppData\Local\nvim-data
```

### Step 2: Clone the Repository
```bash
git clone https://github.com/maurux01/neodots ~/.config/nvim
cd ~/.config/nvim
```

### Step 3: Run the Automatic Installer

#### 🐧 Linux/macOS:
```bash
# Use the installer script
./install-fixed.sh
```

#### 🪟 Windows (PowerShell):
```powershell
# Enable script execution and run the installer
Set-ExecutionPolicy Bypass -Scope Process -Force
.\install.ps1
```

### Step 4: Start Neovim
```bash
nvim
```

The first startup will automatically install all plugins via Lazy.nvim. This may take a few minutes.

## 📋 System Requirements

### Minimum Requirements
- **Neovim**: 0.9.0 or higher
- **RAM**: 4GB+ recommended
- **Storage**: 2GB+ free space for plugins and tools

### Recommended Specifications
- **Neovim**: Latest stable version
- **RAM**: 8GB+ for optimal performance
- **CPU**: Multi-core processor
- **GPU**: Hardware acceleration support for smooth animations

## ⌨️ Essential Keybindings

### File & Navigation
| Keybinding | Description |
|------------|-------------|
| `<leader>e` | Toggle file explorer (NvimTree) |
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>fb` | Find buffers (Telescope) |
| `Ctrl+P` | Quick file search (VS Code style) |
| `Ctrl+b` | Toggle file explorer |
| `Ctrl+,` | Switch buffers |

### Window Management
| Keybinding | Description |
|------------|-------------|
| `Ctrl+h/j/k/l` | Navigate between windows/tmux panes |
| `Ctrl+\` | Navigate to previous window/pane |
| `<leader>wv` | Split window vertically |
| `<leader>ws` | Split window horizontally |
| `<leader>wc` | Close current window |

### LSP & Code Intelligence
| Keybinding | Description |
|------------|-------------|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format code |
| `<leader>d` | Toggle debugger UI |

### Multi-cursor Editing
| Keybinding | Description |
|------------|-------------|
| `Ctrl+d` | Select word under cursor (add cursor) |
| `Ctrl+Alt+d` | Select all occurrences of word |
| `Ctrl+Alt+j/k` | Add cursor up/down |

### AI Code Completion (Codeium)
| Keybinding | Description |
|------------|-------------|
| `Ctrl+g` | Accept AI suggestion |
| `Ctrl+;` | Next suggestion |
| `Ctrl+,` | Previous suggestion |
| `Ctrl+x` | Clear suggestions |

### Enhanced Terminal
| Keybinding | Description |
|------------|-------------|
| `Ctrl+\` | Toggle floating terminal |
| `<leader>tt` | Toggle terminal |
| `<leader>tf` | Floating terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |
| `<leader>tg` | LazyGit terminal |
| `<leader>tn` | Node.js REPL |
| `<leader>tp` | Python REPL |
| `<leader>ts` | PowerShell terminal |

### Git Integration
| Keybinding | Description |
|------------|-------------|
| `<leader>gg` | Open LazyGit |
| `<leader>gb` | Toggle git blame |
| `<leader>gd` | View git diff |
| `<leader>gs` | Stage hunk |
| `<leader>gu` | Undo stage hunk |

### Debugging (DAP)
| Keybinding | Description |
|------------|-------------|
| `<F5>` | Start/continue debugging |
| `<F9>` | Toggle breakpoint |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dr` | Open debugger UI |

## 🎯 Plugin Ecosystem

### Core UI & Appearance
- **tokyonight.nvim** - Beautiful color scheme with multiple variants
- **lualine.nvim** - Customizable status line
- **nvim-tree.lua** - File explorer with icons
- **bufferline.nvim** - Tab-like buffer interface
- **indent-blankline.nvim** - Indentation guides

### Language Support
- **nvim-lspconfig** - Language Server Protocol configuration
- **mason.nvim** - Package manager for LSP servers, DAP, linters, formatters
- **nvim-treesitter** - Better syntax highlighting and code parsing
- **nvim-cmp** - Auto-completion engine
- **LuaSnip** - Snippet engine

### Productivity Tools
- **telescope.nvim** - Fuzzy finder for files, grep, and more
- **gitsigns.nvim** - Git integration in the gutter
- **Comment.nvim** - Smart commenting
- **nvim-autopairs** - Auto-pairing of brackets and quotes
- **which-key.nvim** - Keybinding hints
- **vim-tmux-navigator** - Seamless tmux integration

### Debugging & Testing
- **nvim-dap** - Debug Adapter Protocol
- **nvim-dap-ui** - Debugger UI interface
- **nvim-dap-virtual-text** - Virtual text for debugging

### Animations & Effects
- **nvim-notify** - Animated notifications

- **mini.animate** - Minimal animations for UI elements

## 🎨 Customization Guide

### Configuration Structure
```
~/.config/nvim/
├── init.lua          # Main entry point
├── lua/
│   ├── config/
│   │   ├── options.lua    # Neovim options
│   │   ├── keymaps.lua    # Key mappings
│   │   └── autocmds.lua   # Auto commands
│   ├── plugins/
│   │   ├── ui.lua         # UI plugins
│   │   ├── tools.lua      # Tool plugins
│   │   └── lsp.lua        # LSP plugins
│   └── utils/
│       └── theme_switcher.lua  # Theme utilities
└── stylua.toml        # Formatting configuration
```

### Changing Themes
The configuration includes multiple dark themes. To switch themes, use the `<leader>th` keybinding.

Available themes: `tokyonight`, `catppuccin`, `kanagawa`, `rose-pine`

### Adding New Plugins
1. Add the plugin to the appropriate file in `lua/plugins/`
2. Follow the existing pattern for plugin configuration
3. Run `:Lazy sync` to install the new plugin

### Custom Keybindings
Edit `lua/config/keymaps.lua` to add or modify keybindings. Follow the existing pattern for consistency.

## 🔧 Troubleshooting

### Common Issues

#### Plugin Installation Fails or Lazy.nvim Errors
```bash
# Linux/macOS - Clear all Neovim data
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Windows PowerShell - Clear all Neovim data
rm -Force -Recurse ~\AppData\Local\nvim-data
rm -Force -Recurse ~\AppData\Local\Temp\nvim

# Then restart Neovim to reinstall everything
nvim
```

#### Treesitter Module Errors
```bash
# If you get treesitter.configs not found errors:
# 1. Clear all data (commands above)
# 2. Or manually remove treesitter plugins:

# Windows PowerShell
rm -Force -Recurse ~\AppData\Local\nvim-data\lazy\nvim-treesitter*

# Linux/macOS
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter*

# Then restart Neovim
nvim
```

#### LSP Servers Not Working
```bash
# Install missing LSP servers via Mason
:MasonInstall lua_ls pyright tsserver
```

#### Performance Issues
```bash
# Check startup time
nvim --startuptime startup.log
# Disable heavy plugins temporarily if needed
```

#### Debugger Not Working
Ensure required dependencies are installed:
```bash
# For Python debugging
pip install debugpy
```

### Health Check
Run `:checkhealth` in Neovim to diagnose common issues with:
- LSP servers
- Treesitter parsers
- Plugin dependencies

### Getting Help
1. Check the `:help` documentation in Neovim
2. Review plugin documentation for specific issues
3. Open an issue on GitHub with detailed error messages

## 📝 License

MIT License - feel free to use, modify, and distribute this configuration.

## 🤝 Contributing

Contributions are welcome! Please feel free to:
- Open issues for bugs or feature requests
- Submit pull requests for improvements
- Share your customizations and tips

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

---

**Happy Coding!** 🚀

*If you enjoy this configuration, consider giving it a star on GitHub!*
