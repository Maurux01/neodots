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



-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, opts) -- Previous diagnostic
map("n", "]d", vim.diagnostic.goto_next, opts) -- Next diagnostic
map("n", "<leader>ld", vim.diagnostic.setloclist, opts) -- Open diagnostics

-- Git keymaps
map("n", "<leader>gg", ":LazyGit<CR>", opts) -- LazyGit
map("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", opts) -- Toggle blame
map("n", "<leader>gd", ":Gitsigns diffthis<CR>", opts) -- Git diff
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts) -- Preview hunk

-- Code navigation
map("n", "<leader>o", ":SymbolsOutline<CR>", opts) -- Symbols outline
map("n", "<leader>s", ":Telescope lsp_document_symbols<CR>", opts) -- Document symbols

-- Search and replace
map("n", "<leader>sr", ":%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>", opts) -- Search and replace current word
map("n", "<leader>sw", ":Telescope grep_string<CR>", opts) -- Search word under cursor

-- Terminal (ToggleTerm) - Los keymaps principales están en el plugin
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", opts) -- Floating terminal
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", opts) -- Horizontal terminal
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", opts) -- Vertical terminal
map("t", "<Esc>", "<C-\\><C-n>", opts) -- Exit terminal mode
map("t", "<C-h>", "<C-\\><C-n><C-w>h", opts) -- Navigate from terminal
map("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
map("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
map("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)

-- Utility mappings
map("n", "<leader>w", ":w<CR>", opts) -- Save file
map("n", "<leader>q", ":q<CR>", opts) -- Quit
map("n", "<leader>Q", ":qa!<CR>", opts) -- Force quit all
map("n", "<leader>x", ":x<CR>", opts) -- Save and quit

-- Theme switching (cambio de th a ts para evitar conflicto con terminal)
map("n", "<leader>ts", ":lua switch_theme()<CR>", opts) -- Switch theme

-- Toggle options
map("n", "<leader>tl", ":set number!<CR>", opts) -- Toggle line numbers
map("n", "<leader>tr", ":set relativenumber!<CR>", opts) -- Toggle relative numbers
map("n", "<leader>tw", ":set wrap!<CR>", opts) -- Toggle word wrap


-- Plugin specific mappings
map("n", "<leader>cc", ":CommentToggle<CR>", opts) -- Toggle comment
map("n", "<leader>uu", ":UndotreeToggle<CR>", opts) -- Toggle undo tree

-- Multi-cursor mappings (vim-visual-multi)
-- Ctrl+D para seleccionar palabra bajo cursor (como VS Code)
-- Ctrl+Alt+D para seleccionar todas las ocurrencias
-- Ctrl+Alt+J/K para agregar cursores arriba/abajo

-- Codeium AI completions
-- Ctrl+G para aceptar sugerencia
-- Ctrl+; para siguiente sugerencia
-- Ctrl+, para sugerencia anterior
-- Ctrl+X para limpiar sugerencias

-- Autocompletado mejorado (nvim-cmp)
-- Tab/Shift-Tab para navegar sugerencias
-- Enter para confirmar
-- Ctrl+Space para activar completado manual

-- LSP keymaps are configured in lua/plugins/lsp.lua


