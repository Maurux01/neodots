-- Key mappings configuration for maurux01's Neovim
-- VS Code-like keybindings with additional productivity enhancements

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key mappings
-- File operations
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts) -- File explorer
map("n", "<leader>ff", ":Telescope find_files<CR>", opts) -- Find files
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts) -- Live grep
map("n", "<leader>fb", ":Telescope buffers<CR>", opts) -- Find buffers
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts) -- Help tags

-- Buffer navigation (VS Code style)
map("n", "<C-p>", ":Telescope find_files<CR>", opts) -- Ctrl+P for files
map("n", "<C-b>", ":NvimTreeToggle<CR>", opts) -- Ctrl+B for explorer
map("n", "<C-,>", ":Telescope buffers<CR>", opts) -- Ctrl+, for buffers

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts) -- Move to left window
map("n", "<C-j>", "<C-w>j", opts) -- Move to down window
map("n", "<C-k>", "<C-w>k", opts) -- Move to up window
map("n", "<C-l>", "<C-w>l", opts) -- Move to right window

-- Window management
map("n", "<leader>sv", ":vsplit<CR>", opts) -- Vertical split
map("n", "<leader>sh", ":split<CR>", opts) -- Horizontal split
map("n", "<leader>se", ":q<CR>", opts) -- Close window
map("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- Maximize window

-- Tab navigation
map("n", "<leader>tn", ":tabnew<CR>", opts) -- New tab
map("n", "<leader>tc", ":tabclose<CR>", opts) -- Close tab
map("n", "<leader>to", ":tabonly<CR>", opts) -- Close other tabs
map("n", "<leader>tm", ":tabmove", opts) -- Move tab

-- LSP keymaps
map("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
map("n", "gD", vim.lsp.buf.declaration, opts) -- Go to declaration
map("n", "gr", vim.lsp.buf.references, opts) -- Find references
map("n", "gi", vim.lsp.buf.implementation, opts) -- Go to implementation
map("n", "K", vim.lsp.buf.hover, opts) -- Hover documentation
map("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- Signature help
map("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename symbol
map("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code actions
map("n", "<leader>f", vim.lsp.buf.format, opts) -- Format code

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, opts) -- Previous diagnostic
map("n", "]d", vim.diagnostic.goto_next, opts) -- Next diagnostic
map("n", "<leader>q", vim.diagnostic.setloclist, opts) -- Open diagnostics

-- Git keymaps
map("n", "<leader>gg", ":LazyGit<CR>", opts) -- LazyGit
map("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", opts) -- Toggle blame
map("n", "<leader>gd", ":Gitsigns diffthis<CR>", opts) -- Git diff
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts) -- Preview hunk

-- Code navigation
map("n", "<leader>o", ":SymbolsOutline<CR>", opts) -- Symbols outline
map("n", "<leader>s", ":Telescope lsp_document_symbols<CR>", opts) -- Document symbols

-- Search and replace
map("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts) -- Search and replace current word
map("n", "<leader>sw", ":Telescope grep_string<CR>", opts) -- Search word under cursor

-- Terminal
map("n", "<leader>tt", ":terminal<CR>", opts) -- Open terminal
map("t", "<Esc>", "<C-\\><C-n>", opts) -- Exit terminal mode

-- Utility mappings
map("n", "<leader>w", ":w<CR>", opts) -- Save file
map("n", "<leader>q", ":q<CR>", opts) -- Quit
map("n", "<leader>Q", ":qa!<CR>", opts) -- Force quit all
map("n", "<leader>x", ":x<CR>", opts) -- Save and quit

-- Toggle options
map("n", "<leader>tn", ":set number!<CR>", opts) -- Toggle line numbers
map("n", "<leader>tr", ":set relativenumber!<CR>", opts) -- Toggle relative numbers
map("n", "<leader>tw", ":set wrap!<CR>", opts) -- Toggle word wrap

-- Plugin specific mappings
map("n", "<leader>cc", ":CommentToggle<CR>", opts) -- Toggle comment
map("n", "<leader>uu", ":UndotreeToggle<CR>", opts) -- Toggle undo tree

-- Which-key like descriptions
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
    map("n", "gD", vim.lsp.buf.declaration, bufopts)
    map("n", "gd", vim.lsp.buf.definition, bufopts)
    map("n", "K", vim.lsp.buf.hover, bufopts)
    map("n", "gi", vim.lsp.buf.implementation, bufopts)
    map("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    map("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    map("n", "gr", vim.lsp.buf.references, bufopts)
    map("n", "<leader>f", function()
      vim.lsp.buf.format { async = true }
    end, bufopts)
  end,
})

print("✅ Key mappings loaded successfully!")
