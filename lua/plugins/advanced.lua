-- Advanced features configuration
local M = {}

-- ===== TESTING =====

-- Neotest keymaps
vim.keymap.set("n", "<leader>tt", "<cmd>lua require('neotest').run.run()<CR>", { desc = "Run test" })
vim.keymap.set("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { desc = "Run test file" })
vim.keymap.set("n", "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", { desc = "Debug test" })
vim.keymap.set("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", { desc = "Toggle test summary" })
vim.keymap.set("n", "<leader>to", "<cmd>lua require('neotest').output.open({enter = true})<CR>", { desc = "Open test output" })

-- ===== PROJECT MANAGEMENT =====

-- Project telescope
vim.keymap.set("n", "<leader>pp", "<cmd>Telescope project<CR>", { desc = "Project picker" })

-- ===== TROUBLE =====

-- Trouble keymaps
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<CR>", { desc = "Toggle trouble" })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", { desc = "Location list" })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", { desc = "Quickfix list" })

-- ===== AERIAL =====

-- Aerial keymaps
vim.keymap.set("n", "<leader>aa", "<cmd>AerialToggle!<CR>", { desc = "Toggle aerial" })
vim.keymap.set("n", "<leader>an", "<cmd>AerialNext<CR>", { desc = "Next aerial" })
vim.keymap.set("n", "<leader>ap", "<cmd>AerialPrev<CR>", { desc = "Previous aerial" })

-- ===== SESSION MANAGEMENT =====

-- Session keymaps
vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Save session" })
vim.keymap.set("n", "<leader>sl", "<cmd>SessionLoad<CR>", { desc = "Load session" })
vim.keymap.set("n", "<leader>sd", "<cmd>SessionDelete<CR>", { desc = "Delete session" })

-- ===== MARKDOWN PREVIEW =====

-- Markdown preview keymaps
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle markdown preview" })

-- ===== VIMWIKI =====

-- Vimwiki keymaps
vim.keymap.set("n", "<leader>ww", "<cmd>VimwikiIndex<CR>", { desc = "Vimwiki index" })
vim.keymap.set("n", "<leader>wt", "<cmd>VimwikiTabIndex<CR>", { desc = "Vimwiki tab index" })
vim.keymap.set("n", "<leader>ws", "<cmd>VimwikiUISelect<CR>", { desc = "Vimwiki UI select" })

-- ===== EMmet =====

-- Emmet keymaps (already configured in plugin)
vim.keymap.set("i", "<C-y>,", "<cmd>Emmet<CR>", { desc = "Emmet expand" })

-- ===== TERMINAL =====

-- Terminal keymaps
vim.keymap.set("t", "<C-\\><C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Terminal left" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Terminal down" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Terminal up" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Terminal right" })

-- ===== FILE EXPLORER =====

-- Nvim-tree keymaps
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })

-- ===== LEGENDARY =====

-- Legendary keymaps
vim.keymap.set("n", "<leader>:", "<cmd>Legendary<CR>", { desc = "Legendary command palette" })

-- ===== CONFORM =====

-- Conform keymaps
vim.keymap.set("n", "<leader>cf", "<cmd>lua require('conform').format()<CR>", { desc = "Format code" })

-- ===== UTILITY FUNCTIONS =====

-- Function to toggle between file explorers
local function toggle_file_explorer()
  local neo_tree_exists = pcall(require, "neo-tree")
  local nvim_tree_exists = pcall(require, "nvim-tree")
  
  if neo_tree_exists then
    vim.cmd("Neotree toggle")
  elseif nvim_tree_exists then
    vim.cmd("NvimTreeToggle")
  else
    vim.cmd("Explore")
  end
end

-- Function to run tests for current file
local function run_tests_for_file()
  local filetype = vim.bo.filetype
  if filetype == "python" then
    vim.cmd("!python -m pytest " .. vim.fn.expand("%"))
  elseif filetype == "javascript" or filetype == "typescript" then
    vim.cmd("!npm test " .. vim.fn.expand("%"))
  elseif filetype == "go" then
    vim.cmd("!go test " .. vim.fn.expand("%"))
  else
    vim.notify("No test runner configured for " .. filetype, vim.log.levels.WARN)
  end
end

-- Function to format code
local function format_code()
  local conform = require("conform")
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end

-- Register functions globally
_G.toggle_file_explorer = toggle_file_explorer
_G.run_tests_for_file = run_tests_for_file
_G.format_code = format_code

-- ===== AUTOCMDS =====

-- Auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx", "*.json", "*.yaml", "*.html", "*.css", "*.scss", "*.md", "*.rust", "*.go", "*.c", "*.cpp" },
  callback = function()
    format_code()
  end,
})

-- Auto save session
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.cmd("SessionSave")
  end,
})

-- ===== HIGHLIGHTING =====

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- ===== CURSOR LINE =====

-- Highlight cursor line only in active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  callback = function()
    vim.wo.cursorline = true
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    vim.wo.cursorline = false
  end,
})

return M
