-- Advanced coding features and enhancements
return {
  -- Better code actions
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
    config = function()
      vim.g.code_action_menu_window_border = "single"
    end,
  },

  -- Inline function signatures
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = {
          border = "rounded"
        },
        floating_window = true,
        floating_window_above_cur_line = true,
        fix_pos = false,
        hint_enable = true,
        hint_prefix = "🐼 ",
        hint_scheme = "String",
        hi_parameter = "LspSignatureActiveParameter",
        max_height = 12,
        max_width = 80,
        transparency = nil,
        shadow_blend = 36,
        shadow_guibg = "Black",
        timer_interval = 200,
        toggle_key = nil,
      })
    end,
  },

  -- Better code outline
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    config = function()
      require("outline").setup({
        outline_window = {
          position = "right",
          width = 25,
          relative_width = true,
          auto_close = false,
          auto_jump = false,
          jump_highlight_duration = 300,
          center_on_jump = true,
          show_numbers = false,
          show_relative_numbers = false,
          wrap = false,
          show_cursorline = true,
          hide_cursor = false,
          focus_on_open = false,
          winhl = "",
        },
        outline_items = {
          show_symbol_details = true,
          show_symbol_lineno = false,
          highlight_hovered_item = true,
          auto_set_cursor = true,
          auto_update_events = {
            follow = { "CursorMoved" },
            items = { "InsertLeave", "WinEnter", "BufEnter", "BufWinEnter", "TabEnter", "BufWritePost" },
          },
        },
        guides = {
          enabled = true,
          markers = {
            bottom = "└",
            middle = "├",
            vertical = "│",
          },
        },
        symbol_folding = {
          autofold_depth = 1,
          auto_unfold = {
            hovered = true,
            only = true,
          },
          markers = { "", "" },
        },
        preview_window = {
          auto_preview = false,
          open_hover_on_preview = false,
          width = 50,
          min_width = 50,
          relative_width = true,
          border = "single",
          winhl = "NormalFloat:",
          winblend = 0,
          live = false,
        },
        keymaps = {
          show_help = "?",
          close = { "<Esc>", "q" },
          goto_location = "<Cr>",
          peek_location = "o",
          goto_and_close = "<S-Cr>",
          restore_location = "<C-g>",
          hover_symbol = "<C-space>",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
          fold = "h",
          unfold = "l",
          fold_toggle = "<Tab>",
          fold_toggle_all = "<S-Tab>",
          fold_all = "W",
          unfold_all = "E",
          fold_reset = "R",
          down_and_jump = "<C-j>",
          up_and_jump = "<C-k>",
        },
        providers = {
          priority = { "lsp", "coc", "markdown", "norg" },
          lsp = {
            blacklist_clients = {},
          },
        },
        symbols = {
          filter = {
            default = {
              "String",
              "Number",
              "Boolean",
              "Array",
              "Object",
              "Key",
              "Null",
            },
            markdown = false,
          },
          icon_fetcher = nil,
          icon_source = nil,
        },
      })
    end,
  },

  -- Better search and replace
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    config = function()
      require("grug-far").setup({
        headerMaxWidth = 80,
      })
    end,
  },

  -- Code screenshots
  {
    "mistricky/codesnap.nvim",
    build = "make",
    cmd = { "CodeSnap", "CodeSnapSave" },
    config = function()
      require("codesnap").setup({
        save_path = "~/Pictures/CodeSnaps",
        has_breadcrumbs = true,
        bg_theme = "default",
        watermark = "",
      })
    end,
  },

  -- Better folding
  {
    "anuvyklack/pretty-fold.nvim",
    config = function()
      require("pretty-fold").setup({
        keep_indentation = false,
        fill_char = "━",
        sections = {
          left = {
            "━ ",
            function()
              return string.rep("*", vim.v.foldlevel)
            end,
            " ━┫",
            "content",
            "┣"
          },
          right = {
            "┫ ",
            "number_of_folded_lines",
            ": ",
            "percentage",
            " ┣━━",
          }
        },
        remove_fold_markers = true,
        process_comment_signs = "spaces",
        comment_signs = {
          "//",
          "/*",
          "*",
          "*/",
          "--",
          "#",
          "%",
          '"',
          "'''",
          '"""',
        },
        stop_words = {
          "@brief%s*",
          "@param%s*",
          "@return%s*",
          "@see%s*",
          "@usage%s*",
          "@author%s*",
          "@since%s*",
          "@version%s*",
        },
      })
    end,
  },

  -- Enhanced matchparen
  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  -- Better text alignment
  {
    "godlygeek/tabular",
    cmd = "Tabularize",
  },

  -- Advanced text manipulation
  {
    "tpope/vim-abolish",
    event = "VeryLazy",
  },

  -- Better repeat functionality
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  -- Enhanced undo
  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      {
        "<leader>su",
        "<cmd>Telescope undo<cr>",
        desc = "undo history",
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
  },

  -- Better word motions
  {
    "chaoren/vim-wordmotion",
    event = "VeryLazy",
  },

  -- Highlight word under cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = {
          providers = { "lsp" },
        },
      })
    end,
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup({
        auto_enable = true,
        preview = {
          win_height = 12,
          win_vheight = 12,
          delay_syntax = 80,
          border_chars = { "┃", "━", "┏", "┓", "┗", "┛", "┣", "┫", "┳", "┻" },
        },
      })
    end,
  },
}