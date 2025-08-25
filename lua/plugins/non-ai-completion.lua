return {
  -- Traditional non-AI completion sources
  {
    "hrsh7th/cmp-buffer",
    event = "InsertEnter",
  },
  {
    "hrsh7th/cmp-path", 
    event = "InsertEnter",
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
  },
  {
    "saadparwaiz1/cmp_luasnip",
    event = "InsertEnter",
  },

  -- Enhanced traditional completion plugins
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Context-aware completion based on current file
  {
    "andersevenrud/cmp-tmux",
    event = "InsertEnter",
    enabled = false, -- Optional: Enable if you use tmux
    config = function()
      require("cmp_tmux").setup({
        all_panes = false,
        label = "[Tmux]",
      })
    end,
  },

  -- Git commit message completion
  {
    "davidsierradz/cmp-conventionalcommits",
    event = "InsertEnter",
    config = function()
      require("cmp_conventionalcommits").setup({
        max_commit_char = 100,
      })
    end,
  },

  -- Emoji completion
  {
    "hrsh7th/cmp-emoji",
    event = "InsertEnter",
  },

  -- Calculator completion
  {
    "hrsh7th/cmp-calc",
    event = "InsertEnter",
  },

  -- Spell suggestions completion
  {
    "f3fora/cmp-spell",
    event = "InsertEnter",
    config = function()
      require("cmp_spell").setup({})
    end,
  },

  -- Neovim Lua API completion
  {
    "hrsh7th/cmp-nvim-lua",
    event = "InsertEnter",
  },

  -- Dictionary completion
  {
    "uga-rosa/cmp-dictionary",
    event = "InsertEnter",
    config = function()
      require("cmp_dictionary").setup({
        dic = {
          ["*"] = { "/usr/share/dict/words" },
        },
        exact = 2,
        first_case_insensitive = false,
        document = false,
      })
    end,
  },

  -- SQL completion
  {
    "kdheepak/cmp-latex-symbols",
    event = "InsertEnter",
  },

  -- Latex symbols completion
  {
    "kdheepak/cmp-latex-symbols",
    event = "InsertEnter",
  },
}
