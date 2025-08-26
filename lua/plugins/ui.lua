-- UI and Visual plugins configuration
-- Beautiful themes, statusline, file explorer, and animations

return {
  -- Colorscheme - Multiple dark themes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
        },
      })
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- Additional dark themes
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
        },
      })
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        }
      })
    end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "main", -- auto, main, moon, dawn
        dark_variant = "main",
        disable_background = true,
        styles = {
          italic = true,
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
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
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "tabs",
          separator_style = "slant",
          show_buffer_close_icons = false,
          show_close_icon = false,
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
