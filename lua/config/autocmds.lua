-- Auto commands configuration for maurux01's Neovim
-- Automatic behaviors and enhancements

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General auto commands
augroup("GeneralSettings", { clear = true })
autocmd("TextYankPost", {
  group = "GeneralSettings",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = "GeneralSettings",
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    pcall(function() vim.cmd([[%s/\s\+$//e]]) end)
    vim.fn.setpos(".", save_cursor)
  end,
})

-- File type specific settings
augroup("FileTypeSettings", { clear = true })
autocmd("FileType", {
  group = "FileTypeSettings",
  pattern = { "python", "lua", "javascript", "typescript", "html", "css" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})

autocmd("FileType", {
  group = "FileTypeSettings",
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

autocmd("FileType", {
  group = "FileTypeSettings",
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 72
  end,
})

-- UI enhancements
-- UI enhancements
augroup("UIEnhancements", { clear = true })
autocmd("VimResized", {
  group = "UIEnhancements",
  pattern = "*",
  command = "wincmd =",
})

autocmd("BufEnter", {
  group = "UIEnhancements",
  pattern = "*",
  callback = function()
    -- Auto close NvimTree if it's the last buffer
    if vim.bo.filetype == "NvimTree" and #vim.api.nvim_list_wins() == 1 then
      vim.cmd("quit")
    end
  end,
})

-- LSP auto commands
augroup("LSPAutoCommands", { clear = true })
autocmd("LspAttach", {
  group = "LSPAutoCommands",
  pattern = "*",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = args.buf,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = args.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

-- Auto reload files when changed externally
augroup("AutoReload", { clear = true })
autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = "AutoReload",
  pattern = "*",
  command = "if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif",
})

autocmd("FileChangedShellPost", {
  group = "AutoReload",
  pattern = "*",
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})

-- Highlight on yank with animation
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 150,
      on_visual = true,
    })
  end,
})

-- Auto create directories when saving a file in a non-existent path
augroup("AutoMkdir", { clear = true })
autocmd("BufWritePre", {
  group = "AutoMkdir",
  pattern = "*",
  callback = function()
    local file = vim.fn.expand("<afile>")
    local dir = vim.fn.fnamemodify(file, ":h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})






