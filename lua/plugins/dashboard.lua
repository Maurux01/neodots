return {
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
}
