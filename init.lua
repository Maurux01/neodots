-- Neovim Configuration for Neodots
-- A modern Neovim setup with AI integration, transparency, and advanced features

-- Disable some built-in plugins
local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'matchit',
  'matchparen',
  'logiPat',
  'rrhelper',
  'spellfile_plugin',
  'syntax',
  'synmenu',
  'optwin',
  'compiler',
  'bugreport',
  'ftplugin',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

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

-- Load core settings before plugins
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Configure lazy.nvim
local lazy_config = {
  root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
  },
  install = {
    -- install missing plugins on startup
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "tokyonight" },
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true,    -- get a notification when new updates are found
    frequency = 3600,  -- check for updates every hour
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = disabled_built_ins,
    },
  },
  ui = {
    -- a number <1 is a percentage, >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
    -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
    backdrop = 10,
    -- The highlight group to use for the UI window.
    hl = "Normal",
    -- The highlight group to use for the UI window when it's not focused.
    hl_nofocus = "NormalNC",
    -- The highlight group to use for the cursor line.
    hl_cursorline = "CursorLine",
    -- The highlight group to use for the cursor line number.
    hl_cursorlinenr = "CursorLineNr",
    -- The highlight group to use for the line that contains the cursor.
    hl_cursorline_normal = "CursorLine",
    -- The highlight group to use for the line that contains the cursor in insert mode.
    hl_cursorline_insert = "CursorLine",
    -- The highlight group to use for the line that contains the cursor in visual mode.
    hl_cursorline_visual = "CursorLine",
    -- The highlight group to use for the line that contains the cursor in replace mode.
    hl_cursorline_replace = "CursorLine",
    -- The highlight group to use for the line that contains the cursor in command mode.
    hl_cursorline_command = "CursorLine",
    -- The highlight group to use for the line that contains the cursor in terminal mode.
    hl_cursorline_term = "CursorLine",
    -- The highlight group to use for the line that contains the cursor in terminal mode when in insert mode.
    hl_cursorline_term_insert = "CursorLine",
  },
}

-- Load plugins
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  vim.notify("Failed to load lazy.nvim", vim.log.levels.ERROR)
  return
end

lazy.setup("plugins", lazy_config)

-- Load user configuration if it exists
local user_config = vim.fn.stdpath("config") .. "/lua/user/init.lua"
if vim.fn.filereadable(user_config) == 1 then
  require("user")
end

-- Load colorscheme
pcall(vim.cmd, [[colorscheme tokyonight]])

-- Load LSP and other plugin configurations
local function load_plugin_configs()
  local configs = {
    "lsp",
    "treesitter",
    "telescope",
    "lualine",
    "bufferline",
    "gitsigns",
    "nvim-tree",
    "toggleterm",
    "which-key",
    "comment",
    "autopairs",
    "indent-blankline",
    "colorizer",
    "neotest",
    "dap",
    "notify",
    "rest",
  }

  for _, config in ipairs(configs) do
    local ok, _ = pcall(require, "config." .. config)
    if not ok then
      -- Try loading from plugins directory if not found in config
      pcall(require, "plugins." .. config)
    end
  end
end

-- Load plugin configurations with a delay to ensure plugins are loaded
vim.defer_fn(function()
  load_plugin_configs()
  vim.cmd([[doautocmd User LazyDone]])
end, 0)

-- Set up autocommands
local augroup = vim.api.nvim_create_augroup("NeodotsConfig", { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Auto resize panes when resizing nvim window
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Auto update files when they change on disk
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = augroup,
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
  nested = true,
})

-- Auto close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.json", "*.rs" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
