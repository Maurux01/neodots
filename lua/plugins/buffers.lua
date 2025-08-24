return {
  {
    "romgrk/barbar.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("barbar").setup {
        animation = true,
        auto_hide = false,
        tabpages = true,
        clickable = true,
        icons = {
          buffer_index = true,
          buffer_number = false,
          button = "",
          diagnostics = {
            [1] = { enabled = true, icon = "ﬀ" }, -- ERROR
            [2] = { enabled = false }, -- WARN
            [3] = { enabled = false }, -- INFO
            [4] = { enabled = true }, -- HINT
          },
          gitsigns = {
            added = { enabled = true, icon = "+" },
            changed = { enabled = true, icon = "~" },
            deleted = { enabled = true, icon = "-" },
          },
          filetype = {
            enabled = true,
          },
        },
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        show_buffer_close_icons = true,
        show_close_icon = false,
        separator_style = "slant",
      },
    },
  },
}
