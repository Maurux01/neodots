return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        file_ignore_patterns = {
          "node_modules",
          ".git",
          ".cache",
          "dist",
          "build",
          "*.pyc",
          "__pycache__",
          ".DS_Store",
        },
        mappings = {
          i = {
            ["<C-n>"] = "cycle_history_next",
            ["<C-p>"] = "cycle_history_prev",
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-c>"] = "close",
            ["<Down>"] = "move_selection_next",
            ["<Up>"] = "move_selection_previous",
            ["<CR>"] = "select_default",
            ["<C-x>"] = "select_horizontal",
            ["<C-v>"] = "select_vertical",
            ["<C-t>"] = "select_tab",
            ["<C-u>"] = "preview_scrolling_up",
            ["<C-d>"] = "preview_scrolling_down",
          },
          n = {
            ["<esc>"] = "close",
            ["<CR>"] = "select_default",
            ["j"] = "move_selection_next",
            ["k"] = "move_selection_previous",
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },
}
