return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "tsserver",
        "gopls",
        "clangd",
        "jsonls",
        "yamlls",
        "html",
        "cssls",
        "tailwindcss",
      },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    keys = {
      { "gd", function() vim.lsp.buf.definition() end, desc = "Go to definition" },
      { "gr", function() vim.lsp.buf.references() end, desc = "Go to references" },
      { "K", function() vim.lsp.buf.hover() end, desc = "Hover" },
      { "<leader>ca", function() vim.lsp.buf.code_action() end, desc = "Code action" },
      { "<leader>rn", function() vim.lsp.buf.rename() end, desc = "Rename" },
      { "<leader>f", function() vim.lsp.buf.format() end, desc = "Format" },
      { "[d", function() vim.diagnostic.goto_prev() end, desc = "Go to previous diagnostic" },
      { "]d", function() vim.diagnostic.goto_next() end, desc = "Go to next diagnostic" },
      { "<leader>e", function() vim.diagnostic.open_float() end, desc = "Open diagnostics float" },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
          vim.api.nvim_create_autocmd("CursorHold", {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = "lsp_document_highlight",
          })
          vim.api.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = "lsp_document_highlight",
          })
        end
      end

      local servers = require("mason-lspconfig").get_installed_servers()
      for _, server_name in ipairs(servers) do
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
}