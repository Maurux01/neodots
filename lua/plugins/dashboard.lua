return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "╔══════════════════════════════════════════════════════════════╗",
        "║                    🚀 Neodots Dashboard                     ║",
        "║                Modern Neovim Configuration                  ║",
        "╚══════════════════════════════════════════════════════════════╝",
        "",
        "  Welcome to Neodots - Your AI-Powered Development Environment",
        "",
      }

      dashboard.section.buttons.val = {
        dashboard.button("n", "📄 New Buffer", ":enew<CR>"),
        dashboard.button("f", "🔍 Find Files", ":Telescope find_files<CR>"),
        dashboard.button("b", "📚 Browse Buffers", ":Telescope buffers<CR>"),
        dashboard.button("g", "🐙 Git Status", ":LazyGit<CR>"),
        dashboard.button("d", "🐳 Docker", ":LazyDocker<CR>"),
        dashboard.button("q", "❌ Quit Neovim", ":qa<CR>"),
      }

      local function get_system_info()
        local info = {}
        local nvim_version = vim.version()
        table.insert(info, string.format("Neovim: %s.%s.%s", nvim_version.major, nvim_version.minor, nvim_version.patch))
        if package.loaded.lazy then
          local lazy_plugins = require("lazy").stats()
          table.insert(info, string.format("Plugins: %d", lazy_plugins.count))
        end
        return info
      end

      dashboard.section.footer.val = {
        "",
        "╭─ System Info ─╮",
        "│ " .. table.concat(get_system_info(), " │ "),
        "╰───────────────╯",
        "",
        "Press <Tab> to cycle through options • Press <Enter> to select",
      }

      alpha.setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          vim.cmd("set laststatus=0")
        end,
      })

      vim.api.nvim_create_autocmd("BufUnload", {
        buffer = 0,
        callback = function()
          vim.cmd("set laststatus=3")
        end,
      })

      vim.cmd.Alpha()
    end,
  },
}