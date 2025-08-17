-- Screenshot functionality
local M = {}

local function take_screenshot()
  local timestamp = os.date("%Y%m%d_%H%M%S")
  local filename = string.format("screenshot_%s.png", timestamp)
  local output_dir = vim.fn.expand("~/Pictures/screenshots")
  
  -- Create directory if it doesn't exist
  if vim.fn.isdirectory(output_dir) == 0 then
    vim.fn.mkdir(output_dir, "p")
  end
  
  local full_path = output_dir .. "/" .. filename
  
  -- Use different screenshot tools based on OS
  local cmd
  if vim.fn.has("win32") == 1 then
    -- Windows
    cmd = string.format('powershell -command "Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; $bitmap = New-Object System.Drawing.Bitmap $screen.Width, $screen.Height; $graphics = [System.Drawing.Graphics]::FromImage($bitmap); $graphics.CopyFromScreen($screen.Left, $screen.Top, 0, 0, $screen.Size); $bitmap.Save(\'%s\'); $graphics.Dispose(); $bitmap.Dispose()"', full_path)
  elseif vim.fn.has("mac") == 1 then
    -- macOS
    cmd = string.format("screencapture -x %s", full_path)
  else
    -- Linux
    cmd = string.format("import -window root %s", full_path)
  end
  
  -- Execute screenshot command
  local result = vim.fn.system(cmd)
  
  if vim.v.shell_error == 0 then
    vim.notify(string.format("Screenshot saved: %s", full_path), vim.log.levels.INFO, {
      title = "Screenshot",
      icon = " ",
    })
  else
    vim.notify("Failed to take screenshot: " .. result, vim.log.levels.ERROR, {
      title = "Screenshot Error",
      icon = " ",
    })
  end
end

-- Register the function globally
_G.take_screenshot = take_screenshot

-- Keymap for taking screenshots
vim.keymap.set("n", "<leader>ss", "<cmd>lua take_screenshot()<cr>", {
  noremap = true,
  silent = true,
  desc = "Take screenshot",
})

return M
