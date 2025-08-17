-- Git and Docker integration configuration
local M = {}

-- LazyGit configuration
local function setup_lazygit()
    -- LazyGit se configura automáticamente con el plugin
    -- Aquí puedes agregar configuraciones adicionales si es necesario
end

-- LazyDocker configuration
local function setup_lazydocker()
    -- LazyDocker se configura automáticamente con el plugin
    -- Aquí puedes agregar configuraciones adicionales si es necesario
end

-- Git blame configuration
local function setup_git_blame()
    -- Configurar git blame si se instala el plugin
    if pcall(require, "gitblame") then
        require("gitblame").setup({
            enabled = true,
            message_template = "<author> • <date> • <summary>",
            date_format = "%Y-%m-%d %H:%M",
            virtual_text_column = 80,
        })
    end
end

-- Git signs configuration
local function setup_git_signs()
    require("gitsigns").setup({
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        yadm = {
            enable = false,
        },
    })
end

-- Initialize configurations
setup_lazygit()
setup_lazydocker()
setup_git_blame()
setup_git_signs()

return M
