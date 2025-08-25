
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Explicitly list only the properly structured plugins
local plugins = {
  -- Dashboard plugin
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- ASCII Art Header
      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██████╗  ██████╗ ████████╗███████╗",
        "  ████╗  ██║██╔════╝██╔═══██╗██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║  ██║██║   ██║   ██║   ███████╗",
        "  ██║╚██╗██║██╔══╝  ██║   ██║██║  ██║██║   ██║   ██║   ╚════██║",
        "  ██║ ╚████║███████╗╚██████╔╝██████╔╝╚██████╔╝   ██║   ███████║",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝",
        "                                                     ",
        "            🚀 maurux01 Neovim Configuration 🚀        ",
        "                                                     ",
      }

      -- Menu buttons
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", "<cmd>ene <CR>"),
        dashboard.button("SPC f f", "󰈞  Find file"),
        dashboard.button("SPC f g", "󰊄  Live grep"),
        dashboard.button("SPC f r", "  Recent files"),
        dashboard.button("SPC f p", "  Find projects"),
        dashboard.button("c", "  Configuration", "<cmd>edit $MYVIMRC <CR>"),
        dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
        dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
      }

      -- Set menu highlight
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end

      -- Footer with system info
      local function get_system_info()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        
        return {
          "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
          "",
          "🎨 Theme: " .. (vim.g.colors_name or "default"),
          "📅 " .. os.date("%A, %B %d, %Y"),
          "🕐 " .. os.date("%H:%M:%S"),
        }
      end

      dashboard.section.footer.val = get_system_info()
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.section.header.opts.hl = "AlphaHeader"

      -- Layout
      dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      -- Disable folding on alpha buffer
      dashboard.config.opts.noautocmd = true

      alpha.setup(dashboard.config)

      -- Hide statusline in alpha
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          vim.cmd([[
            set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
            set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
          ]])
        end,
      })

      -- Auto open alpha when no files are specified
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local should_skip = false
          if vim.fn.argc() > 0 or vim.fn.line2byte("$") ~= -1 or not vim.o.modifiable then
            should_skip = true
          else
            for _, arg in pairs(vim.v.argv) do
              if arg == "-b" or arg == "-c" or vim.startswith(arg, "+") or arg == "-S" then
                should_skip = true
                break
              end
            end
          end
          if not should_skip then
            require("alpha").start(true)
          end
        end,
      })

      -- Keymaps for dashboard
      vim.keymap.set("n", "<leader>da", "<cmd>Alpha<CR>", { desc = "Open Dashboard" })
    end,
  },

  -- Core settings plugin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  -- General settings plugin
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
      vim.g.maplocalleader = "\\"
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

      -- Always show relative numbers
      vim.opt.relativenumber = true
    end,
  },

  -- Git and Docker plugins
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
    },
  },
  {
    "mgierada/lazydocker.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>gd", "<cmd>LazyDocker<CR>", desc = "LazyDocker" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
    },
  },

  -- Themes
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
        },
      })
    end,
  },
}

-- Setup lazy.nvim with only the properly structured plugins
require("lazy").setup(plugins, {
  checker = {
    enabled = true,
    notify = true,
  },
  change_detection = {
    notify = false,
  },
})
