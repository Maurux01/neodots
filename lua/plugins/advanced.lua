return {
  -- ===== TESTING =====
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("% ")) end, desc = "Run test file" },
      { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug test" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
      { "<leader>to", function() require("neotest").output.open({enter = true}) end, desc = "Open test output" },
    },
  },

  -- ===== PROJECT MANAGEMENT =====
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>pp", "<cmd>Telescope project<CR>", desc = "Project picker" },
    },
  },

  -- ===== TROUBLE =====
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Toggle trouble" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace diagnostics" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Document diagnostics" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Location list" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Quickfix list" },
    },
  },

  -- ===== AERIAL =====
  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>aa", "<cmd>AerialToggle! <CR>", desc = "Toggle aerial" },
      { "<leader>an", "<cmd>AerialNext<CR>", desc = "Next aerial" },
      { "<leader>ap", "<cmd>AerialPrev<CR>", desc = "Previous aerial" },
    },
  },

  -- ===== SESSION MANAGEMENT =====
  {
    "folke/persistence.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>ss", "<cmd>SessionSave<CR>", desc = "Save session" },
      { "<leader>sl", "<cmd>SessionLoad<CR>", desc = "Load session" },
      { "<leader>sd", "<cmd>SessionDelete<CR>", desc = "Delete session" },
    },
    config = function()
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          vim.cmd("SessionSave")
        end,
      })
    end,
  },

  -- ===== MARKDOWN PREVIEW =====
  {
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle markdown preview" },
    },
  },

  -- ===== VIMWIKI =====
  {
    "vimwiki/vimwiki",
    event = "VeryLazy",
    keys = {
      { "<leader>ww", "<cmd>VimwikiIndex<CR>", desc = "Vimwiki index" },
      { "<leader>wt", "<cmd>VimwikiTabIndex<CR>", desc = "Vimwiki tab index" },
      { "<leader>ws", "<cmd>VimwikiUISelect<CR>", desc = "Vimwiki UI select" },
    },
  },

  -- ===== EMMET =====
  {
    "mattn/emmet-vim",
    event = "VeryLazy",
    keys = {
      { "i", "<C-y>,", "<cmd>Emmet<CR>", desc = "Emmet expand" },
    },
  },

  -- ===== TERMINAL =====
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    keys = {
      { "t", "<C-\\><C-\">", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
      { "t", "<C-h>", "<cmd>wincmd h<CR>", desc = "Terminal left" },
      { "t", "<C-j>", "<cmd>wincmd j<CR>", desc = "Terminal down" },
      { "t", "<C-k>", "<cmd>wincmd k<CR>", desc = "Terminal up" },
      { "t", "<C-l>", "<cmd>wincmd l<CR>", desc = "Terminal right" },
    },
  },

  -- ===== FILE EXPLORER =====
  {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
      { "<leader>ef", "<cmd>NvimTreeFocus<CR>", desc = "Focus file explorer" },
    },
  },

  -- ===== LEGENDARY =====
  {
    "mrjones2014/legendary.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>:", "<cmd>Legendary<CR>", desc = "Legendary command palette" },
    },
  },

  -- ===== CONFORM =====
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    keys = {
      { "n", "<leader>cf", function() require("conform").format() end, desc = "Format code" },
    },
    config = function()
      require("conform").setup({
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        },
      })
    end,
  },

  -- ===== HIGHLIGHTING =====
  {
    "folke/todo-comments.nvim", -- Example plugin for highlighting
    event = "VeryLazy",
    config = function()
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
        end,
      })
    end,
  },

  
}