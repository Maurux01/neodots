-- Transparency fix for all themes
local M = {}

-- Function to apply transparency to all UI elements
function M.apply_transparency()
  local transparent_groups = {
    "Normal",
    "NormalFloat",
    "NormalNC", 
    "SignColumn",
    "EndOfBuffer",
    "LineNr",
    "CursorLineNr",
    "Folded",
    "NonText",
    "SpecialKey",
    "VertSplit",
    "WinSeparator",
    "FloatBorder",
    "Pmenu",
    "TelescopeNormal",
    "TelescopeBorder", 
    "TelescopePromptNormal",
    "TelescopeResultsNormal",
    "TelescopePreviewNormal",
    "NvimTreeNormal",
    "NvimTreeEndOfBuffer",
    "NvimTreeVertSplit",
    "StatusLine",
    "StatusLineNC",
    "TabLine",
    "TabLineFill",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineTab",
    "BufferLineTabSelected",
    "BufferLineTabSeparator",
    "BufferLineTabSeparatorSelected",
    "BufferLineTabClose",
    "BufferLineCloseButton",
    "BufferLineCloseButtonVisible",
    "BufferLineCloseButtonSelected",
    "BufferLineBufferVisible",
    "BufferLineBufferSelected",
    "BufferLineNumbers",
    "BufferLineNumbersVisible", 
    "BufferLineNumbersSelected",
    "BufferLineDiagnostic",
    "BufferLineDiagnosticVisible",
    "BufferLineDiagnosticSelected",
    "BufferLineHint",
    "BufferLineHintVisible",
    "BufferLineHintSelected",
    "BufferLineHintDiagnostic",
    "BufferLineHintDiagnosticVisible",
    "BufferLineHintDiagnosticSelected",
    "BufferLineInfo",
    "BufferLineInfoVisible",
    "BufferLineInfoSelected",
    "BufferLineInfoDiagnostic",
    "BufferLineInfoDiagnosticVisible",
    "BufferLineInfoDiagnosticSelected",
    "BufferLineWarning",
    "BufferLineWarningVisible",
    "BufferLineWarningSelected",
    "BufferLineWarningDiagnostic",
    "BufferLineWarningDiagnosticVisible",
    "BufferLineWarningDiagnosticSelected",
    "BufferLineError",
    "BufferLineErrorVisible",
    "BufferLineErrorSelected",
    "BufferLineErrorDiagnostic",
    "BufferLineErrorDiagnosticVisible",
    "BufferLineErrorDiagnosticSelected",
    "BufferLineModified",
    "BufferLineModifiedVisible",
    "BufferLineModifiedSelected",
    "BufferLineDuplicateSelected",
    "BufferLineDuplicateVisible",
    "BufferLineDuplicate",
    "BufferLineSeparatorSelected",
    "BufferLineSeparatorVisible",
    "BufferLineSeparator",
    "BufferLineIndicatorVisible",
    "BufferLineIndicatorSelected",
    "BufferLinePickSelected",
    "BufferLinePickVisible",
    "BufferLinePick",
  }

  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
  
  -- Special case for PmenuSel to keep some visibility
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3e4451" })
end

-- Setup transparency with multiple triggers
function M.setup()
  -- Apply immediately
  M.apply_transparency()
  
  -- Apply on various events
  vim.api.nvim_create_autocmd({ 
    "ColorScheme", 
    "VimEnter", 
    "UIEnter",
    "BufWinEnter",
    "WinEnter"
  }, {
    pattern = "*",
    callback = M.apply_transparency,
  })
  
  -- Apply with delay to ensure it sticks
  vim.defer_fn(M.apply_transparency, 50)
  vim.defer_fn(M.apply_transparency, 200)
  vim.defer_fn(M.apply_transparency, 500)
  
  -- Create command to manually apply transparency
  vim.api.nvim_create_user_command('FixTransparency', function()
    M.apply_transparency()
    vim.notify("Transparency fixed!", vim.log.levels.INFO)
  end, { desc = 'Fix transparency issues' })
end

return M