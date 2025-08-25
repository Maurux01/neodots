return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Keymaps for Copilot
      vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot suggestion"
      })
      vim.keymap.set("i", "<C-;>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot suggestion" })
      vim.keymap.set("i", "<C-,>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })
      vim.keymap.set("i", "<C-.>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
      vim.keymap.set("i", "<C-o>", "<Plug>(copilot-suggest)", { desc = "Trigger Copilot suggestion" })
    end,
  },

  -- Alternative: Codeium (free alternative to Copilot)
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    enabled = false, -- Enable this if you prefer Codeium over Copilot
    config = function()
      vim.g.codeium_disable_bindings = 1
      
      -- Keymaps for Codeium
      vim.keymap.set("i", "<C-j>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true, desc = "Accept Codeium suggestion" })
      
      vim.keymap.set("i", "<C-;>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true, desc = "Clear Codeium suggestion" })
      
      vim.keymap.set("i", "<C-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true, desc = "Previous Codeium suggestion" })
      
      vim.keymap.set("i", "<C-.>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true, desc = "Next Codeium suggestion" })
    end,
  },

  -- Supermaven (another AI coding assistant)
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    enabled = false, -- Enable this if you prefer Supermaven
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-j>",
          clear_suggestion = "<C-;>",
          accept_word = "<C-k>",
        },
        ignore_filetypes = { cpp = true },
        color = {
          suggestion_color = "#ffffff",
          cterm = 244,
        },
        log_level = "info",
        disable_inline_completion = false,
        disable_keymaps = false,
      })
    end,
  },

  -- Tabnine (AI-powered autocompletion)
  {
    "codota/tabnine-nvim",
    build = "./dl_binaries.sh",
    event = "InsertEnter",
    enabled = false, -- Enable this if you prefer Tabnine
    config = function()
      require("tabnine").setup({
        disable_auto_comment = true,
        accept_keymap = "<C-j>",
        dismiss_keymap = "<C-;>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt", "NvimTree" },
        log_file_path = nil,
      })
    end,
  },
}
