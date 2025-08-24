return {
  {
    "Neodots/themes", -- Placeholder for local plugin
    dependencies = {
      "catppuccin/nvim",
      "folke/tokyonight.nvim",
      "navarasu/onedark.nvim",
      "ellisonleao/gruvbox.nvim",
      "shaunsingh/nord.nvim",
      "Mofiqul/dracula.nvim",
      "EdenEast/nightfox.nvim",
      "carbon-language/carbon-now-sh.nvim", -- Assuming this is carbonfox
      "rebelot/kanagawa.nvim",
      "rose-pine/neovim",
      "sainnhe/everforest",
      "sainnhe/sonokai",
      "marko-cerovac/material.nvim",
      "monokai/monokai.nvim",
      "drewtempelmeyer/palenight.vim",
    },
    keys = {
      { "<leader>tn", function() require("themes").cycle_theme() end, desc = "Next theme" },
      { "<leader>tp", function() require("themes").previous_theme() end, desc = "Previous theme" },
      { "<leader>ts", function() require("themes").select_theme() end, desc = "Select theme" },
    },
    config = function()
      local M = {}

      local dark_themes = {
        "catppuccin", "tokyonight", "onedark", "gruvbox", "nord", "dracula", "nightfox",
        "carbonfox", "kanagawa", "rose-pine", "everforest", "sonokai", "material", "monokai", "palenight",
      }

      local current_theme_index = 1

      function M.change_theme(theme_name)
        if not theme_name then return end
        vim.cmd.colorscheme(theme_name)
        vim.notify("Theme changed to: " .. theme_name, vim.log.levels.INFO)
      end

      function M.cycle_theme()
        current_theme_index = current_theme_index % #dark_themes + 1
        M.change_theme(dark_themes[current_theme_index])
      end

      function M.previous_theme()
        current_theme_index = current_theme_index - 1
        if current_theme_index < 1 then
          current_theme_index = #dark_themes
        end
        M.change_theme(dark_themes[current_theme_index])
      end

      function M.select_theme()
        require("telescope.pickers").new({}, {
          prompt_title = "Select Theme",
          finder = require("telescope.finders").new_table({ results = dark_themes }),
          sorter = require("telescope.config").values.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
            require("telescope.actions").select_default:replace(function()
              local selection = require("telescope.actions.state").get_selected_entry()
              require("telescope.actions").close(prompt_bufnr)
              if selection then
                M.change_theme(selection.value)
              end
            end)
            return true
          end,
        }):find()
      end

      require("lazy").plenary.module.require_on_exported_call("themes", M)
    end,
  },
}