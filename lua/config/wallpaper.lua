-- Wallpaper support configuration
-- This file ensures optimal transparency for wallpaper visibility

local M = {}

-- Function to set up wallpaper-friendly environment
function M.setup()
  -- Ensure terminal supports transparency
  if vim.fn.has('termguicolors') == 1 then
    vim.opt.termguicolors = true
  end
  
  -- Set up transparency-friendly options
  vim.opt.pumblend = 10  -- Popup menu transparency
  vim.opt.winblend = 10  -- Floating window transparency
  
  -- Create autocmd to maintain transparency after theme changes
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      -- Small delay to ensure theme is fully loaded
      vim.defer_fn(function()
        require("utils.transparency").apply_transparency()
      end, 50)
    end,
  })
  
  -- Create autocmd for VimEnter to apply transparency on startup
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.defer_fn(function()
        require("utils.transparency").apply_transparency()
      end, 100)
    end,
  })
  
  -- Additional transparency for specific plugins
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function()
      vim.defer_fn(function()
        -- Apply transparency to loaded plugins
        pcall(function()
          -- Alpha dashboard transparency
          vim.api.nvim_set_hl(0, "AlphaHeader", { bg = "none" })
          vim.api.nvim_set_hl(0, "AlphaButtons", { bg = "none" })
          vim.api.nvim_set_hl(0, "AlphaShortcut", { bg = "none" })
          vim.api.nvim_set_hl(0, "AlphaFooter", { bg = "none" })
          
          -- Notify transparency
          vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "none" })
          
          -- Indent blankline transparency
          vim.api.nvim_set_hl(0, "IndentBlanklineChar", { bg = "none" })
          vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { bg = "none" })
          vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { bg = "none" })
        end)
      end, 200)
    end,
  })
end

-- Function to check if terminal supports transparency
function M.check_transparency_support()
  local term = vim.env.TERM or ""
  local term_program = vim.env.TERM_PROGRAM or ""
  
  -- List of terminals known to support transparency
  local supported_terms = {
    "alacritty",
    "kitty", 
    "wezterm",
    "iterm2",
    "windows terminal",
    "hyper"
  }
  
  for _, supported in ipairs(supported_terms) do
    if term:lower():find(supported) or term_program:lower():find(supported) then
      return true
    end
  end
  
  -- Check for Windows Terminal
  if vim.fn.has('win32') == 1 and vim.env.WT_SESSION then
    return true
  end
  
  return false
end

-- Show transparency status
function M.show_status()
  local bg = vim.api.nvim_get_hl_by_name("Normal", true).background
  local status = bg == nil and "enabled" or "disabled"
  local support = M.check_transparency_support() and "supported" or "not detected"
  
  vim.notify(
    string.format("Transparency: %s\nTerminal support: %s", status, support),
    vim.log.levels.INFO,
    { title = "Wallpaper Support" }
  )
end

return M