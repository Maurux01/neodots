# maurux01's Neovim Configuration

A minimal, beautiful, and powerful Neovim configuration inspired by kickstart.nvim, featuring VS Code-like functionality with smooth animations and modern UI enhancements.

## ✨ Features

- **🎨 Beautiful UI**: Tokyo Night theme with transparent background
- **⚡ Fast Performance**: Optimized startup time and lazy loading
- **🔍 VS Code-like Experience**: Familiar keybindings and workflow
- **🎭 Smooth Animations**: Animated notifications and transitions
- **🧩 Modern Plugins**: Latest Neovim plugins for maximum productivity

## 🚀 Quick Start

1. **Backup your current Neovim configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/maurux01/neodots ~/.config/nvim
   ```

Step 2: Run the Automatic Installer
Choose the installer for your operating system:

🐧 Linux/macOS:

# Make the script executable and run it
chmod +x install.sh
./install.sh
🪟 Windows (PowerShell):

# Enable script execution and run the installer
Set-ExecutionPolicy Bypass -Scope Process -Force
.\install-neodots.ps1

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Wait for plugins to install** - Lazy.nvim will automatically install all required plugins.

## 🛠️ Requirements

- Neovim 0.9.0 or higher
- Git
- Nerd Font (recommended: FiraCode Nerd Font)
- Node.js (for LSP servers)
- Python (for some plugins)

## ⌨️ Keybindings

### File Operations
- `<leader>e` - Toggle file explorer (NvimTree)
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep (Telescope)
- `<leader>fb` - Find buffers (Telescope)
- `Ctrl+P` - Quick file search (VS Code style)

### Navigation
- `Ctrl+h/j/k/l` - Window navigation
- `Ctrl+b` - Toggle file explorer
- `Ctrl+,` - Switch buffers

### LSP & Code
- `gd` - Go to definition
- `gr` - Find references
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>f` - Format code

### Git
- `<leader>gg` - LazyGit
- `<leader>gb` - Toggle git blame
- `<leader>gd` - Git diff

## 🎯 Plugin Highlights

- **UI**: tokyonight.nvim, lualine.nvim, nvim-tree.lua
- **LSP**: nvim-lspconfig, mason.nvim, nvim-cmp
- **Tools**: telescope.nvim, gitsigns.nvim, nvim-treesitter
- **Animations**: nvim-notify, neoscroll.nvim
- **Productivity**: nvim-autopairs, Comment.nvim, indent-blankline.nvim

## 🎨 Customization

The configuration is modular and easy to customize:

- `init.lua` - Main configuration file
- `lua/config/options.lua` - Neovim options
- `lua/config/keymaps.lua` - Key mappings
- `lua/config/autocmds.lua` - Auto commands

## 🔧 Troubleshooting

If you encounter any issues:

1. **Update plugins**: `:Lazy update`
2. **Check health**: `:checkhealth`
3. **Clear plugin cache**: Delete `~/.local/share/nvim/lazy` and restart Neovim

## 📝 License

MIT License - feel free to use and modify this configuration!

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or pull requests for improvements.

---

**Enjoy your new Neovim experience!** 🎉
