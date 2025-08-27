-- Enhanced command line and code suggestions
return {
  -- Better command line completion
  {
    "hrsh7th/cmp-cmdline",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = "CmdlineEnter",
  },

  -- Command line path completion
  {
    "hrsh7th/cmp-path",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = "InsertEnter",
  },

  -- Buffer completion
  {
    "hrsh7th/cmp-buffer",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = "InsertEnter",
  },

  -- Function signature help
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = "InsertEnter",
  },

  -- Enhanced command palette
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })

      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),
          wilder.vim_search_pipeline()
        ),
      })

      wilder.set_option("renderer", wilder.popupmenu_renderer({
        highlighter = wilder.lua_fzy_highlighter(),
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
        pumblend = 20,
        max_height = 15,
      }))
    end,
  },

  -- Enhanced LSP signature help
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = { border = "rounded" },
        floating_window = true,
        floating_window_above_cur_line = true,
        hint_enable = true,
        hint_prefix = "🔍 ",
        max_height = 12,
        max_width = 80,
        transparency = 10,
      })
    end,
  },

  -- Code action menu
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
    keys = {
      { "<leader>ca", "<cmd>CodeActionMenu<cr>", desc = "Code Actions" },
    },
    config = function()
      vim.g.code_action_menu_window_border = "rounded"
    end,
  },

  -- Better function signatures
  {
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = "InsertEnter",
  },
}