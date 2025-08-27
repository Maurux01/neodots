-- Enhanced theme management
local M = {}

local themes = {
  {
    name = "tokyonight",
    colorscheme = "tokyonight-night",
    variants = { "night", "storm", "day", "moon" }
  },
  {
    name = "catppuccin",
    colorscheme = "catppuccin",
    variants = { "mocha", "macchiato", "frappe", "latte" }
  },
  {
    name = "kanagawa",
    colorscheme = "kanagawa",
    variants = { "wave", "dragon", "lotus" }
  },
  {
    name = "rose-pine",
    colorscheme = "rose-pine",
    variants = { "main", "moon", "dawn" }
  }
}

local current_theme_index = 1

function M.get_themes()
  return themes
end

function M.switch_theme()
  current_theme_index = current_theme_index % #themes + 1
  local theme = themes[current_theme_index]
  
  pcall(function()
    vim.cmd.colorscheme(theme.colorscheme)
    vim.notify("Switched to: " .. theme.name, vim.log.levels.INFO)
  end)
end

function M.set_theme(theme_name)
  for i, theme in ipairs(themes) do
    if theme.name == theme_name then
      current_theme_index = i
      pcall(function()
        vim.cmd.colorscheme(theme.colorscheme)
        vim.notify("Set theme: " .. theme.name, vim.log.levels.INFO)
      end)
      return
    end
  end
  vim.notify("Theme not found: " .. theme_name, vim.log.levels.ERROR)
end

function M.set_variant(theme_name, variant)
  for _, theme in ipairs(themes) do
    if theme.name == theme_name then
      if theme_name == "tokyonight" then
        vim.cmd.colorscheme("tokyonight-" .. variant)
      elseif theme_name == "catppuccin" then
        vim.g.catppuccin_flavour = variant
        vim.cmd.colorscheme("catppuccin")
      elseif theme_name == "kanagawa" then
        vim.cmd.colorscheme("kanagawa-" .. variant)
      elseif theme_name == "rose-pine" then
        vim.g["rose_pine_variant"] = variant
        vim.cmd.colorscheme("rose-pine")
      end
      vim.notify("Set " .. theme_name .. " variant: " .. variant, vim.log.levels.INFO)
      return
    end
  end
end

function M.telescope_themes()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Select Theme",
    finder = finders.new_table({
      results = themes,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        M.set_theme(selection.value.name)
      end)
      return true
    end,
  }):find()
end

return M