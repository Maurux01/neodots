-- Simple keymaps configuration
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Basic navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- VS Code style
map("n", "<C-p>", ":Telescope find_files<CR>", opts)
map("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
map("n", "<F2>", ":NvimTreeToggle<CR>", opts)

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", opts)

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)

-- Which-key setup
local function setup_which_key()
  local ok, wk = pcall(require, "which-key")
  if not ok then
    return
  end

  -- Single mappings
  wk.register({
    ["<leader>e"] = { ":NvimTreeToggle<CR>", " Explorer" },
    ["<leader>w"] = { ":w<CR>", " Save" },
    ["<leader>q"] = { ":q<CR>", " Quit" },
  })

  -- Group mappings
  wk.register({
    ["<leader>f"] = {
      name = " Find",
      f = { ":Telescope find_files<CR>", "Files" },
      g = { ":Telescope live_grep<CR>", "Grep" },
      b = { ":Telescope buffers<CR>", "Buffers" },
      r = { ":Telescope oldfiles<CR>", "Recent" },
    },
    ["<leader>g"] = {
      name = " Git",
      g = { ":LazyGit<CR>", "LazyGit" },
      b = { ":Gitsigns toggle_current_line_blame<CR>", "Blame" },
      d = { ":Gitsigns diffthis<CR>", "Diff" },
    },
    ["<leader>t"] = {
      name = " Terminal",
      t = { ":ToggleTerm<CR>", "Toggle" },
      f = { ":ToggleTerm direction=float<CR>", "Float" },
      h = { ":ToggleTerm direction=horizontal<CR>", "Horizontal" },
      v = { ":ToggleTerm direction=vertical<CR>", "Vertical" },
    },
  })
end

-- Setup which-key after plugins are loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = setup_which_key,
})