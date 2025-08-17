-- Enhanced notifications configuration
local M = {}

-- Configure nvim-notify for better notifications
local function setup_notifications()
    if pcall(require, "notify") then
        local notify = require("notify")
        
        -- Override vim.notify to use nvim-notify
        vim.notify = notify
        
        -- Configure notification settings
        notify.setup({
            stages = "fade_in_slide_out",
            timeout = 3000,
            background_colour = "#000000",
            minimum_width = 50,
            icons = {
                ERROR = " ",
                WARN = " ",
                INFO = " ",
                DEBUG = " ",
                TRACE = " ",
            },
        })
    end
end

-- Function to show custom notifications
local function show_notification(message, level, title)
    level = level or vim.log.levels.INFO
    title = title or "Neodots"
    
    local icons = {
        [vim.log.levels.ERROR] = " ",
        [vim.log.levels.WARN] = " ",
        [vim.log.levels.INFO] = " ",
        [vim.log.levels.DEBUG] = " ",
    }
    
    local icon = icons[level] or " "
    
    vim.notify(message, level, {
        title = title,
        icon = icon,
    })
end

-- Register function globally
_G.show_notification = show_notification

-- Initialize notifications
setup_notifications()

return M
