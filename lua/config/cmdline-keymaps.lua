-- Enhanced command line and code suggestion keymaps
local keymap = vim.keymap.set

-- Codeium AI suggestions
keymap("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true, desc = "Accept AI suggestion" })
keymap("i", "<C-;>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true, silent = true, desc = "Next AI suggestion" })
keymap("i", "<C-,>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true, silent = true, desc = "Previous AI suggestion" })
keymap("i", "<C-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true, desc = "Clear AI suggestions" })

-- Enhanced command line navigation
keymap("c", "<C-a>", "<Home>", { desc = "Go to beginning of line" })
keymap("c", "<C-e>", "<End>", { desc = "Go to end of line" })
keymap("c", "<C-f>", "<Right>", { desc = "Move cursor right" })
keymap("c", "<C-b>", "<Left>", { desc = "Move cursor left" })
keymap("c", "<C-d>", "<Del>", { desc = "Delete character" })
keymap("c", "<C-h>", "<BS>", { desc = "Backspace" })

-- Better command history
keymap("c", "<C-p>", "<Up>", { desc = "Previous command" })
keymap("c", "<C-n>", "<Down>", { desc = "Next command" })

-- Quick command shortcuts
keymap("n", "<leader>:", ":", { desc = "Command mode" })
keymap("n", "<leader>/", "/", { desc = "Search forward" })
keymap("n", "<leader>?", "?", { desc = "Search backward" })

-- Code action shortcuts
keymap("n", "<leader>ca", "<cmd>CodeActionMenu<cr>", { desc = "Code Actions" })
keymap("n", "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Format code" })
keymap("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- Enhanced search with suggestions
keymap("n", "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search in buffer" })
keymap("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "Search word under cursor" })
keymap("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<leader>sr", "<cmd>Telescope resume<cr>", { desc = "Resume last search" })

-- Function signature help
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
keymap("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- Better completion navigation
keymap("i", "<C-Space>", function()
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.close()
  else
    cmp.complete()
  end
end, { desc = "Toggle completion" })

-- Command palette shortcuts
keymap("n", "<C-S-p>", "<cmd>Telescope commands<cr>", { desc = "Command palette" })
keymap("n", "<leader>cp", "<cmd>Telescope commands<cr>", { desc = "Command palette" })

-- Quick file operations
keymap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })
keymap("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
keymap("n", "<leader>fS", "<cmd>wa<cr>", { desc = "Save all files" })
keymap("n", "<leader>fq", "<cmd>q<cr>", { desc = "Quit" })
keymap("n", "<leader>fQ", "<cmd>qa<cr>", { desc = "Quit all" })

-- Enhanced diagnostics
keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
keymap("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
keymap("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- Better terminal integration
keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float terminal" })
keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal terminal" })
keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Vertical terminal" })
keymap("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
keymap("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
keymap("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
keymap("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })