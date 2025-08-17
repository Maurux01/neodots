-- Core Neovim configuration
local M = {}

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.opt.timeoutlen = 300

-- Transparency and background settings
vim.opt.background = "dark"
vim.opt.transparency = 0.8 -- Adjustable transparency

-- Enable true colors
vim.opt.termguicolors = true

-- Set colorscheme
vim.cmd.colorscheme "catppuccin"

-- Keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Buffer management
keymap("n", "<leader>bd", ":bd<CR>", opts)
keymap("n", "<leader>bn", ":bn<CR>", opts)
keymap("n", "<leader>bp", ":bp<CR>", opts)

-- Window management
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)

-- Quick save and quit
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

-- LSP
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

-- AI Chat
keymap("n", "<leader>ai", "<cmd>ChatGPT<cr>", opts)
keymap("n", "<leader>ae", "<cmd>ChatGPTEditWithInstructions<cr>", opts)

-- Screenshot and recording
keymap("n", "<leader>ss", "<cmd>lua require('screenshot').take_screenshot()<cr>", opts)
keymap("n", "<leader>sr", "<cmd>lua require('recording').toggle_recording()<cr>", opts)

-- Git and Docker
keymap("n", "<leader>gg", "<cmd>LazyGit<cr>", opts)
keymap("n", "<leader>gd", "<cmd>LazyDocker<cr>", opts)

-- Transparency controls
keymap("n", "<leader>t+", "<cmd>lua require('transparency').increase()<cr>", opts)
keymap("n", "<leader>t-", "<cmd>lua require('transparency').decrease()<cr>", opts)
keymap("n", "<leader>tw", "<cmd>lua require('wallpaper').toggle()<cr>", opts)

  -- Image viewer
  keymap("n", "<leader>iv", "<cmd>lua toggle_image_viewer()<cr>", opts)
  keymap("n", "<leader>id", "<cmd>lua download_remote_images()<cr>", opts)

  -- Enhanced comments
  keymap("n", "<leader>cc", "<cmd>CommentToggle<CR>", opts)
  keymap("n", "<leader>cb", "<cmd>CommentToggleBlock<CR>", opts)
  keymap("v", "<leader>c", ":CommentToggle<CR>", opts)
  keymap("v", "<leader>b", ":CommentToggleBlock<CR>", opts)

  return M
