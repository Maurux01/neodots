-- Extra productivity plugins
return {
  -- Better statuscolumn with git signs
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { "%s" }, click = "v:lua.ScSa" },
          { text = { "%l", " " }, condition = { true, builtin.not_empty }, click = "v:lua.ScLa" },
          { text = { "%r", " " }, condition = { true, builtin.not_empty }, click = "v:lua.ScRa" },
        },
      })
    end,
  },

  -- Better search/replace
  {
    "windwp/nvim-spectre",
    cmd = "Spectre",
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
    config = function()
      require("spectre").setup()
    end,
  },

  -- Bookmarks
  {
    "MattesGroeger/vim-bookmarks",
    keys = {
      { "mm", "<cmd>BookmarkToggle<cr>", desc = "Toggle bookmark" },
      { "mi", "<cmd>BookmarkAnnotate<cr>", desc = "Annotate bookmark" },
      { "ma", "<cmd>BookmarkShowAll<cr>", desc = "Show all bookmarks" },
      { "mn", "<cmd>BookmarkNext<cr>", desc = "Next bookmark" },
      { "mp", "<cmd>BookmarkPrev<cr>", desc = "Previous bookmark" },
      { "mc", "<cmd>BookmarkClear<cr>", desc = "Clear bookmarks" },
      { "mx", "<cmd>BookmarkClearAll<cr>", desc = "Clear all bookmarks" },
    },
    init = function()
      vim.g.bookmark_sign = "♥"
      vim.g.bookmark_highlight_lines = 1
    end,
  },

  -- Better folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    keys = {
      { "zR", function() require("ufo").openAllFolds() end },
      { "zM", function() require("ufo").closeAllFolds() end },
    },
    config = function()
      require("ufo").setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
      })
    end,
  },

  -- Smooth cursor movement
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    config = function()
      require("smoothcursor").setup({
        type = "default",
        cursor = "",
        texthl = "SmoothCursor",
        linehl = nil,
        fancy = {
          enable = true,
          head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
          body = {
            { cursor = "󰝥", texthl = "SmoothCursorRed" },
            { cursor = "󰝥", texthl = "SmoothCursorOrange" },
            { cursor = "●", texthl = "SmoothCursorYellow" },
            { cursor = "●", texthl = "SmoothCursorGreen" },
            { cursor = "•", texthl = "SmoothCursorAqua" },
            { cursor = ".", texthl = "SmoothCursorBlue" },
            { cursor = ".", texthl = "SmoothCursorPurple" },
          },
          tail = { cursor = nil, texthl = "SmoothCursor" },
        },
        matrix = {
          head = {
            cursor = require("smoothcursor.matrix_chars")[math.random(#require("smoothcursor.matrix_chars"))],
            texthl = {
              "SmoothCursor",
            },
            linehl = nil,
          },
          body = {
            length = 6,
            cursor = require("smoothcursor.matrix_chars")[math.random(#require("smoothcursor.matrix_chars"))],
            texthl = {
              "SmoothCursorGreen",
            },
          },
          tail = {
            cursor = nil,
            texthl = {
              "SmoothCursor",
            },
          },
          unstop = false,
        },
        autostart = true,
        always_redraw = true,
        flyin_effect = nil,
        speed = 25,
        intervals = 35,
        priority = 10,
        timeout = 3000,
        threshold = 3,
        disable_float_win = false,
        enabled_filetypes = nil,
        disabled_filetypes = { "TelescopePrompt", "NvimTree", "alpha" },
      })
    end,
  },
}