return {
  {
    keys = {
      { "<leader>ss", function() require("screenshot").take_screenshot() end, desc = "Take screenshot" },
    },
    config = function()
      local M = {}

      function M.take_screenshot()
        local timestamp = os.date("%Y%m%d_%H%M%S")
        local filename = string.format("screenshot_%s.png", timestamp)
        local output_dir = vim.fn.expand("~/Pictures/screenshots")

        if vim.fn.isdirectory(output_dir) == 0 then
          vim.fn.mkdir(output_dir, "p")
        end

        local full_path = output_dir .. "/" .. filename

        local cmd
        if vim.fn.has("win32") == 1 then
          cmd = string.format('powershell -command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; $bitmap = New-Object System.Drawing.Bitmap $screen.Width, $screen.Height; $graphics = [System.Drawing.Graphics]::FromImage($bitmap); $graphics.CopyFromScreen($screen.Left, $screen.Top, 0, 0, $screen.Size); $bitmap.Save(\'%s\'); $graphics.Dispose(); $bitmap.Dispose()"', full_path)
        elseif vim.fn.has("mac") == 1 then
          cmd = string.format("screencapture -x %s", full_path)
        else
          cmd = string.format("import -window root %s", full_path)
        end

        local result = vim.fn.system(cmd)

        if vim.v.shell_error == 0 then
          vim.notify(string.format("Screenshot saved: %s", full_path), vim.log.levels.INFO)
        else
          vim.notify("Failed to take screenshot: " .. result, vim.log.levels.ERROR)
        end
      end

      -- Make the module accessible for keymaps
      require("lazy").plenary.module.require_on_exported_call("screenshot", M)
    end,
  },
}