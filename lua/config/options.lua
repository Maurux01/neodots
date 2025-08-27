-- Neovim options configuration for maurux01's setup
-- Optimized for performance and modern development workflow

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Performance optimizations
vim.loader.enable()
vim.opt.lazyredraw = true
vim.opt.ttyfast = true
vim.opt.regexpengine = 1
vim.opt.synmaxcol = 300
vim.opt.maxmempattern = 5000
vim.opt.history = 1000
vim.opt.undolevels = 10000

-- Terminal colors and transparency
vim.opt.termguicolors = true

-- Enable transparency support
vim.g.transparent_enabled = true

-- Force transparency function
local function force_transparency()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
  vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
  vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
  vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
  vim.api.nvim_set_hl(0, "SpecialKey", { bg = "none" })
  vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
  vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3e4451" })
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "none" })
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
end

-- Apply transparency on colorscheme change and after UI loads
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "UIEnter" }, {
  pattern = "*",
  callback = force_transparency,
})

-- Force transparency after a delay to ensure it applies
vim.defer_fn(force_transparency, 100)

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Force line numbers in all buffers
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter" }, {
  pattern = "*",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = false
  end,
})

-- Tab and indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line wrapping
vim.opt.wrap = false

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Cursor line
vim.opt.cursorline = true

-- Appearance
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.cmdheight = 1

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = { space = ".", tab = "..", trail = ".", nbsp = "+" }

-- Hide tilde on empty lines
vim.opt.fillchars = { eob = " " }

-- Backspace behavior
vim.opt.backspace = "indent,eol,start"

-- Clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Undo and backup
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Timeouts
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Completion
vim.opt.completeopt = "menuone,noselect"

-- Hide mode text (INSERT, VISUAL, etc.) since lualine shows it
vim.opt.showmode = false

-- Mouse support
vim.opt.mouse = "a"

-- File encoding
vim.opt.fileencoding = "utf-8"

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

-- GUI options (if running in GUI)
if vim.fn.has("gui_running") == 1 then
  vim.opt.guifont = "FiraCode Nerd Font:h12"
end

-- Netrw configuration (disabled in favor of nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable built-in plugins for performance
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_man = 1
vim.g.loaded_shada_plugin = 1

-- Additional performance optimizations
vim.opt.redrawtime = 1500
vim.opt.ttimeoutlen = 10
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

-- Wildmenu and completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.dll", "*.exe" })
vim.opt.wildignore:append({ "*.pyc", "*.class", "*.so", "*.a" })
vim.opt.wildignore:append({ "*.swp", "*.bak", "*.pyc", "*.class" })
vim.opt.wildignore:append({ "node_modules/", "dist/", "build/", ".git/" })

-- Session options
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize"

-- Grep program
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
  vim.opt.grepformat = "%f:%l:%c:%m"
end

-- Diagnostic signs
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })


-- Initialize transparency utility and wallpaper support
require("utils.transparency").init()
require("config.wallpaper").setup()

-- Default commentstring for various file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    local commentstrings = {
      lua = "-- %s",
      python = "# %s",
      javascript = "// %s",
      typescript = "// %s",
      html = "<!-- %s -->",
      css = "/* %s */",
      json = "",
      markdown = "<!-- %s -->",
      vim = '" %s',
      bash = "# %s",
      sh = "# %s",
      zsh = "# %s",
      fish = "# %s",
      yaml = "# %s",
      toml = "# %s",
      ini = "; %s",
      conf = "# %s",
      dockerfile = "# %s",
      gitignore = "# %s",
      gitconfig = "# %s",
    }
    
    local ft = vim.bo.filetype
    if commentstrings[ft] then
      vim.bo.commentstring = commentstrings[ft]
    elseif vim.bo.commentstring == "" then
      vim.bo.commentstring = "# %s"
    end
  end,
})