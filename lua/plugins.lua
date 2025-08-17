-- Plugin configuration for Neovim
return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          aerial = true,
          alpha = true,
          cmp = true,
          gitsigns = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          mason = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          notify = true,
          neotree = true,
          treesitter = true,
          which_key = true,
        },
      })
    end,
  },

  -- Additional dark themes
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = true,
      terminal_colors = true,
    },
  },

  {
    "navarasu/onedark.nvim",
    lazy = true,
    opts = {
      style = "dark",
      transparent = true,
    },
  },

  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = {
      transparent_mode = true,
    },
  },

  {
    "shaunsingh/nord.nvim",
    lazy = true,
  },

  {
    "Mofiqul/dracula.nvim",
    lazy = true,
  },

  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    opts = {
      options = {
        transparent = true,
      },
    },
  },

  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    name = "carbonfox",
    opts = {
      options = {
        transparent = true,
      },
    },
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      transparent = true,
    },
  },

  {
    "rose-pine/neovim",
    lazy = true,
    name = "rose-pine",
    opts = {
      variant = "moon",
      transparent_background = true,
    },
  },

  {
    "sainnhe/everforest",
    lazy = true,
    opts = {
      transparent_background = true,
    },
  },

  {
    "sainnhe/sonokai",
    lazy = true,
    opts = {
      transparent_background = true,
    },
  },

  {
    "marko-cerovac/material.nvim",
    lazy = true,
    opts = {
      transparent_background = true,
    },
  },

  {
    "tanvirtin/monokai.nvim",
    lazy = true,
  },

  {
    "drewtempelmeyer/palenight.vim",
    lazy = true,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    config = function()
      require("lsp")
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("completion")
    end,
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("treesitter")
    end,
  },

  -- Telescope for fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function()
      require("telescope")
    end,
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- LazyGit
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- LazyDocker
  {
    "lazytanuki/nvim-docker",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- AI Chat integration
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "echo $OPENAI_API_KEY",
        yank_register = "+",
        edit_with_instructions = {
          diff = false,
          keymaps = {
            accept = "<C-y>",
            toggle_diff = "<C-d>",
            toggle_settings = "<C-o>",
            cycle_windows = "<Tab>",
            use_output_as_input = "<C-i>",
          },
        },
        chat = {
          welcome_message = "Hello! I'm your AI programming assistant. How can I help you today?",
          loading_text = "Loading, please wait ...",
          question_sign = "❓",
          answer_sign = "🤖",
          max_line_length = 120,
          sessions_window = {
            border = {
              style = "rounded",
              text = {
                top = " Sessions ",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
          },
          keymaps = {
            close = { "<C-c>" },
            yank_last = "<C-y>",
            yank_last_code = "<C-k>",
            scroll_up = "<C-u>",
            scroll_down = "<C-d>",
            toggle_settings = "<C-o>",
            new_session = "<C-n>",
            cycle_windows = "<Tab>",
            select_session = "<Space>",
            rename_session = "r",
            delete_session = "d",
          },
        },
        popup_layout = {
          default = "center",
          center = {
            width = "80%",
            height = "80%",
          },
          right = {
            width = "30%",
            width_settings_open = "50%",
          },
        },
        popup_window = {
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top = " ChatGPT ",
            },
          },
          win_options = {
            wrap = true,
            linebreak = true,
            foldcolumn = "1",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
          buf_options = {
            filetype = "markdown",
          },
        },
        system_window = {
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top = " SYSTEM ",
            },
          },
          win_options = {
            wrap = true,
            linebreak = true,
            foldcolumn = "1",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        popup_input = {
          prompt = " ",
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top_align = "center",
              top = " Prompt ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
          submit = "<C-Enter>",
          submit_n = "<Enter>",
          max_visible_lines = 20,
        },
        settings_window = {
          border = {
            style = "rounded",
            text = {
              top = " Settings ",
            },
          },
        },
        openai_params = {
          model = "gpt-3.5-turbo",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 300,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        openai_edit_params = {
          model = "code-davinci-edit-001",
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        actions_paths = {},
        show_quickfixes_cmd = "Trouble quickfix",
        predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
      })
    end,
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          position = "left",
          width = 30,
        },
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- Enhanced auto pairs with better bracket matching
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
    end,
  },

  -- Enhanced comments with better formatting
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = "<leader>cc",
          block = "<leader>cb",
        },
        opleader = {
          line = "<leader>c",
          block = "<leader>b",
        },
        extra = {
          above = "<leader>cO",
          below = "<leader>co",
          eol = "<leader>cA",
        },
        mappings = {
          basic = true,
          extra = true,
          extended = false,
        },
        pre_hook = nil,
        post_hook = nil,
      })
    end,
  },

  -- Rainbow brackets for better visual matching
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          tsx = "rainbow-parens",
          javascript = "rainbow-parens",
          typescript = "rainbow-parens",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- Auto tag closing for HTML/JSX/XML
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        filetypes = {
          "html", "javascript", "typescript", "javascriptreact", "typescriptreact",
          "svelte", "vue", "tsx", "jsx", "rescript", "xml", "php", "markdown",
          "astro", "glimmer", "handlebars", "hbs"
        },
        skip_tags = {
          "area", "base", "br", "col", "command", "embed", "hr", "img", "input",
          "keygen", "link", "meta", "param", "source", "track", "wbr", "menuitem"
        },
      })
    end,
  },

  -- Which key for keymaps
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup()
    end,
  },

  -- Buffer line
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant",
          always_show_bufferline = false,
          show_buffer_close_icons = true,
          show_close_icon = false,
          color_icons = true,
        },
      })
    end,
  },

  -- Image viewer
  {
    "3rd/image.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" },
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false,
        tmux_show_only_in_active_window = true,
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
      })
    end,
  },

  -- Screenshot functionality
  {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.25,
        inactive = true,
      },
      context = 10,
      treesitter = true,
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {},
    },
  },

  -- Recording functionality
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    config = function()
      require("sniprun").setup({
        selected_interpreters = {},
        repl_enable = {},
        repl_disable = {},
        interpreter_options = {},
        display = {
          "Classic",
          "VirtualTextOk",
          "VirtualTextErr",
        },
        live_display = { "VirtualTextOk", "VirtualTextErr" },
        display_options = {
          terminal_width = 45,
          notification_timeout = 5,
        },
        show_no_output = {
          "Classic",
          "TempFloatingWindow",
        },
        sniprun_config = {
          interpreter_options = {
            GFM_original = {
              use_on_filetypes = { "markdown.pandoc" },
            },
          },
        },
      })
    end,
  },

  -- Transparency and wallpaper
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        groups = {
          "Normal",
          "NormalNC",
          "Comment",
          "Constant",
          "Special",
          "Identifier",
          "Statement",
          "PreProc",
          "Type",
          "Underlined",
          "Todo",
          "String",
          "Function",
          "Conditional",
          "Repeat",
          "Operator",
          "Structure",
          "LineNr",
          "NonText",
          "SignColumn",
          "CursorLine",
          "CursorLineNr",
          "StatusLine",
          "StatusLineNC",
          "EndOfBuffer",
        },
        extra_groups = {},
        exclude_groups = {},
      })
    end,
  },

  -- Auto save
  {
    "pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enabled = true,
        execution_message = {
          enabled = true,
          message = function()
            return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
          end,
          dim = 0.18,
          cleaning_interval = 1250,
        },
        trigger_events = {
          immediate_save = { "BufLeave", "FocusLost" },
          defer_save = { "InsertLeave", "TextChanged" },
          cancel_defered_save = { "InsertEnter" },
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135,
        callbacks = {
          before_saving = function()
          end,
          after_saving = function()
          end,
        },
      })
    end,
  },

  -- Better search
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  -- Better terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
  },

  -- Enhanced notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        stages = "fade_in_slide_out",
        timeout = 3000,
        background_colour = "#000000",
        minimum_width = 50,
        icons = {
          ERROR = " ",
          WARN = " ",
          INFO = " ",
          DEBUG = " ",
          TRACE = " ",
        },
      })
    end,
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard")
    end,
  },

  -- Enhanced syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 0,
        trim_scope = "outer",
        patterns = {
          default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "switch",
            "case",
          },
        },
        exact_patterns = {},
        zindex = 20,
        mode = "cursor",
        separator = nil,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        max_show_lines = 0,
        trim_indent = false,
        line_num_hl = "LineNr",
        before_context_hl = "Comment",
        after_context_hl = "Comment",
        before_context_string_hl = "String",
        after_context_string_hl = "String",
        before_context_char_hl = "Comment",
        after_context_char_hl = "Comment",
        before_context_number_hl = "Number",
        after_context_number_hl = "Number",
        before_context_function_hl = "Function",
        after_context_function_hl = "Function",
        before_context_class_hl = "Type",
        after_context_class_hl = "Type",
        before_context_constant_hl = "Constant",
        after_context_constant_hl = "Constant",
        before_context_type_hl = "Type",
        after_context_type_hl = "Type",
        before_context_variable_hl = "Variable",
        after_context_variable_hl = "Variable",
        before_context_namespace_hl = "Include",
        after_context_namespace_hl = "Include",
        before_context_event_hl = "Special",
        after_context_event_hl = "Special",
        before_context_property_hl = "Property",
        after_context_property_hl = "Property",
        before_context_field_hl = "Field",
        after_context_field_hl = "Field",
        before_context_section_hl = "Special",
        after_context_section_hl = "Special",
        before_context_literal_hl = "Literal",
        after_context_literal_hl = "Literal",
        before_context_conditional_hl = "Conditional",
        after_context_conditional_hl = "Conditional",
        before_context_repeat_hl = "Repeat",
        after_context_repeat_hl = "Repeat",
        before_context_operator_hl = "Operator",
        after_context_operator_hl = "Operator",
        before_context_keyword_hl = "Keyword",
        after_context_keyword_hl = "Keyword",
        before_context_exception_hl = "Exception",
        after_context_exception_hl = "Exception",
        before_context_preproc_hl = "PreProc",
        after_context_preproc_hl = "PreProc",
        before_context_storage_hl = "StorageClass",
        after_context_storage_hl = "StorageClass",
        before_context_structure_hl = "Structure",
        after_context_structure_hl = "Structure",
        before_context_typedef_hl = "Typedef",
        after_context_typedef_hl = "Typedef",
        before_context_special_hl = "Special",
        after_context_special_hl = "Special",
        before_context_tag_hl = "Tag",
        after_context_tag_hl = "Tag",
        before_context_delimiter_hl = "Delimiter",
        after_context_delimiter_hl = "Delimiter",
        before_context_specialchar_hl = "SpecialChar",
        after_context_specialchar_hl = "SpecialChar",
        before_context_debug_hl = "Debug",
        after_context_debug_hl = "Debug",
        before_context_underlined_hl = "Underlined",
        after_context_underlined_hl = "Underlined",
        before_context_ignore_hl = "Ignore",
        after_context_ignore_hl = "Ignore",
        before_context_error_hl = "Error",
        after_context_error_hl = "Error",
        before_context_todo_hl = "Todo",
        after_context_todo_hl = "Todo",
      })
    end,
  },

  -- Better color highlighting
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        enable_named_colors = true,
        enable_tailwind = true,
      })
    end,
  },

  -- ===== DEBUGGING & DEVELOPMENT =====

  -- Debugger
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require("dap")
    end,
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.33 },
              { id = "breakpoints", size = 0.17 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 0.33,
            position = "right",
          },
          {
            elements = {
              { id = "repl", size = 0.45 },
              { id = "console", size = 0.55 },
            },
            size = 0.27,
            position = "bottom",
          },
        },
      })
    end,
  },

  -- DAP Virtual Text
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },

  -- ===== CODE ANALYSIS & FORMATTING =====

  -- Trouble (Quickfix/Location List)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        icons = false,
        fold_open = "v",
        fold_closed = ">",
        indent_lines = false,
        signs = {
          error = "error",
          warning = "warn",
          hint = "hint",
          information = "info",
        },
        use_diagnostic_signs = false,
      })
    end,
  },

  -- Conform (Code formatting)
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier" } },
          javascriptreact = { { "prettierd", "prettier" } },
          typescriptreact = { { "prettierd", "prettier" } },
          json = { { "prettierd", "prettier" } },
          yaml = { { "prettierd", "prettier" } },
          html = { { "prettierd", "prettier" } },
          css = { { "prettierd", "prettier" } },
          scss = { { "prettierd", "prettier" } },
          markdown = { { "prettierd", "prettier" } },
          rust = { "rustfmt" },
          go = { "gofmt" },
          c = { "clang_format" },
          cpp = { "clang_format" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        },
      })
    end,
  },

  -- ===== TESTING =====

  -- Neotest (Testing framework)
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-vitest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python"),
          require("neotest-plenary"),
          require("neotest-go"),
          require("neotest-jest"),
          require("neotest-vitest"),
        },
      })
    end,
  },

  -- ===== PROJECT MANAGEMENT =====

  -- Project detection
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml", "build.gradle" },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = "global",
        datapath = vim.fn.stdpath("data"),
      })
    end,
  },

  -- Telescope project
  {
    "nvim-telescope/telescope-project.nvim",
    config = function()
      require("telescope").load_extension("project")
    end,
  },

  -- ===== NOTES & DOCUMENTATION =====

  -- Neorg (Notes and organization)
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.norg.concealer"] = {},
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                work = "~/notes/work",
                home = "~/notes/home",
              },
            },
          },
        },
      })
    end,
  },

  -- Vimwiki
  {
    "vimwiki/vimwiki",
    config = function()
      vim.g.vimwiki_list = {
        {
          path = "~/vimwiki/",
          syntax = "markdown",
          ext = ".md",
        },
      }
    end,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }
    end,
  },

  -- ===== UI IMPROVEMENTS =====

  -- Noice (Better UI)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })
    end,
  },

  -- Scrollbar
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup({
        show = true,
        show_in_active_only = false,
        set_highlights = true,
        folds = 1000,
        max_lines = false,
        hide_if_all_visible = false,
        throttle_ms = 100,
        handle = {
          text = " ",
          blend = 50,
          color = nil,
          color_nr = nil,
          highlight = "CursorColumn",
          hide_if_all_visible = true,
        },
        marks = {
          Cursor = {
            text = " ",
            priority = 0,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil,
          },
          Search = {
            text = { "-", "=" },
            priority = 1,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil,
          },
          Error = {
            text = { "-", "=" },
            priority = 2,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil,
          },
          Warn = {
            text = { "-", "=" },
            priority = 3,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil,
          },
          Info = {
            text = { "-", "=" },
            priority = 4,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil,
          },
          Hint = {
            text = { "-", "=" },
            priority = 5,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil,
          },
          Misc = {
            text = { "-", "=" },
            priority = 6,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil,
          },
        },
        excluded_buftypes = {
          "terminal",
        },
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
          "noice",
          "notify",
        },
        autocmd = {
          render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
          },
          clear = {
            "BufWinLeave",
            "TabLeave",
            "TermLeave",
            "WinLeave",
          },
        },
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = false,
          handle = true,
          marks = true,
          search = false,
          ale = false,
        },
      })
    end,
  },

  -- ===== SESSION MANAGEMENT =====

  -- Persisted (Session management)
  {
    "olimorris/persisted.nvim",
    config = function()
      require("persisted").setup({
        save_dir = vim.fn.stdpath("data") .. "/sessions/",
        command = "VimLeavePre",
        use_git_branch = true,
        telescope = {
          before_source = function()
            vim.api.nvim_command("Telescope persisted")
          end,
          after_source = function(session)
            vim.api.nvim_command("cd " .. session.dir)
          end,
        },
      })
    end,
  },

  -- Auto session
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "info",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        auto_session_enable_last_session = true,
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_use_git_branch = true,
        auto_session_create_enabled = true,
        auto_session_last_session_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_verbose = true,
        auto_session_enable_last_session_file_override = false,
      })
    end,
  },

  -- ===== LANGUAGE SPECIFIC =====

  -- Emmet
  {
    "mattn/emmet-vim",
    config = function()
      vim.g.user_emmet_leader_key = "<C-y>"
      vim.g.user_emmet_settings = {
        html = {
          default_attributes = {
            option = { value = vim.null },
            textarea = { id = vim.null, name = vim.null, cols = 10, rows = 10 },
          },
          snippets = {
            ["!"] = "<!DOCTYPE html>\n"
              .. '<html lang="${lang}">\n'
              .. "<head>\n"
              .. '\t<meta charset="${charset}">\n'
              .. '\t<meta name="viewport" content="width=device-width, initial-scale=1.0">\n'
              .. '\t<title>${1:Document}</title>\n'
              .. "</head>\n"
              .. "<body>\n"
              .. '\t${0}\n'
              .. "</body>\n"
              .. "</html>",
          },
        },
      }
    end,
  },

  -- Tailwind CSS IntelliSense
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "bradlc/vscode-css-language-server",
    },
  },

  -- ===== ADVANCED KEYMAPS =====

  -- Legendary (Command palette)
  {
    "mrjones2014/legendary.nvim",
    config = function()
      require("legendary").setup({
        keymaps = {},
        commands = {},
        autocmds = {},
        which_key = {
          auto_register = true,
          do_binding = false,
          use_groups = true,
        },
      })
    end,
  },

  -- ===== PERFORMANCE & UTILITIES =====

  -- Treesitter text objects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["as"] = "@statement.outer",
              ["is"] = "@statement.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
              ["]a"] = "@parameter.outer",
              ["]b"] = "@block.outer",
              ["]l"] = "@loop.outer",
              ["]s"] = "@statement.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
              ["]A"] = "@parameter.outer",
              ["]B"] = "@block.outer",
              ["]L"] = "@loop.outer",
              ["]S"] = "@statement.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
              ["[a"] = "@parameter.outer",
              ["[b"] = "@block.outer",
              ["[l"] = "@loop.outer",
              ["[s"] = "@statement.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
              ["[A"] = "@parameter.outer",
              ["[B"] = "@block.outer",
              ["[L"] = "@loop.outer",
              ["[S"] = "@statement.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
        },
      })
    end,
  },

  -- Aerial (Code outline)
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({
        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "man" },
        disable_max_lines = vim.g.max_file.lines,
        disable_max_size = vim.g.max_file.size,
        filter_kind = false,
        highlight_mode = "split_width",
        highlight_on_hover = true,
        highlight_on_jump = 300,
        icons = {},
        ignore = {
          buftypes = {},
          filetypes = {},
          unlisted_buffers = true,
        },
        layout = {
          default_direction = "prefer_right",
          max_width = { 40, 0.2 },
          min_width = 10,
          placement = "edge",
        },
        lsp = {
          diagnostics_trigger_update = false,
          link_fold_to_tree = false,
          link_tree_to_fold = true,
          update_when_errors = true,
          update_delay = 300,
        },
        manage_folds = false,
        notifier = function(severity, message, ...)
          vim.notify(message, severity, ...)
        end,
        on_attach = function(bufnr)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>a", "<cmd>AerialToggle!<CR>", {})
        end,
        open_automatic = false,
        plugins = {
          ["nvim-dap"] = {
            location_config = "breakpoints",
            update_events = "DebugCmdlineEnter",
          },
          ["nvim-lsp"] = {
            update_events = "LspAttach",
            update_when_errors = true,
          },
          ["nvim-treesitter"] = {
            update_events = "BufWritePost",
          },
        },
        post_jump_cmd = "normal! zz",
        pre_jump_cmd = "",
        priority = 100,
        show_guides = true,
        smart_fold = false,
        sort_method = "signature",
        filter_kind = {
          "Class",
          "Constructor",
          "Enum",
          "Function",
          "Interface",
          "Module",
          "Method",
          "Struct",
        },
      })
    end,
  },

  -- ===== TERMINAL IMPROVEMENTS =====

  -- Toggleterm improvements
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
        winbar = {
          enabled = false,
          name_formatter = function(term)
            return term.name
          end,
        },
      })
    end,
  },

  -- ===== FILE EXPLORER ALTERNATIVES =====

  -- Nvim-tree (Alternative file explorer)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          adaptive_size = true,
          mappings = {
            list = {
              { key = "u", action = "dir_up" },
            },
          },
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })
    end,
  },
}
