-- Neovim Configuration for Neodots
-- A modern Neovim setup with AI integration, transparency, and advanced features

-- Bootstrap lazy.nvim
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

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load plugins
require("lazy").setup("plugins")

-- Load core configuration
require("core")

-- Load additional modules
require("notifications")
require("git-docker")
require("image-viewer")
require("screenshot")
require("recording")
require("transparency")
require("wallpaper")
require("dashboard")
require("themes")
require("dap")
require("advanced")
