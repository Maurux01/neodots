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
local plugins = {
  -- Essential plugins loaded directly
  { "folke/tokyonight.nvim", priority = 1000, config = function() vim.cmd("colorscheme tokyonight") end },
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("nvim-tree").setup() end },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("lualine").setup() end },
  { "goolord/alpha-nvim", event = "VimEnter", config = function() require("alpha").setup(require("alpha.themes.dashboard").config) end },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("telescope").setup() end },
  { "folke/which-key.nvim", config = function() require("which-key").setup() end },
  { "rcarriga/nvim-notify", config = function() vim.notify = require("notify") end },
}

-- Load additional plugins from files
local ok, ui_plugins = pcall(require, "plugins.ui")
if ok then
  for _, plugin in ipairs(ui_plugins) do
    table.insert(plugins, plugin)
  end
end

local ok, tools_plugins = pcall(require, "plugins.tools")
if ok then
  for _, plugin in ipairs(tools_plugins) do
    table.insert(plugins, plugin)
  end
end

local ok, lsp_plugins = pcall(require, "plugins.lsp")
if ok then
  for _, plugin in ipairs(lsp_plugins) do
    table.insert(plugins, plugin)
  end
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


