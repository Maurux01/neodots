-- Wallpaper management module
local M = {}

local wallpaper_enabled = false
local current_wallpaper = nil
local wallpaper_dir = vim.fn.expand("~/Pictures/wallpapers")

-- Create wallpaper directory if it doesn't exist
if vim.fn.isdirectory(wallpaper_dir) == 0 then
  vim.fn.mkdir(wallpaper_dir, "p")
end

local function set_wallpaper(path)
  if not path or vim.fn.filereadable(path) == 0 then
    vim.notify("Invalid wallpaper path: " .. (path or "nil"), vim.log.levels.ERROR, {
      title = "Wallpaper Error",
      icon = " ",
    })
    return
  end
  
  current_wallpaper = path
  
  -- Set wallpaper based on OS
  local cmd
  if vim.fn.has("win32") == 1 then
    -- Windows
    cmd = string.format('powershell -command "Add-Type -TypeDefinition \'using System.Runtime.InteropServices; public class Wallpaper { [DllImport(\"user32.dll\", CharSet = CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }\'; [Wallpaper]::SystemParametersInfo(0x0014, 0, \'%s\', 0x01 -bor 0x02)"', path)
  elseif vim.fn.has("mac") == 1 then
    -- macOS
    cmd = string.format('osascript -e "tell application \\"System Events\\" to set picture of every desktop to \\"%s\\""', path)
  else
    -- Linux
    cmd = string.format('feh --bg-fill "%s"', path)
  end
  
  local result = vim.fn.system(cmd)
  
  if vim.v.shell_error == 0 then
    vim.notify("Wallpaper set: " .. vim.fn.fnamemodify(path, ":t"), vim.log.levels.INFO, {
      title = "Wallpaper",
      icon = " ",
    })
  else
    vim.notify("Failed to set wallpaper: " .. result, vim.log.levels.ERROR, {
      title = "Wallpaper Error",
      icon = " ",
    })
  end
end

local function select_wallpaper()
  -- Use telescope to select wallpaper
  local telescope = require("telescope")
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  
  -- Get list of image files in wallpaper directory
  local wallpaper_files = {}
  local handle = vim.loop.fs_scandir(wallpaper_dir)
  if handle then
    local name, type
    repeat
      name, type = vim.loop.fs_scandir_next(handle)
      if name and type == "file" then
        local ext = vim.fn.fnamemodify(name, ":e"):lower()
        if ext == "jpg" or ext == "jpeg" or ext == "png" or ext == "bmp" or ext == "gif" or ext == "webp" then
          table.insert(wallpaper_files, name)
        end
      end
    until not name
    vim.loop.fs_scandir_close(handle)
  end
  
  if #wallpaper_files == 0 then
    vim.notify("No wallpaper files found in " .. wallpaper_dir, vim.log.levels.WARN, {
      title = "Wallpaper",
      icon = " ",
    })
    return
  end
  
  pickers.new({}, {
    prompt_title = "Select Wallpaper",
    finder = finders.new_table({
      results = wallpaper_files,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
          path = wallpaper_dir .. "/" .. entry,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          set_wallpaper(selection.path)
        end
      end)
      return true
    end,
  }):find()
end

local function toggle_wallpaper()
  if wallpaper_enabled then
    -- Disable wallpaper (set to solid color or default)
    local cmd
    if vim.fn.has("win32") == 1 then
      cmd = 'powershell -command "Add-Type -TypeDefinition \'using System.Runtime.InteropServices; public class Wallpaper { [DllImport(\"user32.dll\", CharSet = CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }\'; [Wallpaper]::SystemParametersInfo(0x0014, 0, \'\', 0x01 -bor 0x02)"'
    elseif vim.fn.has("mac") == 1 then
      cmd = 'osascript -e "tell application \\"System Events\\" to set picture of every desktop to \\"\\""'
    else
      cmd = 'feh --bg-solid "#2E3440"'
    end
    
    vim.fn.system(cmd)
    wallpaper_enabled = false
    vim.notify("Wallpaper disabled", vim.log.levels.INFO, {
      title = "Wallpaper",
      icon = " ",
    })
  else
    -- Enable wallpaper selection
    select_wallpaper()
    wallpaper_enabled = true
  end
end

local function random_wallpaper()
  local wallpaper_files = {}
  local handle = vim.loop.fs_scandir(wallpaper_dir)
  if handle then
    local name, type
    repeat
      name, type = vim.loop.fs_scandir_next(handle)
      if name and type == "file" then
        local ext = vim.fn.fnamemodify(name, ":e"):lower()
        if ext == "jpg" or ext == "jpeg" or ext == "png" or ext == "bmp" or ext == "gif" or ext == "webp" then
          table.insert(wallpaper_files, wallpaper_dir .. "/" .. name)
        end
      end
    until not name
    vim.loop.fs_scandir_close(handle)
  end
  
  if #wallpaper_files > 0 then
    local random_index = math.random(1, #wallpaper_files)
    set_wallpaper(wallpaper_files[random_index])
    wallpaper_enabled = true
  else
    vim.notify("No wallpaper files found", vim.log.levels.WARN, {
      title = "Wallpaper",
      icon = " ",
    })
  end
end

-- Register functions globally
_G.set_wallpaper = set_wallpaper
_G.select_wallpaper = select_wallpaper
_G.toggle_wallpaper = toggle_wallpaper
_G.random_wallpaper = random_wallpaper

-- Keymaps for wallpaper control
vim.keymap.set("n", "<leader>tw", "<cmd>lua toggle_wallpaper()<cr>", {
  noremap = true,
  silent = true,
  desc = "Toggle wallpaper",
})

vim.keymap.set("n", "<leader>ws", "<cmd>lua select_wallpaper()<cr>", {
  noremap = true,
  silent = true,
  desc = "Select wallpaper",
})

vim.keymap.set("n", "<leader>wr", "<cmd>lua random_wallpaper()<cr>", {
  noremap = true,
  silent = true,
  desc = "Random wallpaper",
})

return M
