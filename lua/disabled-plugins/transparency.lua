local M = {}

local current_transparency = 0.8
local min_transparency = 0.1
local max_transparency = 1.0
local transparency_step = 0.1

function M.set_transparency(alpha)
  current_transparency = math.max(min_transparency, math.min(max_transparency, alpha))
  vim.api.nvim_set_option_value("winblend", math.floor(current_transparency * 100), {})
  vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
  vim.notify(string.format("Transparency: %.1f", current_transparency), vim.log.levels.INFO)
end

function M.increase_transparency()
  M.set_transparency(current_transparency + transparency_step)
end

function M.decrease_transparency()
  M.set_transparency(current_transparency - transparency_step)
end

function M.reset_transparency()
  M.set_transparency(0.8)
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    M.set_transparency(current_transparency)
  end,
})

return M
