-- Recording functionality for Neovim
local M = {}

local is_recording = false
local recording_process = nil
local output_file = nil

local function start_recording()
  if is_recording then
    vim.notify("Recording is already in progress", vim.log.levels.WARN, {
      title = "Recording",
      icon = " ",
    })
    return
  end
  
  local timestamp = os.date("%Y%m%d_%H%M%S")
  local filename = string.format("neovim_recording_%s.mp4", timestamp)
  local output_dir = vim.fn.expand("~/Videos/neovim_recordings")
  
  -- Create directory if it doesn't exist
  if vim.fn.isdirectory(output_dir) == 0 then
    vim.fn.mkdir(output_dir, "p")
  end
  
  output_file = output_dir .. "/" .. filename
  
  local cmd
  if vim.fn.has("win32") == 1 then
    -- Windows - using OBS Studio or similar
    cmd = string.format('start "" "C:\\Program Files\\obs-studio\\bin\\64bit\\obs64.exe" --startrecording --output "%s"', output_file)
  elseif vim.fn.has("mac") == 1 then
    -- macOS - using QuickTime Player
    cmd = string.format('osascript -e "tell application \\"QuickTime Player\\" to new screen recording"')
  else
    -- Linux - using ffmpeg
    cmd = string.format('ffmpeg -f x11grab -r 30 -s 1920x1080 -i :0.0 -vcodec libx264 -preset ultrafast -crf 18 "%s"', output_file)
  end
  
  -- Start recording
  recording_process = vim.fn.jobstart(cmd, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify(string.format("Recording saved: %s", output_file), vim.log.levels.INFO, {
          title = "Recording Complete",
          icon = " ",
        })
      else
        vim.notify("Recording failed", vim.log.levels.ERROR, {
          title = "Recording Error",
          icon = " ",
        })
      end
      is_recording = false
      recording_process = nil
    end,
  })
  
  if recording_process > 0 then
    is_recording = true
    vim.notify("Recording started... Press <leader>sr to stop", vim.log.levels.INFO, {
      title = "Recording Started",
      icon = " ",
    })
  else
    vim.notify("Failed to start recording", vim.log.levels.ERROR, {
      title = "Recording Error",
      icon = " ",
    })
  end
end

local function stop_recording()
  if not is_recording then
    vim.notify("No recording in progress", vim.log.levels.WARN, {
      title = "Recording",
      icon = " ",
    })
    return
  end
  
  local cmd
  if vim.fn.has("win32") == 1 then
    -- Windows - stop OBS recording
    cmd = 'taskkill /f /im obs64.exe'
  elseif vim.fn.has("mac") == 1 then
    -- macOS - stop QuickTime recording
    cmd = 'osascript -e "tell application \\"System Events\\" to key code 53"'
  else
    -- Linux - stop ffmpeg recording
    if recording_process then
      vim.fn.jobstop(recording_process)
    end
  end
  
  if cmd then
    vim.fn.system(cmd)
  end
  
  is_recording = false
  recording_process = nil
  
  vim.notify("Recording stopped", vim.log.levels.INFO, {
    title = "Recording Stopped",
    icon = " ",
  })
end

local function toggle_recording()
  if is_recording then
    stop_recording()
  else
    start_recording()
  end
end

-- Register functions globally
_G.start_recording = start_recording
_G.stop_recording = stop_recording
_G.toggle_recording = toggle_recording

-- Keymaps for recording
vim.keymap.set("n", "<leader>sr", "<cmd>lua toggle_recording()<cr>", {
  noremap = true,
  silent = true,
  desc = "Toggle recording",
})

vim.keymap.set("n", "<leader>srs", "<cmd>lua start_recording()<cr>", {
  noremap = true,
  silent = true,
  desc = "Start recording",
})

vim.keymap.set("n", "<leader>srt", "<cmd>lua stop_recording()<cr>", {
  noremap = true,
  silent = true,
  desc = "Stop recording",
})

return M
