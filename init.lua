-- Neovim configuration for maurux01
-- Minimal, beautiful, and powerful setup inspired by kickstart.nvim
-- With VS Code-like features and smooth animations

-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

-- Import plugin configurations
local ui_plugins = require("plugins.ui")
local tools_plugins = require("plugins.tools")
local lsp_plugins = require("plugins.lsp")

-- Combine all plugins
local plugins = {}
for _, plugin in ipairs(ui_plugins) do
  table.insert(plugins, plugin)
end
for _, plugin in ipairs(tools_plugins) do
  table.insert(plugins, plugin)
end
for _, plugin in ipairs(lsp_plugins) do
  table.insert(plugins, plugin)
end

-- Configure plugins
require("lazy").setup(plugins, {
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

-- Load keymaps
require("config.keymaps")

-- Load auto commands
require("config.autocmds")

-- Set colorscheme
vim.cmd("colorscheme tokyonight")

print("🚀 Neovim configuration loaded successfully!")
