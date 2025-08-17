-- Dashboard configuration with Alpha.nvim
local M = {}

local function setup_dashboard()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Header with Neodots logo
    dashboard.section.header.val = {
        "╔══════════════════════════════════════════════════════════════╗",
        "║                    🚀 Neodots Dashboard                     ║",
        "║                Modern Neovim Configuration                  ║",
        "╚══════════════════════════════════════════════════════════════╝",
        "",
        "  Welcome to Neodots - Your AI-Powered Development Environment",
        "",
    }

    -- Menu buttons
    dashboard.section.buttons.val = {
        dashboard.button("n", "📄 New Buffer", ":enew<CR>"),
        dashboard.button("f", "🔍 Find Files", ":Telescope find_files<CR>"),
        dashboard.button("b", "📚 Browse Buffers", ":Telescope buffers<CR>"),
        dashboard.button("g", "🐙 Git Status", ":LazyGit<CR>"),
        dashboard.button("d", "🐳 Docker", ":LazyDocker<CR>"),
        dashboard.button("a", "🤖 AI Assistant", ":ChatGPT<CR>"),
        dashboard.button("s", "📸 Screenshot", ":lua take_screenshot()<CR>"),
        dashboard.button("r", "🎬 Start Recording", ":lua start_recording()<CR>"),
        dashboard.button("t", "🎭 Transparency", ":lua toggle_transparency()<CR>"),
        dashboard.button("w", "🖼️ Wallpaper", ":lua toggle_wallpaper()<CR>"),
        dashboard.button("h", "🎨 Next Theme", ":lua cycle_theme()<CR>"),
        dashboard.button("q", "❌ Quit Neovim", ":qa<CR>"),
    }

    -- Footer with system info
    local function get_system_info()
        local info = {}
        
        -- Neovim version
        local nvim_version = vim.version()
        table.insert(info, string.format("Neovim: %s.%s.%s", nvim_version.major, nvim_version.minor, nvim_version.patch))
        
        -- Plugin count
        local lazy_plugins = require("lazy").stats()
        table.insert(info, string.format("Plugins: %d", lazy_plugins.count))
        
        -- LSP status
        local lsp_status = "Ready"
        if vim.lsp.get_active_clients() and #vim.lsp.get_active_clients() > 0 then
            lsp_status = string.format("Active: %d", #vim.lsp.get_active_clients())
        end
        table.insert(info, string.format("LSP: %s", lsp_status))
        
        -- Git status
        local git_status = "Not a git repo"
        if vim.fn.isdirectory(".git") == 1 then
            local git_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
            if git_branch and git_branch ~= "" then
                git_status = string.format("Branch: %s", git_branch)
            end
        end
        table.insert(info, string.format("Git: %s", git_status))
        
        return info
    end

    dashboard.section.footer.val = {
        "",
        "╭─ System Info ─╮",
        "│ " .. table.concat(get_system_info(), " │ "),
        "╰───────────────╯",
        "",
        "Press <Tab> to cycle through options • Press <Enter> to select",
    }

    -- Configure dashboard
    alpha.setup(dashboard.opts)

    -- Disable statusline in dashboard
    vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
            vim.cmd("set laststatus=0")
        end,
    })

    vim.api.nvim_create_autocmd("BufUnload", {
        buffer = 0,
        callback = function()
            vim.cmd("set laststatus=3")
        end,
    })
end

-- Function to toggle transparency
local function toggle_transparency()
    if _G.increase_transparency then
        _G.increase_transparency()
    else
        vim.notify("Transparency module not loaded", vim.log.levels.WARN)
    end
end

-- Function to toggle wallpaper
local function toggle_wallpaper()
    if _G.toggle_wallpaper then
        _G.toggle_wallpaper()
    else
        vim.notify("Wallpaper module not loaded", vim.log.levels.WARN)
    end
end

-- Register functions globally
_G.toggle_transparency = toggle_transparency
_G.toggle_wallpaper = toggle_wallpaper

-- Initialize dashboard
setup_dashboard()

return M
