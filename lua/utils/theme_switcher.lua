-- Theme switching utility
local M = {}

local themes = {
    "tokyonight",
    "catppuccin",
    "kanagawa",
    "rose-pine"
}

function M.switch_theme()
    local current_theme = vim.g.current_theme or 1
    current_theme = (current_theme % #themes) + 1
    vim.g.current_theme = current_theme
    
    local theme_name = themes[current_theme]
    vim.cmd("colorscheme " .. theme_name)
    
    -- Update lualine theme
    require("lualine").setup({
        options = {
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
        },
    })
    
    vim.notify("Switched to theme: " .. theme_name, vim.log.levels.INFO)
end

-- Make function globally available
_G.switch_theme = M.switch_theme

return M
