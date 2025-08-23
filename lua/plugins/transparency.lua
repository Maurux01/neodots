-- Transparency control module
local M = {}

local current_transparency = 0.8
local min_transparency = 0.1
local max_transparency = 1.0
local transparency_step = 0.1

local function set_transparency(alpha)
  current_transparency = math.max(min_transparency, math.min(max_transparency, alpha))
  
  -- Set transparency for different UI elements
  vim.api.nvim_set_option_value("winblend", math.floor(current_transparency * 100), {})
  
  -- Update colorscheme transparency
  vim.cmd(string.format("hi Normal guibg=NONE ctermbg=NONE"))
  vim.cmd(string.format("hi NonText guibg=NONE ctermbg=NONE"))
  vim.cmd(string.format("hi LineNr guibg=NONE ctermbg=NONE"))
  vim.cmd(string.format("hi SignColumn guibg=NONE ctermbg=NONE"))
  vim.cmd(string.format("hi StatusLine guibg=NONE ctermbg=NONE"))
  vim.cmd(string.format("hi StatusLineNC guibg=NONE ctermbg=NONE"))
  vim.cmd(string.format("hi TabLine guibg=NONE ctermbg=NONE"))
  vim.cmd(string.format("hi TabLineFill guibg=NONE ctermbg=NONE"))
  vim.cmd(string.format("hi TabLineSel guibg=NONE ctermbg=NONE"))
  
  -- Notify current transparency level
  vim.notify(string.format("Transparency: %.1f", current_transparency), vim.log.levels.INFO, {
    title = "Transparency",
    icon = " ",
  })
end

local function increase_transparency()
  set_transparency(current_transparency + transparency_step)
end

local function decrease_transparency()
  set_transparency(current_transparency - transparency_step)
end

local function reset_transparency()
  set_transparency(0.8)
end

-- Register functions globally
_G.increase_transparency = increase_transparency
_G.decrease_transparency = decrease_transparency
_G.reset_transparency = reset_transparency
_G.set_transparency = set_transparency

-- Keymaps for transparency control
vim.keymap.set("n", "<leader>t+", "<cmd>lua increase_transparency()<cr>", {
  noremap = true,
  silent = true,
  desc = "Increase transparency",
})

vim.keymap.set("n", "<leader>t-", "<cmd>lua decrease_transparency()<cr>", {
  noremap = true,
  silent = true,
  desc = "Decrease transparency",
})

vim.keymap.set("n", "<leader>tr", "<cmd>lua reset_transparency()<cr>", {
  noremap = true,
  silent = true,
  desc = "Reset transparency",
})

-- Initialize transparency on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    set_transparency(current_transparency)
  end,
})

return M
