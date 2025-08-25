# Neodots Installation Guide

## 🚀 Quick Installation

1. **Backup your current Neovim configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/maurux01/neodots ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Wait for plugins to install** - Lazy.nvim will automatically install all required plugins.

## 📋 Requirements

- Neovim 0.9.0 or higher
- Git
- Nerd Font (recommended: FiraCode Nerd Font)
- Node.js (for LSP servers)
- Python (for some plugins)

## 🎯 Features Implemented

### ✅ Core Configuration
- Modular plugin structure in `lua/plugins/`
- Optimized Neovim options in `lua/config/options.lua`
- Comprehensive key mappings in `lua/config/keymaps.lua`
- Automatic behaviors in `lua/config/autocmds.lua`

### ✅ UI & Visual Enhancements
- **Tokyo Night** theme with transparent background
- **Nvim-tree** file explorer with icons
- **Lualine** status line
- **Dashboard-nvim** animated startup screen
- **Bufferline** tab-like interface
- **Indent-blankline** visual indent guides
- **Nvim-notify** animated notifications
- **Neoscroll** smooth scrolling

### ✅ Development Tools
- **Telescope** fuzzy finder
- **Gitsigns** git integration
- **Symbols-outline** code outline
- **Undotree** undo history visualization
- **Lazygit** git interface
- **Auto-pairs** automatic bracket pairing
- **Comment.nvim** easy code commenting

### ✅ LSP & Completion
- **Nvim-lspconfig** LSP configuration
- **Mason** LSP server management
- **Nvim-cmp** autocompletion
- **Treesitter** enhanced syntax highlighting
- **LuaSnip** snippet engine
- **LSP signature** signature help
- **Fidget** LSP progress notifications

## 🔧 Customization

The configuration is modular and easy to customize:

- Edit `lua/config/options.lua` for Neovim options
- Modify `lua/config/keymaps.lua` for key mappings
- Update `lua/config/autocmds.lua` for automatic behaviors
- Customize plugins in their respective files in `lua/plugins/`

## 🐛 Troubleshooting

If you encounter issues:

1. **Update plugins**: `:Lazy update`
2. **Check health**: `:checkhealth`
3. **Clear cache**: Delete `~/.local/share/nvim/lazy` and restart
4. **Check logs**: `:messages` to see error messages

## 📝 License

MIT License - feel free to use and modify!

---

**Enjoy your enhanced Neovim experience!** 🎉
