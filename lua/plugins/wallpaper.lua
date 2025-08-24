return {
  {
    "Neodots/wallpaper", -- Placeholder for local plugin
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>tw", function() require("wallpaper").toggle_wallpaper() end, desc = "Toggle wallpaper" },
      { "<leader>ws", function() require("wallpaper").select_wallpaper() end, desc = "Select wallpaper" },
      { "<leader>wr", function() require("wallpaper").random_wallpaper() end, desc = "Random wallpaper" },
    },
    config = function()
      local M = {}

      local wallpaper_enabled = false
      local wallpaper_dir = vim.fn.expand("~/Pictures/wallpapers")

      if vim.fn.isdirectory(wallpaper_dir) == 0 then
        vim.fn.mkdir(wallpaper_dir, "p")
      end

      function M.set_wallpaper(path)
        if not path or vim.fn.filereadable(path) == 0 then
          vim.notify("Invalid wallpaper path: " .. (path or "nil"), vim.log.levels.ERROR)
          return
        end

        local cmd
        if vim.fn.has("win32") == 1 then
          cmd = string.format('powershell -command "Add-Type -TypeDefinition \'using System.Runtime.InteropServices; public class Wallpaper { [DllImport(\"user32.dll\", CharSet = CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }\'; [Wallpaper]::SystemParametersInfo(0x0014, 0, \'%s\', 0x01 -bor 0x02)"', path)
        elseif vim.fn.has("mac") == 1 then
          cmd = string.format('osascript -e "tell application \"System Events\" to set picture of every desktop to \"%s\""', path)
        else
          cmd = string.format('feh --bg-fill "%s"', path)
        end

        local result = vim.fn.system(cmd)
        if vim.v.shell_error == 0 then
          vim.notify("Wallpaper set: " .. vim.fn.fnamemodify(path, ":t"), vim.log.levels.INFO)
        else
          vim.notify("Failed to set wallpaper: " .. result, vim.log.levels.ERROR)
        end
      end

      function M.select_wallpaper()
        local wallpaper_files = {}
        local handle = vim.loop.fs_scandir(wallpaper_dir)
        if handle then
          local name, type
          repeat
            name, type = vim.loop.fs_scandir_next(handle)
            if name and type == "file" then
              local ext = vim.fn.fnamemodify(name, ":e"):lower()
              if ext == "jpg" or ext == "jpeg" or ext == "png" then
                table.insert(wallpaper_files, wallpaper_dir .. "/" .. name)
              end
            end
          until not name
          vim.loop.fs_scandir_close(handle)
        end

        if #wallpaper_files == 0 then
          vim.notify("No wallpapers found in " .. wallpaper_dir, vim.log.levels.WARN)
          return
        end

        require("telescope.pickers").new({}, {
          prompt_title = "Select Wallpaper",
          finder = require("telescope.finders").new_table({ results = wallpaper_files }),
          sorter = require("telescope.config").values.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
            require("telescope.actions").select_default:replace(function()
              local selection = require("telescope.actions.state").get_selected_entry()
              require("telescope.actions").close(prompt_bufnr)
              if selection then
                M.set_wallpaper(selection.value)
                wallpaper_enabled = true
              end
            end)
            return true
          end,
        }):find()
      end

      function M.toggle_wallpaper()
        if wallpaper_enabled then
          local cmd
          if vim.fn.has("win32") == 1 then
            cmd = 'powershell -command "Add-Type -TypeDefinition \'using System.Runtime.InteropServices; public class Wallpaper { [DllImport(\"user32.dll\", CharSet = CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }\'; [Wallpaper]::SystemParametersInfo(0x0014, 0, \'\', 0x01 -bor 0x02)"'
          elseif vim.fn.has("mac") == 1 then
            cmd = 'osascript -e "tell application \"System Events\" to set picture of every desktop to \"\""'
          else
            cmd = 'feh --bg-solid "#2E3440"'
          end
          vim.fn.system(cmd)
          wallpaper_enabled = false
          vim.notify("Wallpaper disabled", vim.log.levels.INFO)
        else
          M.select_wallpaper()
        end
      end

      function M.random_wallpaper()
        local wallpaper_files = {}
        local handle = vim.loop.fs_scandir(wallpaper_dir)
        if handle then
          local name, type
          repeat
            name, type = vim.loop.fs_scandir_next(handle)
            if name and type == "file" then
              local ext = vim.fn.fnamemodify(name, ":e"):lower()
              if ext == "jpg" or ext == "jpeg" or ext == "png" then
                table.insert(wallpaper_files, wallpaper_dir .. "/" .. name)
              end
            end
          until not name
          vim.loop.fs_scandir_close(handle)
        end

        if #wallpaper_files > 0 then
          local random_index = math.random(1, #wallpaper_files)
          M.set_wallpaper(wallpaper_files[random_index])
          wallpaper_enabled = true
        else
          vim.notify("No wallpapers found", vim.log.levels.WARN)
        end
      end

      require("lazy").plenary.module.require_on_exported_call("wallpaper", M)
    end,
  },
}