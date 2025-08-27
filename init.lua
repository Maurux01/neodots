-- Neodots - Modern Neovim Configuration
-- Fast startup with lazy loading and performance optimizations

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

-- Load configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Load snippets and completion config after plugins are loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    require("config.snippets")
    require("config.completion")
  end,
})

-- Setup lazy.nvim with performance optimizations
require("lazy").setup({
  { import = "plugins" },
}, {
  defaults = { 
    lazy = true,
    version = false,
  },
  install = {
    missing = true,
    colorscheme = { "tokyonight" },
  },
  checker = {
    enabled = false,
    notify = false,
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
  performance = {
    cache = { 
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy/cache",
      ttl = 3600 * 24 * 5,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
      },
    },
  },
  ui = {
    size = { width = 0.8, height = 0.8 },
    wrap = true,
    border = "rounded",
  },
})