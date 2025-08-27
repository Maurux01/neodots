-- NvChad style keymaps configuration
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Setup nvim-tree keymaps
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    pcall(function()
      require("nvim-tree").setup()
    end)
  end,
})

-- Basic navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- VS Code style
map("n", "<C-p>", ":Telescope find_files<CR>", opts)
map("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
map("n", "<F2>", ":NvimTreeToggle<CR>", opts)

-- Buffer navigation (múltiples opciones)
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)
map("n", "<C-t>", ":enew<CR>", opts)
map("n", "<C-q>", ":Bdelete<CR>", opts)
map("n", "<leader>n", ":enew<CR>", opts)
map("n", "<C-Tab>", ":CybuNext<CR>", opts)
map("n", "<C-S-Tab>", ":CybuPrev<CR>", opts)
map("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", opts)
map("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", opts)
map("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", opts)
map("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>", opts)
map("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>", opts)
-- Navegación rápida con números
map("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
map("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
map("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
map("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
map("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)

-- Live Server
map("n", "<F5>", ":LiveServerStart<CR>", opts)
map("n", "<S-F5>", ":LiveServerStop<CR>", opts)

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", opts)
map("n", "<A-i>", ":ToggleTerm direction=float<CR>", opts)
map("n", "<A-h>", ":ToggleTerm direction=horizontal<CR>", opts)
map("n", "<A-v>", ":ToggleTerm direction=vertical size=80<CR>", opts)
map("n", "<C-`>", ":ToggleTerm<CR>", opts)
map("n", "<F12>", ":ToggleTerm direction=float<CR>", opts)

-- Quick splits
map("n", "<C-\\>", ":vsplit<CR>", opts)
map("n", "<C-->", ":split<CR>", opts)

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)

-- Better movement
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Simple keymaps for which-key
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Explorer" })
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>x", ":x<CR>", { desc = "Save & Quit" })
map("n", "<leader>/", ":lua require('Comment.api').toggle.linewise.current()<CR>", { desc = "Comment" })

-- Find/File mappings
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Grep" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help" })
map("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Keymaps" })

-- Git mappings
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })
map("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Blame" })
map("n", "<leader>gd", ":Gitsigns diffthis<CR>", { desc = "Diff" })
map("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
map("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", { desc = "Undo Stage" })

-- Terminal mappings
map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle" })
map("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { desc = "Float" })
map("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { desc = "Horizontal" })
map("n", "<leader>tv", ":ToggleTerm direction=vertical size=80<CR>", { desc = "Vertical" })

-- Buffer mappings
map("n", "<leader>bd", ":Bdelete<CR>", { desc = "Delete" })
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous" })

-- Window mappings
map("n", "<leader>wv", ":vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>ws", ":split<CR>", { desc = "Horizontal Split" })
map("n", "<leader>wc", ":close<CR>", { desc = "Close" })

-- LSP mappings
map("n", "gd", vim.lsp.buf.definition, { desc = "Definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })

-- Debug mappings
map("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", { desc = "Breakpoint" })
map("n", "<leader>dc", ":lua require('dap').continue()<CR>", { desc = "Continue" })
map("n", "<leader>di", ":lua require('dap').step_into()<CR>", { desc = "Step Into" })
map("n", "<leader>do", ":lua require('dap').step_over()<CR>", { desc = "Step Over" })
map("n", "<leader>du", ":lua require('dapui').toggle()<CR>", { desc = "UI" })

-- Code mappings
map("n", "<leader>cc", ":lua require('Comment.api').toggle.linewise.current()<CR>", { desc = "Comment" })
map("n", "<leader>cf", ":lua require('conform').format()<CR>", { desc = "Format" })

-- UI mappings
map("n", "<leader>uz", ":ZenMode<CR>", { desc = "Zen Mode" })
map("n", "<leader>ut", ":Twilight<CR>", { desc = "Twilight" })
map("n", "<leader>uth", ":lua require('utils.theme_manager').telescope_themes()<CR>", { desc = "Change Theme" })
map("n", "<leader>utt", ":lua require('utils.theme_manager').switch_theme()<CR>", { desc = "Next Theme" })

-- Quick theme switching
map("n", "<leader>th", ":lua require('utils.theme_manager').telescope_themes()<CR>", { desc = "Theme Picker" })
map("n", "<leader>tn", ":lua require('utils.theme_manager').switch_theme()<CR>", { desc = "Next Theme" })

-- Direct theme shortcuts (optional)
map("n", "<leader>t1", ":colorscheme tokyonight-night<CR>", { desc = "Tokyo Night" })
map("n", "<leader>t2", ":colorscheme catppuccin-mocha<CR>", { desc = "Catppuccin" })
map("n", "<leader>t3", ":colorscheme kanagawa-wave<CR>", { desc = "Kanagawa" })
map("n", "<leader>t4", ":colorscheme rose-pine<CR>", { desc = "Rose Pine" })
map("n", "<leader>t5", ":colorscheme gruvbox-material<CR>", { desc = "Gruvbox Material" })
map("n", "<leader>t6", ":colorscheme dracula<CR>", { desc = "Dracula" })
map("n", "<leader>t7", ":colorscheme onedark<CR>", { desc = "One Dark" })
map("n", "<leader>t8", ":colorscheme nightfox<CR>", { desc = "Nightfox" })
map("n", "<leader>t9", ":colorscheme cyberdream<CR>", { desc = "Cyberdream" })

-- Create user commands for theme switching
vim.api.nvim_create_user_command('ThemePicker', function()
  require('utils.theme_manager').telescope_themes()
end, { desc = 'Open theme picker' })

vim.api.nvim_create_user_command('NextTheme', function()
  require('utils.theme_manager').switch_theme()
end, { desc = 'Switch to next theme' })

vim.api.nvim_create_user_command('SetTheme', function(opts)
  require('utils.theme_manager').set_theme(opts.args)
end, { nargs = 1, desc = 'Set specific theme' })

-- Command to force transparency
vim.api.nvim_create_user_command('ForceTransparency', function()
  local function force_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
    vim.notify("Transparency applied!", vim.log.levels.INFO)
  end
  force_transparency()
end, { desc = 'Force transparency on current theme' })

map("n", "<leader>ut", ":ForceTransparency<CR>", { desc = "Force Transparency" })

-- Media viewer mappings
map("n", "<leader>vi", ":lua require('image').clear()<CR>", { desc = "Clear Images" })
map("n", "<leader>vp", ":!start <cfile><CR>", { desc = "Open PDF externally" })
map("n", "<leader>vo", ":!start <cfile><CR>", { desc = "Open file externally" })