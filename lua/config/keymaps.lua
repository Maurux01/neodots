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

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)
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
map("n", "<leader>th", ":lua require('utils.theme_manager').telescope_themes()<CR>", { desc = "Change Theme" })
map("n", "<leader>tT", ":lua require('utils.theme_manager').switch_theme()<CR>", { desc = "Next Theme" })

-- Group mappings with descriptions
local group_mappings = {
-- Find/File mappings
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Grep" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help" })
map("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Keymaps" })
map("n", "<leader>fp", ":Telescope projects<CR>", { desc = "Projects" })
map("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "TODOs" })
map("n", "<leader>fm", ":Telescope marks<CR>", { desc = "Marks" })
map("n", "<leader>fe", ":Telescope file_browser<CR>", { desc = "File Browser" })
map("n", "<leader>fc", ":Telescope commands<CR>", { desc = "Commands" })
map("n", "<leader>fn", ":lua require('genghis').createNewFile()<CR>", { desc = "New File" })
map("n", "<leader>fd", ":lua require('genghis').duplicateFile()<CR>", { desc = "Duplicate File" })
map("n", "<leader>fR", ":lua require('genghis').renameFile()<CR>", { desc = "Rename File" })
map("n", "<leader>fx", ":lua require('genghis').chmodx()<CR>", { desc = "Make Executable" })
-- Git mappings
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })
map("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Blame" })
map("n", "<leader>gd", ":Gitsigns diffthis<CR>", { desc = "Diff" })
map("n", "<leader>gv", ":DiffviewOpen<CR>", { desc = "Diff View" })
map("n", "<leader>gc", ":DiffviewClose<CR>", { desc = "Close Diff View" })
map("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
map("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", { desc = "Undo Stage" })
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview Hunk" })
map("n", "<leader>gw", ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", { desc = "Worktrees" })
map("n", "<leader>gW", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", { desc = "Create Worktree" })
-- Terminal mappings
map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle" })
map("n", "<leader>tf", ":ToggleTerm direction=float<CR>", { desc = "Float" })
map("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { desc = "Horizontal" })
map("n", "<leader>tv", ":ToggleTerm direction=vertical size=80<CR>", { desc = "Vertical" })
map("n", "<leader>tg", ":lua _LAZYGIT_TOGGLE()<CR>", { desc = "LazyGit" })
map("n", "<leader>tn", ":lua _NODE_TOGGLE()<CR>", { desc = "Node" })
map("n", "<leader>tp", ":lua _PYTHON_TOGGLE()<CR>", { desc = "Python" })

-- Buffer mappings
map("n", "<leader>bb", ":lua require('snipe').open_buffer_menu()<CR>", { desc = "Buffer Menu" })
map("n", "<leader>bl", ":Telescope buffers<CR>", { desc = "List" })
map("n", "<leader>bd", ":Bdelete<CR>", { desc = "Delete" })
map("n", "<leader>bD", ":Bwipeout<CR>", { desc = "Wipeout" })
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous" })
map("n", "<leader>bf", ":bfirst<CR>", { desc = "First" })
map("n", "<leader>bL", ":blast<CR>", { desc = "Last" })
map("n", "<leader>bc", ":enew<CR>", { desc = "Create" })
map("n", "<leader>ba", ":%bd|e#<CR>", { desc = "Delete All" })
map("n", "<leader>bs", ":w<CR>", { desc = "Save" })
map("n", "<leader>bw", ":w<CR>:Bdelete<CR>", { desc = "Save & Close" })
map("n", "<leader>bo", ":lua require('cybu').cycle('next')<CR>", { desc = "Cycle Next" })
map("n", "<leader>bi", ":lua require('cybu').cycle('prev')<CR>", { desc = "Cycle Prev" })
map("n", "<leader>bt", ":tabnew<CR>", { desc = "New Tab" })
map("n", "<leader>bT", ":tabclose<CR>", { desc = "Close Tab" })
-- Window mappings
map("n", "<leader>wv", ":vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>ws", ":split<CR>", { desc = "Horizontal Split" })
map("n", "<leader>wc", ":close<CR>", { desc = "Close" })
map("n", "<leader>wo", ":only<CR>", { desc = "Only" })
map("n", "<leader>wm", ":WindowsMaximize<CR>", { desc = "Maximize" })
map("n", "<leader>wh", "<C-w>h", { desc = "Left" })
map("n", "<leader>wj", "<C-w>j", { desc = "Down" })
map("n", "<leader>wk", "<C-w>k", { desc = "Up" })
map("n", "<leader>wl", "<C-w>l", { desc = "Right" })
map("n", "<leader>w=", "<C-w>=", { desc = "Equal" })
map("n", "<leader>w+", ":resize +5<CR>", { desc = "Height +" })
map("n", "<leader>w-", ":resize -5<CR>", { desc = "Height -" })
map("n", "<leader>w>", ":vertical resize +5<CR>", { desc = "Width +" })
map("n", "<leader>w<", ":vertical resize -5<CR>", { desc = "Width -" })
    ["<leader>l"] = {
      name = " LSP",
      d = { ":lua vim.lsp.buf.definition()<CR>", "Definition" },
      r = { ":lua vim.lsp.buf.references()<CR>", "References" },
      h = { ":lua vim.lsp.buf.hover()<CR>", "Hover" },
      s = { ":lua vim.lsp.buf.signature_help()<CR>", "Signature" },
      n = { ":lua vim.lsp.buf.rename()<CR>", "Rename" },
      a = { ":lua vim.lsp.buf.code_action()<CR>", "Actions" },
      f = { ":lua vim.lsp.buf.format()<CR>", "Format" },
    },
    ["<leader>d"] = {
      name = " Debug",
      b = { ":lua require('dap').toggle_breakpoint()<CR>", "Breakpoint" },
      c = { ":lua require('dap').continue()<CR>", "Continue" },
      i = { ":lua require('dap').step_into()<CR>", "Step Into" },
      o = { ":lua require('dap').step_over()<CR>", "Step Over" },
      u = { ":lua require('dapui').toggle()<CR>", "UI" },
      r = { ":lua require('dap').repl.open()<CR>", "REPL" },
    },
    ["<leader>s"] = {
      name = " Search",
      r = { ":lua require('spectre').open()<CR>", "Replace in Files" },
      w = { ":lua require('spectre').open_visual({select_word=true})<CR>", "Replace Word" },
      f = { ":lua require('spectre').open_file_search()<CR>", "Replace in File" },
      u = { ":Telescope undo<CR>", "Undo History" },
      c = { ":Telescope neoclip<CR>", "Clipboard History" },
      h = { ":lua require('hlslens').start()<CR>", "Highlight Search" },
    },
    ["<leader>v"] = {
      name = " Web Dev",
      s = { ":LiveServerStart<CR>", "Start Server" },
      x = { ":LiveServerStop<CR>", "Stop Server" },
      r = { ":RestNvim<CR>", "Run REST" },
      p = { ":PackageInfoShow<CR>", "Package Info" },
      m = { ":MarkdownPreviewToggle<CR>", "Markdown Preview" },
      d = { ":DBUI<CR>", "Database UI" },
    },
    ["<leader>u"] = {
      name = " UI",
      t = { ":Twilight<CR>", "Twilight" },
      z = { ":ZenMode<CR>", "Zen Mode" },
      n = { ":Noice dismiss<CR>", "Dismiss Notifications" },
      h = { ":Noice history<CR>", "Message History" },
      l = { ":set number!<CR>", "Line Numbers" },
      r = { ":set relativenumber!<CR>", "Relative Numbers" },
      w = { ":set wrap!<CR>", "Word Wrap" },
      c = { ":set cursorline!<CR>", "Cursor Line" },
      b = { ":ToggleTransparency<CR>", "Toggle Transparency" },
      s = { ":lua require('config.wallpaper').show_status()<CR>", "Transparency Status" },
      e = { ":Noice errors<CR>", "Show Errors" },
      m = { ":Noice last<CR>", "Last Message" },
    },
    ["<leader>p"] = {
      name = " Discord Presence",
      e = { ":lua require('presence'):update()<CR>", "Enable" },
      d = { ":lua require('presence'):cancel()<CR>", "Disable" },
      t = { ":lua require('utils.discord').toggle()<CR>", "Toggle" },
      s = { ":lua require('utils.discord').status()<CR>", "Status" },
      u = { ":lua require('utils.discord').update_with_project()<CR>", "Update Project" },
    },
    ["<leader>q"] = {
      name = " Session",
      s = { ":lua require('persistence').load()<CR>", "Restore Session" },
      l = { ":lua require('persistence').load({ last = true })<CR>", "Last Session" },
      d = { ":lua require('persistence').stop()<CR>", "Don't Save Session" },
    },
    ["<leader>c"] = {
      name = " Code",
      c = { ":lua require('Comment.api').toggle.linewise.current()<CR>", "Comment" },
      a = { ":AerialToggle<CR>", "Aerial" },
      o = { ":SymbolsOutline<CR>", "Outline" },
      f = { ":lua require('conform').format()<CR>", "Format" },
      r = { ":RunCode<CR>", "Run Code" },
      R = { ":RunFile<CR>", "Run File" },
      p = { ":RunProject<CR>", "Run Project" },
    },
    ["<leader>r"] = {
      name = " Refactor",
      e = { ":lua require('refactoring').refactor('Extract Function')<CR>", "Extract Function" },
      v = { ":lua require('refactoring').refactor('Extract Variable')<CR>", "Extract Variable" },
      i = { ":lua require('refactoring').refactor('Inline Variable')<CR>", "Inline Variable" },
    },
    ["<leader>m"] = {
      name = " Multicursor",
      a = { "<Plug>(VM-Select-All)<CR>", "Select All" },
      n = { "<Plug>(VM-Find-Under)<CR>", "Find Under" },
      s = { "<Plug>(VM-Start-Regex-Search)<CR>", "Regex Search" },
    },
    ["<leader>h"] = {
      name = " Harpoon",
      a = { ":lua require('harpoon'):list():append()<CR>", "Add" },
      h = { ":lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>", "Menu" },
      ["1"] = { ":lua require('harpoon'):list():select(1)<CR>", "File 1" },
      ["2"] = { ":lua require('harpoon'):list():select(2)<CR>", "File 2" },
      ["3"] = { ":lua require('harpoon'):list():select(3)<CR>", "File 3" },
      ["4"] = { ":lua require('harpoon'):list():select(4)<CR>", "File 4" },
    },
