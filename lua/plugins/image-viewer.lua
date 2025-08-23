-- Image viewer configuration
local M = {}

-- Configure image.nvim for better image viewing
local function setup_image_viewer()
    if pcall(require, "image") then
        require("image").setup({
            backend = "kitty",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki" },
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "norg" },
                },
            },
            max_width = nil,
            max_height = nil,
            max_width_window_percentage = nil,
            max_height_window_percentage = 50,
            window_overlap_clear_enabled = false,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            editor_only_render_when_focused = false,
            tmux_show_only_in_active_window = true,
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg" },
        })
    end
end

-- Function to toggle image viewer
local function toggle_image_viewer()
    if pcall(require, "image") then
        local image = require("image")
        -- Toggle image display
        vim.cmd("Image")
    else
        vim.notify("Image viewer not available", vim.log.levels.WARN, {
            title = "Image Viewer",
            icon = " ",
        })
    end
end

-- Function to download remote images
local function download_remote_images()
    if pcall(require, "image") then
        local image = require("image")
        -- Download remote images in current buffer
        vim.cmd("ImageDownload")
    else
        vim.notify("Image viewer not available", vim.log.levels.WARN, {
            title = "Image Viewer",
            icon = " ",
        })
    end
end

-- Register functions globally
_G.toggle_image_viewer = toggle_image_viewer
_G.download_remote_images = download_remote_images

-- Keymaps for image viewer
vim.keymap.set("n", "<leader>iv", "<cmd>lua toggle_image_viewer()<cr>", {
    noremap = true,
    silent = true,
    desc = "Toggle image viewer",
})

vim.keymap.set("n", "<leader>id", "<cmd>lua download_remote_images()<cr>", {
    noremap = true,
    silent = true,
    desc = "Download remote images",
})

-- Initialize image viewer
setup_image_viewer()

return M
