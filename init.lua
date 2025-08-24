-- Neovim Configuration for Neodots
-- A modern Neovim setup with AI integration, transparency, and advanced features

-- Disable unused built-in plugins for better performance
local disabled_built_ins = {
  '2html_plugin', 'getscript', 'getscriptPlugin', 'gzip', 'logiPat', 'matchit',
  'matchparen', 'netrw', 'netrwFileHandlers', 'netrwPlugin', 'netrwSettings',
  'rrhelper', 'spellfile_plugin', 'tar', 'tarPlugin', 'vimball', 'vimballPlugin',
  'zip', 'zipPlugin', 'tutor', 'rplugin', 'syntax', 'synmenu', 'optwin',
  'compiler', 'bugreport', 'ftplugin', 'editorconfig'
}

for _, plugin in ipairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- Set leader keys early
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim with optimized settings
local lazy_config = {
  root = vim.fn.stdpath('data') .. '/lazy',
  defaults = {
    lazy = true, -- Enable lazy loading by default
    version = false, -- Use the latest version of plugins
  },
  install = {
    missing = true,
    colorscheme = { 'tokyonight' },
  },
  ui = {
    border = 'rounded',
  },
  spec = {
    -- Add tokyonight colorscheme
    { 'folke/tokyonight.nvim', lazy = false, priority = 1000 },
  },
  checker = {
    enabled = true,
    notify = false, -- Disable notifications for updates
    frequency = 86400, -- Check once per day
  },
  performance = {
    rtp = {
      disabled_plugins = disabled_built_ins,
      reset = true, -- Reset runtimepath to exclude disabled plugins
    },
    cache = {
      enabled = true,
    },
  },
  ui = {
    border = 'rounded',
    size = { width = 0.8, height = 0.8 },
    wrap = true,
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      source = '📄',
      start = '🚀',
      task = '📌',
    },
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
}

-- Load core settings before plugins
local function load_core()
  local core_modules = {
    'core.options',
    'core.keymaps',
    'core.autocmds',
  }

  for _, mod in ipairs(core_modules) do
    local status_ok, _ = pcall(require, mod)
    if not status_ok then
      vim.notify('Failed to load ' .. mod, vim.log.levels.WARN)
    end
  end
end

-- Load plugins
local function setup_plugins()
  local status_ok, lazy = pcall(require, 'lazy')
  if not status_ok then
    vim.notify('Failed to load lazy.nvim', vim.log.levels.ERROR)
    return false
  end

  lazy.setup('plugins', lazy_config)
  return true
end

-- Load user configuration if it exists
local function load_user_config()
  local user_config = vim.fn.stdpath('config') .. '/lua/user/init.lua'
  if vim.fn.filereadable(user_config) == 1 then
    local status_ok, _ = pcall(require, 'user')
    if not status_ok then
      vim.notify('Failed to load user config', vim.log.levels.WARN)
    end
  end
end

-- Set up autocommands
local function setup_autocmds()
  local augroup = vim.api.nvim_create_augroup('NeodotsConfig', { clear = true })
  
  -- Highlight on yank
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup,
    callback = function()
      vim.highlight.on_yank({ timeout = 200, on_visual = false })
    end,
  })

  -- Auto resize panes
  vim.api.nvim_create_autocmd('VimResized', {
    group = augroup,
    pattern = '*',
    command = 'tabdo wincmd =',
  })

  -- Auto update files when changed on disk
  vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
    group = augroup,
    pattern = '*',
    command = 'if mode() != ''c'' | checktime | endif',
    nested = true,
  })

  -- Auto close some filetypes with <q>
  vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = {
      'qf', 'help', 'man', 'notify', 'lspinfo', 'spectre_panel',
      'startuptime', 'tsplayground', 'PlenaryTestPopup',
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end,
  })

  -- Auto format on save
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup,
    pattern = { '*.lua', '*.py', '*.js', '*.ts', '*.json', '*.rs' },
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
end

-- Initialize Neodots
local function init()
  -- Load core settings first
  load_core()
  
  -- Set up autocommands
  setup_autocmds()
  
  -- Set up plugins
  local plugins_loaded = setup_plugins()
  
  -- Load user config after plugins
  if plugins_loaded then
    vim.defer_fn(function()
      load_user_config()
      
      -- Load colorscheme after plugins and user config
      pcall(vim.cmd, 'colorscheme tokyonight')
      
      -- Notify when done
      vim.schedule(function()
        vim.notify('Neodots loaded successfully!', vim.log.levels.INFO, {
          title = 'Neodots',
          timeout = 1000,
        })
      end)
    end, 50)
  end
end

-- Start initialization
init()
