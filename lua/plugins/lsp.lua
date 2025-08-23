-- LSP Configuration
local M = {}

-- Setup Mason
require("mason").setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({
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
})

-- LSP handlers
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
    prefix = "●",
    spacing = 4,
  },
  float = {
    source = "always",
    border = "rounded",
    header = "",
    prefix = function(diagnostic)
      local icons = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
      }
      return icons[diagnostic.severity] .. " "
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
})

-- LSP on_attach function
local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- LSP keymaps
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  -- Diagnostic keymaps
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

  -- Set buffer options
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Highlight references
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

-- LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- LSP configurations
local lspconfig = require("lspconfig")

-- Lua
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
})

-- TypeScript/JavaScript
lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
})

-- Python
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
})

-- Rust
lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
})

-- Go
lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
})

-- C/C++
lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
})

-- JSON
lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
})

-- YAML
lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
})

-- HTML
lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
})

-- CSS
lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
})

-- Tailwind CSS
lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = handlers,
})

return M
