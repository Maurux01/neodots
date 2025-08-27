-- Missing essential plugins
return {
  -- Better escape
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        mapping = {"jk", "jj"},
        timeout = 200,
      })
    end,
  },

  -- Auto save
  {
    "pocco81/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    config = function()
      require("auto-save").setup({
        enabled = true,
        execution_message = { message = function() return "" end },
        trigger_events = {"InsertLeave", "TextChanged"},
        debounce_delay = 135,
      })
    end,
  },

  -- Highlight colors
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- Better yank/paste
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    config = function()
      require("yanky").setup({
        ring = { history_length = 100 },
        highlight = { on_put = true, on_yank = true, timer = 500 },
      })
    end,
  },
}