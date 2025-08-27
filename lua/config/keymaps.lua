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
map("n", "<C-q>", ":bdelete<CR>", opts)
map("n", "<leader>n", ":enew<CR>", opts)

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

-- Which-key setup
local function setup_which_key()
  local ok, wk = pcall(require, "which-key")
  if not ok then
    print("Which-key not loaded")
    return
  end

  -- Single mappings
  wk.register({
    ["<leader>e"] = { ":NvimTreeToggle<CR>", " Explorer" },
    ["<leader>w"] = { ":w<CR>", " Save" },
    ["<leader>q"] = { ":q<CR>", " Quit" },
    ["<leader>x"] = { ":x<CR>", " Save & Quit" },
    ["<leader>n"] = { ":enew<CR>", " New File" },
    ["<leader>/"] = { ":lua require('Comment.api').toggle.linewise.current()<CR>", " Comment" },
  })
  
  print("Which-key loaded successfully")

  -- Group mappings
  wk.register({
    ["<leader>f"] = {
      name = " Find/File",
      f = { ":Telescope find_files<CR>", "Files" },
      g = { ":Telescope live_grep<CR>", "Grep" },
      b = { ":Telescope buffers<CR>", "Buffers" },
      r = { ":Telescope oldfiles<CR>", "Recent" },
      h = { ":Telescope help_tags<CR>", "Help" },
      k = { ":Telescope keymaps<CR>", "Keymaps" },
      p = { ":Telescope projects<CR>", "Projects" },
      w = { ":Telescope workspaces<CR>", "Workspaces" },
      t = { ":TodoTelescope<CR>", "TODOs" },
      m = { ":Telescope marks<CR>", "Marks" },
      e = { ":Telescope file_browser<CR>", "File Browser" },
      c = { ":Telescope commands<CR>", "Commands" },
      n = { ":lua require('genghis').createNewFile()<CR>", "New File" },
      d = { ":lua require('genghis').duplicateFile()<CR>", "Duplicate File" },
      R = { ":lua require('genghis').renameFile()<CR>", "Rename File" },
      x = { ":lua require('genghis').chmodx()<CR>", "Make Executable" },
    },
    ["<leader>g"] = {
      name = " Git",
      g = { ":LazyGit<CR>", "LazyGit" },
      b = { ":Gitsigns toggle_current_line_blame<CR>", "Blame" },
      d = { ":Gitsigns diffthis<CR>", "Diff" },
      v = { ":DiffviewOpen<CR>", "Diff View" },
      c = { ":DiffviewClose<CR>", "Close Diff View" },
      s = { ":Gitsigns stage_hunk<CR>", "Stage Hunk" },
      u = { ":Gitsigns undo_stage_hunk<CR>", "Undo Stage" },
      p = { ":Gitsigns preview_hunk<CR>", "Preview Hunk" },
      w = { ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", "Worktrees" },
      W = { ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", "Create Worktree" },
    },
    ["<leader>t"] = {
      name = " Terminal",
      t = { ":ToggleTerm<CR>", "Toggle" },
      f = { ":ToggleTerm direction=float<CR>", "Float" },
      h = { ":ToggleTerm direction=horizontal<CR>", "Horizontal" },
      v = { ":ToggleTerm direction=vertical size=80<CR>", "Vertical" },
      g = { ":lua _LAZYGIT_TOGGLE()<CR>", "LazyGit" },
      n = { ":lua _NODE_TOGGLE()<CR>", "Node" },
      p = { ":lua _PYTHON_TOGGLE()<CR>", "Python" },
    },
    ["<leader>b"] = {
      name = " Buffers",
      b = { ":Telescope buffers<CR>", "List" },
      d = { ":Bdelete<CR>", "Delete" },
      D = { ":Bwipeout<CR>", "Wipeout" },
      n = { ":bnext<CR>", "Next" },
      p = { ":bprevious<CR>", "Previous" },
      f = { ":bfirst<CR>", "First" },
      l = { ":blast<CR>", "Last" },
      c = { ":enew<CR>", "Create" },
      a = { ":%bd|e#<CR>", "Delete All" },
      s = { ":w<CR>", "Save" },
      w = { ":w<CR>:Bdelete<CR>", "Save & Close" },
    },
    ["<leader>w"] = {
      name = " Windows",
      v = { ":vsplit<CR>", "Vertical Split" },
      s = { ":split<CR>", "Horizontal Split" },
      c = { ":close<CR>", "Close" },
      o = { ":only<CR>", "Only" },
      m = { ":WindowsMaximize<CR>", "Maximize" },
      h = { "<C-w>h", "Left" },
      j = { "<C-w>j", "Down" },
      k = { "<C-w>k", "Up" },
      l = { "<C-w>l", "Right" },
      ["="] = { "<C-w>=", "Equal" },
      ["+"] = { ":resize +5<CR>", "Height +" },
      ["-"] = { ":resize -5<CR>", "Height -" },
      [">"] = { ":vertical resize +5<CR>", "Width +" },
      ["<"] = { ":vertical resize -5<CR>", "Width -" },
    },
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
  })
end

-- Setup which-key after plugins are loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = function()
    vim.defer_fn(setup_which_key, 1000)
  end,
})

-- Also try to setup immediately if which-key is available
vim.defer_fn(function()
  setup_which_key()
end, 2000)