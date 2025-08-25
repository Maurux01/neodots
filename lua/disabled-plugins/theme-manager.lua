local M = {}

local dark_themes = {
  "catppuccin",
  "tokyonight",
  "onedark",
  "gruvbox",
  "nord",
  "dracula",
  "nightfox",
  "carbonfox",
  "kanagawa",
  "rose-pine",
}

local current_theme_index = 1

function M.change_theme(theme_name)
  if not theme_name then
    return
  end
  
  local success, err = pcall(function()
    vim.cmd.colorscheme(theme_name)
  end)
  
  if success then
    vim.notify("Theme changed to: " .. theme_name, vim.log.levels.INFO)
    current_theme_index = vim.tbl_contains(dark_themes, theme_name) and 
      vim.fn.index(dark_themes, theme_name) + 1 or current_theme_index
  else
    vim.notify("Failed to load theme: " .. theme_name .. " - " .. tostring(err), vim.log.levels.ERROR)
  end
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

function M.get_current_theme()
  return vim.g.colors_name or "default"
end

function M.select_theme()
  local has_telescope, telescope = pcall(require, "telescope")
  if not has_telescope then
    vim.notify("Telescope not available", vim.log.levels.ERROR)
    return
  end

  telescope.pickers.new({}, {
    prompt_title = "Select Theme",
    finder = telescope.finders.new_table({ results = dark_themes }),
    sorter = telescope.config.values.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      telescope.actions.select_default:replace(function()
        local selection = telescope.actions.state.get_selected_entry()
        telescope.actions.close(prompt_bufnr)
        if selection then
          M.change_theme(selection.value)
        end
      end)
      return true
    end,
  }):find()
end

-- Set default theme
M.change_theme("catppuccin")

-- Create global commands
vim.api.nvim_create_user_command("ThemeNext", M.cycle_theme, {})
vim.api.nvim_create_user_command("ThemePrev", M.previous_theme, {})
vim.api.nvim_create_user_command("ThemeSelect", M.select_theme, {})
vim.api.nvim_create_user_command("ThemeCurrent", function()
  vim.notify("Current theme: " .. M.get_current_theme(), vim.log.levels.INFO)
end, {})

-- Keymaps
vim.keymap.set("n", "<leader>tn", M.cycle_theme, { desc = "Next theme" })
vim.keymap.set("n", "<leader>tp", M.previous_theme, { desc = "Previous theme" })
vim.keymap.set("n", "<leader>ts", M.select_theme, { desc = "Select theme" })
vim.keymap.set("n", "<leader>tc", function()
  vim.notify("Current theme: " .. M.get_current_theme(), vim.log.levels.INFO)
end, { desc = "Current theme" })

-- Make functions globally available
_G.Themes = M

return M
