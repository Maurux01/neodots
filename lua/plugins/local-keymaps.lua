return {
    -- Keybindings for local plugins
    { "<leader>ss", function() require("screenshot").take_screenshot() end, desc = "Take screenshot" },
    { "<leader>tn", function() require("themes").cycle_theme() end, desc = "Next theme" },
    { "<leader>tp", function() require("themes").previous_theme() end, desc = "Previous theme" },
    { "<leader>ts", function() require("themes").select_theme() end, desc = "Select theme" },
    { "<leader>t+", function() require("transparency").increase_transparency() end, desc = "Increase transparency" },
    { "<leader>t-", function() require("transparency").decrease_transparency() end, desc = "Decrease transparency" },
    { "<leader>tr", function() require("transparency").reset_transparency() end, desc = "Reset transparency" },
    { "<leader>tw", function() require("wallpaper").toggle_wallpaper() end, desc = "Toggle wallpaper" },
    { "<leader>ws", function() require("wallpaper").select_wallpaper() end, desc = "Select wallpaper" },
    { "<leader>wr", function() require("wallpaper").random_wallpaper() end, desc = "Random wallpaper" },
    { "<leader>sr", function() require("recording").toggle_recording() end, desc = "Toggle recording" },
    { "<leader>srs", function() require("recording").start_recording() end, desc = "Start recording" },
    { "<leader>srt", function() require("recording").stop_recording() end, desc = "Stop recording" },
  }
