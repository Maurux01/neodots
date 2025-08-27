-- UI and Visual plugins configuration
-- Beautiful themes, statusline, file explorer, and animations

return {
  -- Colorscheme - Multiple dark themes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    name = "tokyonight",
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          sidebars = "transparent",
          floats = "transparent",
        },
        on_colors = function(colors)
          colors.bg = "none"
          colors.bg_dark = "none"
          colors.bg_float = "none"
          colors.bg_popup = "none"
          colors.bg_sidebar = "none"
          colors.bg_statusline = "none"
        end,
      })
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- Additional dark themes
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 900,
    cmd = "Catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
        term_colors = true,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
        },
        integrations = {
          telescope = {
            enabled = true,
            style = "nvchad"
          },
          nvimtree = true,
        },
      })
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 900,
    cmd = "Kanagawa",
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true},
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,
        dimInactive = false,
        terminalColors = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
                bg = "none",
                bg_m1 = "none",
                bg_m2 = "none",
                bg_m3 = "none",
                bg_p1 = "none",
                bg_p2 = "none",
              }
            }
          }
        },
        overrides = function(colors)
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
          }
        end,
      })
    end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 900,
    cmd = "Rosepine",
    config = function()
      require("rose-pine").setup({
        variant = "main", -- auto, main, moon, dawn
        dark_variant = "main",
        disable_background = true,
        disable_float_background = true,
        styles = {
          italic = true,
          transparency = true,
        },
        groups = {
          background = "none",
          background_nc = "none",
          panel = "none",
          panel_nc = "none",
          border = "highlight_med",
        },
      })
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>" } },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
        renderer = {
          icons = {
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                arrow_open = "",
                arrow_closed = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
            },
          },
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
      })
    end,
  },

  -- Animated notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        fps = 15,
        level = 2,
        minimum_width = 50,
        render = "minimal",
        stages = "static",
        timeout = 3000,
        top_down = true,
      })
      vim.notify = require("notify")
    end,
  },

  

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
        },
      })
    end,
  },

  -- Rainbow brackets - Colores para brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      })
    end,
  },

  -- Minimalist startup screen (alpha-nvim)
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      
      dashboard.section.header.val = {
        "                                                             ",
        "  ███╗   ██╗███████╗ ██████╗ ██████╗  ██████╗ ████████╗███████╗",
        "  ████╗  ██║██╔════╝██╔═══██╗██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║  ██║██║   ██║   ██║   ███████╗",
        "  ██║╚██╗██║██╔══╝  ██║   ██║██║  ██║██║   ██║   ██║   ╚════██║",
        "  ██║ ╚████║███████╗╚██████╔╝██████╔╝╚██████╔╝   ██║   ███████║",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝",
        "                                                             ",
        "                      by maurux01                           ",
        "                                                             ",
      }
      
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
        dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "  Configuration", ":e " .. vim.fn.stdpath("config") .. "/init.lua <CR>"),
        dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      }
      
      alpha.setup(dashboard.config)
      
      -- Allow pasting in dashboard
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          vim.opt_local.modifiable = true
        end,
      })
    end,
  },

  -- Bufferline (tab-like interface)
  {
    "akinsho/bufferline.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant",
          show_buffer_close_icons = true,
          show_close_icon = false,
          show_tab_indicators = true,
          show_duplicate_prefix = true,
          duplicates_across_groups = true,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
          },
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
          sort_by = "insert_after_current",
        },
        highlights = {
          fill = { bg = "none" },
          background = { bg = "none" },
          tab = { bg = "none" },
          tab_selected = { bg = "none" },
          tab_separator = { bg = "none" },
          tab_separator_selected = { bg = "none" },
          tab_close = { bg = "none" },
          close_button = { bg = "none" },
          close_button_visible = { bg = "none" },
          close_button_selected = { bg = "none" },
          buffer_visible = { bg = "none" },
          buffer_selected = { bg = "none" },
          numbers = { bg = "none" },
          numbers_visible = { bg = "none" },
          numbers_selected = { bg = "none" },
          diagnostic = { bg = "none" },
          diagnostic_visible = { bg = "none" },
          diagnostic_selected = { bg = "none" },
          hint = { bg = "none" },
          hint_visible = { bg = "none" },
          hint_selected = { bg = "none" },
          hint_diagnostic = { bg = "none" },
          hint_diagnostic_visible = { bg = "none" },
          hint_diagnostic_selected = { bg = "none" },
          info = { bg = "none" },
          info_visible = { bg = "none" },
          info_selected = { bg = "none" },
          info_diagnostic = { bg = "none" },
          info_diagnostic_visible = { bg = "none" },
          info_diagnostic_selected = { bg = "none" },
          warning = { bg = "none" },
          warning_visible = { bg = "none" },
          warning_selected = { bg = "none" },
          warning_diagnostic = { bg = "none" },
          warning_diagnostic_visible = { bg = "none" },
          warning_diagnostic_selected = { bg = "none" },
          error = { bg = "none" },
          error_visible = { bg = "none" },
          error_selected = { bg = "none" },
          error_diagnostic = { bg = "none" },
          error_diagnostic_visible = { bg = "none" },
          error_diagnostic_selected = { bg = "none" },
          modified = { bg = "none" },
          modified_visible = { bg = "none" },
          modified_selected = { bg = "none" },
          duplicate_selected = { bg = "none" },
          duplicate_visible = { bg = "none" },
          duplicate = { bg = "none" },
          separator_selected = { bg = "none" },
          separator_visible = { bg = "none" },
          separator = { bg = "none" },
          indicator_visible = { bg = "none" },
          indicator_selected = { bg = "none" },
          pick_selected = { bg = "none" },
          pick_visible = { bg = "none" },
          pick = { bg = "none" },
        },
      })
    end,
  },





  -- Better input/select UI
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          enabled = true,
          border = "rounded",
          relative = "cursor",
        },
        select = {
          enabled = true,
          backend = { "builtin" },
        },
      })
    end,
  },





  -- Discord Rich Presence
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function()
      require("presence").setup({
        auto_update = true,
        neovim_image_text = "Neodots - The best Neovim config",
        main_image = "neovim",
        client_id = "793271441293967371",
        log_level = nil,
        debounce_timeout = 10,
        enable_line_number = false,
        blacklist = {},
        buttons = true,
        file_assets = {},
        show_time = true,
        editing_text = "Editing %s",
        file_explorer_text = "Browsing %s",
        git_commit_text = "Committing changes",
        plugin_manager_text = "Managing plugins",
        reading_text = "Reading %s",
        workspace_text = "Working on %s",
        line_number_text = "Line %s out of %s",
      })
    end,
  },

  -- Tmux integration
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
