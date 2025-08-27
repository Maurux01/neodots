-- Media viewer plugins for PDFs and images
return {
  -- Image viewer
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false,
        tmux_show_only_in_active_window = false,
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
      })
    end,
  },

  -- PDF viewer
  {
    "makerj/vim-pdf",
    ft = "pdf",
  },

  -- Alternative image viewer for Windows
  {
    "samodostal/image.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "m00qek/baleia.nvim",
    },
    config = function()
      require("image").setup({
        render = {
          min_padding = 5,
          show_label = true,
          use_dither = true,
          foreground_color = false,
          background_color = false,
        },
        events = {
          update_on_nvim_resize = true,
        },
      })
    end,
  },

  -- Hologram for terminal image display
  {
    "edluffy/hologram.nvim",
    config = function()
      require("hologram").setup({
        auto_display = true,
      })
    end,
  },
}