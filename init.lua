-- Neovim configuration for maurux01
-- Minimal, beautiful, and powerful setup inspired by kickstart.nvim
-- With VS Code-like features and smooth animations

-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  local result = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    print("Error installing lazy.nvim: " .. result)
    print("Please install Git and try again")
    return
  end
  print("lazy.nvim installed successfully!")
end
vim.opt.rtp:prepend(lazypath)

-- Load options
require("config.options")

-- Check if lazy.nvim is available
local lazy_available, lazy = pcall(require, "lazy")
if not lazy_available then
  print("lazy.nvim not found. Please install Git and restart Neovim.")
  return
end

-- Import plugin configurations with error handling
local function safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    print("Error loading " .. module .. ": " .. result)
    return {}
  end
  return result
end

local ui_plugins = safe_require("plugins.ui")
local tools_plugins = safe_require("plugins.tools")
local lsp_plugins = safe_require("plugins.lsp")

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
lazy.setup(plugins, {
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


