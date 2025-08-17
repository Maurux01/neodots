-- Theme switcher module
local M = {}

-- List of dark themes to cycle through
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
  "everforest",
  "sonokai",
  "material",
  "monokai",
  "palenight",
}

local current_theme_index = 1
local current_theme = dark_themes[1]

-- Function to change theme
local function change_theme(theme_name)
  if not theme_name then
    return
  end
  
  -- Set the theme
  vim.cmd.colorscheme(theme_name)
  current_theme = theme_name
  
  -- Notify the change
  vim.notify("Theme changed to: " .. theme_name, vim.log.levels.INFO, {
    title = "Theme Switcher",
    icon = "🎨",
  })
end

-- Function to cycle through themes
local function cycle_theme()
  current_theme_index = current_theme_index + 1
  if current_theme_index > #dark_themes then
    current_theme_index = 1
  end
  
  local next_theme = dark_themes[current_theme_index]
  change_theme(next_theme)
end

-- Function to go to previous theme
local function previous_theme()
  current_theme_index = current_theme_index - 1
  if current_theme_index < 1 then
    current_theme_index = #dark_themes
  end
  
  local prev_theme = dark_themes[current_theme_index]
  change_theme(prev_theme)
end

-- Function to select theme with Telescope
local function select_theme()
  local telescope = require("telescope")
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  
  pickers.new({}, {
    prompt_title = "Select Theme",
    finder = finders.new_table({
      results = dark_themes,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          -- Find the index of selected theme
          for i, theme in ipairs(dark_themes) do
            if theme == selection.value then
              current_theme_index = i
              break
            end
          end
          change_theme(selection.value)
        end
      end)
      return true
    end,
  }):find()
end

-- Function to get current theme
local function get_current_theme()
  return current_theme
end

-- Function to get all available themes
local function get_available_themes()
  return dark_themes
end

-- Register functions globally
_G.change_theme = change_theme
_G.cycle_theme = cycle_theme
_G.previous_theme = previous_theme
_G.select_theme = select_theme
_G.get_current_theme = get_current_theme
_G.get_available_themes = get_available_themes

-- Keymaps for theme switching
vim.keymap.set("n", "<leader>tn", "<cmd>lua cycle_theme()<cr>", {
  noremap = true,
  silent = true,
  desc = "Next theme",
})

vim.keymap.set("n", "<leader>tp", "<cmd>lua previous_theme()<cr>", {
  noremap = true,
  silent = true,
  desc = "Previous theme",
})

vim.keymap.set("n", "<leader>ts", "<cmd>lua select_theme()<cr>", {
  noremap = true,
  silent = true,
  desc = "Select theme",
})

vim.keymap.set("n", "<leader>tc", "<cmd>lua vim.notify('Current theme: ' .. get_current_theme(), vim.log.levels.INFO, {title = 'Theme Info', icon = '🎨'})<cr>", {
  noremap = true,
  silent = true,
  desc = "Show current theme",
})

return M
