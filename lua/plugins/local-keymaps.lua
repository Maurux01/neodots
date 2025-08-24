return {
  {
    "local-keymaps", -- A dummy name for this "plugin"
    keys = {
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
  -- Barbar.nvim buffer navigation
  { "<A-,>", "<Cmd>BufferPrevious<CR>", desc = "Buffer previous (barbar)" },
  { "<A-.>", "<Cmd>BufferNext<CR>", desc = "Buffer next (barbar)" },
  { "<A-1>", "<Cmd>BufferGoto 1<CR>", desc = "Go to buffer 1 (barbar)" },
  { "<A-2>", "<Cmd>BufferGoto 2<CR>", desc = "Go to buffer 2 (barbar)" },
  { "<A-3>", "<Cmd>BufferGoto 3<CR>", desc = "Go to buffer 3 (barbar)" },
  { "<A-4>", "<Cmd>BufferGoto 4<CR>", desc = "Go to buffer 4 (barbar)" },
  { "<A-5>", "<Cmd>BufferGoto 5<CR>", desc = "Go to buffer 5 (barbar)" },
  { "<A-6>", "<Cmd>BufferGoto 6<CR>", desc = "Go to buffer 6 (barbar)" },
  { "<A-7>", "<Cmd>BufferGoto 7<CR>", desc = "Go to buffer 7 (barbar)" },
  { "<A-8>", "<Cmd>BufferGoto 8<CR>", desc = "Go to buffer 8 (barbar)" },
  { "<A-9>", "<Cmd>BufferGoto 9<CR>", desc = "Go to buffer 9 (barbar)" },
  { "<A-0>", "<Cmd>BufferLast<CR>", desc = "Go to last buffer (barbar)" },
  { "<A-c>", "<Cmd>BufferClose<CR>", desc = "Close buffer (barbar)" },
  -- Bufferline.nvim navigation
  { "<leader>bp", ":BufferLineCyclePrev<CR>", desc = "BufferLine previous" },
  { "<leader>bn", ":BufferLineCycleNext<CR>", desc = "BufferLine next" },
  { "<leader>bc", ":BufferLinePickClose<CR>", desc = "BufferLine pick close" },
  { "<leader>bb", ":BufferLinePick<CR>", desc = "BufferLine pick buffer" },
    },
  },
}