-- Neovim configuration for maurux01
-- Minimal, beautiful, and powerful setup inspired by kickstart.nvim
-- With VS Code-like features and smooth animations

-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load options
require("config.options")

-- Setup lazy.nvim
require("lazy").setup({
  { import = "plugins.ui" },
  { import = "plugins.tools" },
  { import = "plugins.lsp" },
}, {
  install = {
    colorscheme = { "tokyonight" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Load configurations with error handling
pcall(require, "config.keymaps")
pcall(require, "config.autocmds")
pcall(require, "utils.theme_switcher")
pcall(require, "utils.health_check")

-- Set colorscheme with fallback
pcall(function()
  vim.cmd("colorscheme tokyonight")
end)


