-- Startup optimization plugins
return {
  -- Faster startup
  {
    "lewis6991/impatient.nvim",
    priority = 1000,
    config = function()
      require("impatient").enable_profile()
    end,
  },

  -- Better filetype detection
  {
    "nathom/filetype.nvim",
    lazy = false,
    priority = 999,
    config = function()
      require("filetype").setup({
        overrides = {
          extensions = {
            h = "c",
            hpp = "cpp",
            jsx = "javascriptreact",
            tsx = "typescriptreact",
          },
        },
      })
    end,
  },

  -- Startup profiler
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Cache lua modules
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
    priority = 998,
  },
}