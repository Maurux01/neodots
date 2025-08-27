-- Transparency utility for wallpaper support
local M = {}

-- Toggle transparency function
function M.toggle_transparency()
  local current_bg = vim.api.nvim_get_hl_by_name("Normal", true).background
  
  if current_bg == nil then
    -- Currently transparent, make opaque
    vim.api.nvim_set_hl(0, "Normal", { bg = "#1a1b26" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1a1b26" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1a1b26" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "#1a1b26" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#1a1b26" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "#1a1b26" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#1a1b26" })
    vim.notify("Transparency disabled", vim.log.levels.INFO)
  else
    -- Currently opaque, make transparent
    M.apply_transparency()
    vim.notify("Transparency enabled", vim.log.levels.INFO)
  end
end

-- Apply full transparency
function M.apply_transparency()
  -- Core transparency
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
  vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
  vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
  vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
  vim.api.nvim_set_hl(0, "SpecialKey", { bg = "none" })
  vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
  vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
  
  -- Floating windows
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
  
  -- Telescope
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
  
  -- NvimTree
  vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
  vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "none" })
  
  -- Status and tab lines
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "TabLine", { bg = "none" })
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
end

-- Initialize transparency on startup
function M.init()
  -- Apply transparency after colorscheme loads
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      vim.defer_fn(function()
        M.apply_transparency()
      end, 100)
    end,
  })
  
  -- Create user command
  vim.api.nvim_create_user_command("ToggleTransparency", M.toggle_transparency, {})
end

return M