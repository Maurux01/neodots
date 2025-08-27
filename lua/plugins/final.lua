-- Final missing essential plugins
return {
  -- Database integration
  {
    "tpope/vim-dadbod",
    cmd = "DB",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_winwidth = 30
    end,
  },

  -- HTTP client
  {
    "NTBBloodbath/rest.nvim",
    ft = "http",
    config = function()
      require("rest-nvim").setup()
    end,
  },

  -- Git worktree
  {
    "ThePrimeagen/git-worktree.nvim",
    keys = {
      { "<leader>gw", function() require("telescope").extensions.git_worktree.git_worktrees() end, desc = "Git Worktrees" },
      { "<leader>gW", function() require("telescope").extensions.git_worktree.create_git_worktree() end, desc = "Create Worktree" },
    },
    config = function()
      require("git-worktree").setup()
      require("telescope").load_extension("git_worktree")
    end,
  },

  -- Better quickfix
  {
    "stevearc/qf_helper.nvim",
    ft = "qf",
    config = function()
      require("qf_helper").setup()
    end,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      if vim.fn.has("win32") == 1 then
        vim.fn.system("cd app && npm install")
      else
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {}
      }
      vim.g.mkdp_markdown_css = ""
      vim.g.mkdp_highlight_css = ""
      vim.g.mkdp_port = ""
      vim.g.mkdp_page_title = "「${name}」"
      vim.g.mkdp_theme = "dark"
    end,
    config = function()
      -- Add keymaps for markdown preview
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Markdown Preview" })
      vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", { desc = "Markdown Preview Stop" })
      vim.keymap.set("n", "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown Preview Toggle" })
    end,
  },

  -- Better folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    keys = {
      { "zR", function() require("ufo").openAllFolds() end },
      { "zM", function() require("ufo").closeAllFolds() end },
      { "zr", function() require("ufo").openFoldsExceptKinds() end },
      { "zm", function() require("ufo").closeFoldsWith() end },
    },
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      
      require("ufo").setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      })
    end,
  },

  -- Better search
  {
    "kevinhwang91/nvim-hlslens",
    keys = {
      { "n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>" },
      { "N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>" },
      { "*", "*<Cmd>lua require('hlslens').start()<CR>" },
      { "#", "#<Cmd>lua require('hlslens').start()<CR>" },
    },
    config = function()
      require("hlslens").setup()
    end,
  },

  -- Code runner
  {
    "CRAG666/code_runner.nvim",
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
    config = function()
      require("code_runner").setup({
        filetype = {
          java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
          python = "python3 -u",
          typescript = "deno run",
          rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
          c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
          cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
        },
      })
    end,
  },

  -- Better registers
  {
    "AckslD/nvim-neoclip.lua",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("neoclip").setup()
      require("telescope").load_extension("neoclip")
    end,
  },

  -- Undo tree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" } },
  },
}