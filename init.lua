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

-- Setup lazy.nvim with all plugins
local plugins = {}

-- Load UI plugins
local ui_plugins = require("plugins.ui")
for _, plugin in ipairs(ui_plugins) do
  table.insert(plugins, plugin)
end

-- Load tools plugins
local tools_plugins = require("plugins.tools")
for _, plugin in ipairs(tools_plugins) do
  table.insert(plugins, plugin)
end

-- Load LSP plugins
local lsp_plugins = require("plugins.lsp")
for _, plugin in ipairs(lsp_plugins) do
  table.insert(plugins, plugin)
end

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

-- Load configurations with error handling
pcall(require, "config.keymaps")
pcall(require, "config.autocmds")
pcall(require, "utils.theme_switcher")
pcall(require, "utils.health_check")

-- Set colorscheme with fallback
pcall(function()
  vim.cmd("colorscheme tokyonight")
end)


