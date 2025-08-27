-- Advanced buffer management
return {
  -- Better buffer deletion
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
      { "<leader>bd", "<cmd>Bdelete<cr>", desc = "Delete Buffer" },
      { "<leader>bD", "<cmd>Bwipeout<cr>", desc = "Wipeout Buffer" },
    },
  },

  -- Buffer picker
  {
    "ghillb/cybu.nvim",
    keys = {
      { "<C-Tab>", "<cmd>CybuPrev<cr>", desc = "Previous Buffer" },
      { "<C-S-Tab>", "<cmd>CybuNext<cr>", desc = "Next Buffer" },
      { "<leader>bb", "<cmd>CybuLastusedByTab<cr>", desc = "Buffer Picker" },
    },
    config = function()
      require("cybu").setup({
        position = {
          relative_to = "win",
          anchor = "center",
        },
        style = {
          path = "relative",
          path_abbreviation = "none",
          border = "rounded",
          separator = " ",
          prefix = "…",
          padding = 1,
          hide_buffer_id = true,
          devicons = {
            enabled = true,
            colored = true,
          },
        },
        behavior = {
          mode = {
            default = {
              switch = "immediate",
              view = "paging",
            },
            last_used = {
              switch = "on_close",
              view = "rolling",
            },
          },
        },
        display_time = 1750,
        exclude = {
          "qf",
          "help",
          "man",
          "locate",
          "gitcommit",
          "TelescopePrompt",
          "noice",
        },
      })
    end,
  },

  -- Buffer line enhancements
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    config = function()
      require("scope").setup({
        hooks = {
          pre_tab_leave = function()
            vim.api.nvim_exec_autocmds("User", {pattern = "ScopeTabLeavePre"})
          end,
          post_tab_enter = function()
            vim.api.nvim_exec_autocmds("User", {pattern = "ScopeTabEnterPost"})
          end,
        },
      })
    end,
  },

  -- Smart buffer switching
  {
    "leath-dub/snipe.nvim",
    keys = {
      { "<leader>bs", function() require("snipe").open_buffer_menu() end, desc = "Buffer Menu" },
    },
    config = function()
      require("snipe").setup({
        ui = {
          max_width = -1,
          position = "topleft",
        },
        hints = {
          dictionary = "sadflewcmpghio",
        },
        navigate = {
          cancel_snipe = "q",
          close_buffer = "d",
          change_tag = "C",
        },
        sort = "last",
      })
    end,
  },

  -- Buffer auto-close
  {
    "axkirillov/hbac.nvim",
    event = "VeryLazy",
    config = function()
      require("hbac").setup({
        autoclose = true,
        threshold = 10,
        close_command = function(bufnr)
          vim.api.nvim_buf_delete(bufnr, {})
        end,
        close_buffers_with_windows = false,
      })
    end,
  },

  -- Buffer restore
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
    config = function()
      require("persistence").setup()
    end,
  },
}