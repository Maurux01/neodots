-- Key mappings configuration for maurux01's Neovim
-- VS Code-like keybindings with additional productivity enhancements

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key mappings
-- File operations
map("n", "<leader>e", function() require("nvim-tree.api").tree.toggle() end, opts) -- File explorer
map("n", "<leader>E", ":NvimTreeToggle<CR>", opts) -- File explorer (alternative)
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fp", ":Telescope projects<CR>", { desc = "Find projects" })
map("n", "<leader>fr", ":Telescope frecency<CR>", { desc = "Recent files" })
map("n", "<leader>fa", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Live grep with args" })

-- Buffer navigation (VS Code style)
map("n", "<C-p>", ":Telescope find_files<CR>", opts) -- Ctrl+P for files
map("n", "<C-b>", function() require("nvim-tree.api").tree.toggle() end, opts) -- Ctrl+B for explorer
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
map("n", "<leader>W", ":wa<CR>", opts) -- Save all files
map("n", "<leader>n", ":enew<CR>", opts) -- New empty buffer
map("n", "<leader>q", ":q<CR>", opts) -- Quit
map("n", "<leader>Q", ":qa!<CR>", opts) -- Force quit all without saving
map("n", "<leader>x", ":x<CR>", opts) -- Save and quit
map("n", "<leader>X", ":xa<CR>", opts) -- Save all and quit

-- Theme switching (cambio de th a ts para evitar conflicto con terminal)
map("n", "<leader>ts", ":lua switch_theme()<CR>", opts) -- Switch theme

-- Toggle options
map("n", "<leader>tl", ":set number!<CR>", opts) -- Toggle line numbers
map("n", "<leader>tr", ":set relativenumber!<CR>", opts) -- Toggle relative numbers
map("n", "<leader>tw", ":set wrap!<CR>", opts) -- Toggle word wrap


-- Plugin specific mappings
map("n", "<leader>cc", ":CommentToggle<CR>", opts) -- Toggle comment
map("n", "<leader>uu", ":UndotreeToggle<CR>", opts) -- Toggle undo tree

-- Hop (jump to any location)
map("n", "<leader>hw", ":HopWord<CR>", opts) -- Jump to word
map("n", "<leader>hl", ":HopLine<CR>", opts) -- Jump to line
map("n", "<leader>hc", ":HopChar1<CR>", opts) -- Jump to character
map("n", "<leader>hp", ":HopPattern<CR>", opts) -- Jump to pattern

-- Trouble (problems panel)
map("n", "<leader>xx", ":Trouble<CR>", opts) -- Toggle trouble
map("n", "<leader>xw", ":Trouble workspace_diagnostics<CR>", opts) -- Workspace diagnostics
map("n", "<leader>xd", ":Trouble document_diagnostics<CR>", opts) -- Document diagnostics
map("n", "<leader>xl", ":Trouble loclist<CR>", opts) -- Location list
map("n", "<leader>xq", ":Trouble quickfix<CR>", opts) -- Quickfix

-- Spectre (global search/replace)
map("n", "<leader>S", ":lua require('spectre').open()<CR>", opts) -- Open Spectre
map("n", "<leader>sw", ":lua require('spectre').open_visual({select_word=true})<CR>", opts) -- Search current word
map("v", "<leader>sw", ":lua require('spectre').open_visual()<CR>", opts) -- Search selection

-- Aerial (symbols outline)
map("n", "<leader>a", ":AerialToggle!<CR>", opts) -- Toggle aerial
map("n", "<leader>an", ":AerialNext<CR>", opts) -- Next symbol
map("n", "<leader>ap", ":AerialPrev<CR>", opts) -- Previous symbol

-- Harpoon (file bookmarks)
map("n", "<leader>ha", ":lua require('harpoon'):list():append()<CR>", opts) -- Add file
map("n", "<leader>hh", ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>", opts) -- Toggle menu
map("n", "<leader>h1", ":lua require('harpoon'):list():select(1)<CR>", opts) -- Go to file 1
map("n", "<leader>h2", ":lua require('harpoon'):list():select(2)<CR>", opts) -- Go to file 2
map("n", "<leader>h3", ":lua require('harpoon'):list():select(3)<CR>", opts) -- Go to file 3
map("n", "<leader>h4", ":lua require('harpoon'):list():select(4)<CR>", opts) -- Go to file 4

-- UFO (code folding)
map("n", "zR", ":lua require('ufo').openAllFolds()<CR>", opts) -- Open all folds
map("n", "zM", ":lua require('ufo').closeAllFolds()<CR>", opts) -- Close all folds
map("n", "zr", ":lua require('ufo').openFoldsExceptKinds()<CR>", opts) -- Open folds except kinds
map("n", "zm", ":lua require('ufo').closeFoldsWith()<CR>", opts) -- Close folds with

-- Twilight (dim inactive code)
map("n", "<leader>td", ":Twilight<CR>", opts) -- Toggle twilight

-- Notification keymaps
map("n", "<leader>nd", ":lua require('notify').dismiss({ silent = true, pending = true })<CR>", opts) -- Dismiss all notifications
map("n", "<leader>nh", ":Telescope notify<CR>", opts) -- Show notification history

-- Session management
map("n", "<leader>ss", ":SessionSave<CR>", opts) -- Save session
map("n", "<leader>sr", ":SessionRestore<CR>", opts) -- Restore session
map("n", "<leader>sd", ":SessionDelete<CR>", opts) -- Delete session

-- Debugging (DAP)
map("n", "<F5>", ":lua require('dap').continue()<CR>", opts) -- Start/Continue
map("n", "<F9>", ":lua require('dap').toggle_breakpoint()<CR>", opts) -- Toggle breakpoint
map("n", "<F10>", ":lua require('dap').step_over()<CR>", opts) -- Step over
map("n", "<F11>", ":lua require('dap').step_into()<CR>", opts) -- Step into
map("n", "<F12>", ":lua require('dap').step_out()<CR>", opts) -- Step out
map("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", opts) -- Toggle breakpoint
map("n", "<leader>dr", ":lua require('dapui').toggle()<CR>", opts) -- Toggle DAP UI

-- Testing (Neotest)
map("n", "<leader>tr", ":lua require('neotest').run.run()<CR>", opts) -- Run nearest test
map("n", "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", opts) -- Run file tests
map("n", "<leader>ts", ":lua require('neotest').summary.toggle()<CR>", opts) -- Toggle test summary
map("n", "<leader>to", ":lua require('neotest').output.open({ enter = true })<CR>", opts) -- Open test output

-- Refactoring
map("v", "<leader>re", ":lua require('refactoring').refactor('Extract Function')<CR>", opts) -- Extract function
map("v", "<leader>rf", ":lua require('refactoring').refactor('Extract Function To File')<CR>", opts) -- Extract to file
map("v", "<leader>rv", ":lua require('refactoring').refactor('Extract Variable')<CR>", opts) -- Extract variable
map("v", "<leader>ri", ":lua require('refactoring').refactor('Inline Variable')<CR>", opts) -- Inline variable

-- Flash navigation (replaces hop)
map("n", "s", ":lua require('flash').jump()<CR>", opts) -- Flash jump
map("n", "S", ":lua require('flash').treesitter()<CR>", opts) -- Flash treesitter
map("o", "r", ":lua require('flash').remote()<CR>", opts) -- Flash remote
map("x", "R", ":lua require('flash').treesitter_search()<CR>", opts) -- Flash treesitter search

-- Spider (better word movement)
map("n", "w", ":lua require('spider').motion('w')<CR>", opts) -- Next word
map("n", "e", ":lua require('spider').motion('e')<CR>", opts) -- End word
map("n", "b", ":lua require('spider').motion('b')<CR>", opts) -- Previous word

-- Substitute
map("n", "s", ":lua require('substitute').operator()<CR>", opts) -- Substitute operator
map("n", "ss", ":lua require('substitute').line()<CR>", opts) -- Substitute line
map("n", "S", ":lua require('substitute').eol()<CR>", opts) -- Substitute to end of line
map("x", "s", ":lua require('substitute').visual()<CR>", opts) -- Substitute visual

-- Project management
map("n", "<leader>fp", ":Telescope projects<CR>", opts) -- Find projects

-- Workspaces
map("n", "<leader>wa", ":WorkspacesAdd<CR>", opts) -- Add workspace
map("n", "<leader>wr", ":WorkspacesRemove<CR>", opts) -- Remove workspace
map("n", "<leader>wl", ":WorkspacesList<CR>", opts) -- List workspaces

-- Navigation
map("n", "<leader>nb", ":Navbuddy<CR>", opts) -- Open navbuddy

-- Enhanced telescope
map("n", "<leader>fa", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts) -- Live grep with args
map("n", "<leader>fr", ":Telescope frecency<CR>", opts) -- Frecency files

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

-- Which-key group descriptions
local wk = require("which-key")
wk.register({
  ["<leader>f"] = { name = "Find" },
  ["<leader>g"] = { name = "Git" },
  ["<leader>l"] = { name = "LSP" },
  ["<leader>t"] = { name = "Terminal/Toggle" },
  ["<leader>s"] = { name = "Search/Session" },
  ["<leader>w"] = { name = "Window/Workspace" },
  ["<leader>h"] = { name = "Harpoon/Hop" },
  ["<leader>x"] = { name = "Trouble" },
  ["<leader>d"] = { name = "Debug" },
  ["<leader>r"] = { name = "Refactor" },
  ["<leader>a"] = { name = "Aerial" },
})

-- Individual key descriptions
wk.register({
  ["<leader>e"] = { "Toggle File Explorer" },
  ["<leader>E"] = { "File Explorer (Alt)" },
  ["<leader>w"] = { "Save File" },
  ["<leader>W"] = { "Save All Files" },
  ["<leader>n"] = { "New Empty Buffer" },
  ["<leader>q"] = { "Quit" },
  ["<leader>Q"] = { "Force Quit All (No Save)" },
  ["<leader>x"] = { "Save and Quit" },
  ["<leader>X"] = { "Save All and Quit" },
  ["<leader>o"] = { "Symbols Outline" },
  ["<leader>S"] = { "Global Search/Replace" },
  ["<leader>cc"] = { "Toggle Comment" },
  ["<leader>uu"] = { "Toggle Undo Tree" },
  ["<leader>td"] = { "Toggle Twilight" },
  ["<leader>nb"] = { "Open Navbuddy" },
})


