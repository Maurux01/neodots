return {
  -- ===== CORE SETTINGS =====
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  -- ===== GENERAL SETTINGS =====
  {
    "neovim/neovim",
    config = function()
      -- Disable unused built-in plugins
      local disabled_built_ins = {
        "2html_plugin", "getscript", "getscriptPlugin", "gzip", "logiPat", "matchit",
        "matchparen", "netrw", "netrwFileHandlers", "netrwPlugin", "netrwSettings",
        "rrhelper", "spellfile_plugin", "tar", "tarPlugin", "vimball", "vimballPlugin",
        "zip", "zipPlugin", "tutor", "rplugin", "syntax", "synmenu", "optwin",
        "compiler", "bugreport", "ftplugin", "editorconfig"
      }
      for _, plugin in ipairs(disabled_built_ins) do
        vim.g["loaded_" .. plugin] = 1
      end

      -- Set leader keys
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\"

      -- Autocommands
      local augroup = vim.api.nvim_create_augroup("NeodotsConfig", { clear = true })

      -- Highlight on yank
      vim.api.nvim_create_autocmd("TextYankPost", {
        group = augroup,
        callback = function()
          vim.highlight.on_yank({ timeout = 200, on_visual = false })
        end,
      })

      -- Auto resize panes
      vim.api.nvim_create_autocmd("VimResized", {
        group = augroup,
        pattern = "*",
        command = "tabdo wincmd =",
      })

      -- Auto update files when changed on disk
      vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
        group = augroup,
        pattern = "*",
        command = "if mode() ~= 'c' then checktime end",
        nested = true,
      })

      -- Auto close some filetypes with <q>
      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = {
          "qf", "help", "man", "notify", "lspinfo", "spectre_panel",
          "startuptime", "tsplayground", "PlenaryTestPopup",
        },
        callback = function(event)
          vim.bo[event.buf].buflisted = false
          vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        end,
      })
    end,
  },
}