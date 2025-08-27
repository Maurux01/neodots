-- Enhanced code suggestions and command line improvements
local M = {}

function M.setup()
  -- Better command line history
  vim.opt.history = 10000
  vim.opt.wildmenu = true
  vim.opt.wildmode = "longest:full,full"
  vim.opt.wildoptions = "pum,tagfile"
  
  -- Enhanced completion options
  vim.opt.completeopt = "menu,menuone,noselect,preview"
  vim.opt.pumheight = 15
  vim.opt.pumblend = 10
  
  -- Better search
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.incsearch = true
  vim.opt.hlsearch = true
  
  -- Command line improvements
  vim.opt.cmdheight = 1
  vim.opt.showcmd = true
  vim.opt.showmode = false
  
  -- Auto commands for better suggestions
  local augroup = vim.api.nvim_create_augroup("EnhancedSuggestions", { clear = true })
  
  -- Show function signatures on cursor hold
  vim.api.nvim_create_autocmd("CursorHoldI", {
    group = augroup,
    callback = function()
      if vim.fn.pumvisible() == 0 then
        vim.lsp.buf.signature_help()
      end
    end,
  })
  
  -- Auto-show completion menu
  vim.api.nvim_create_autocmd("TextChangedI", {
    group = augroup,
    callback = function()
      local line = vim.api.nvim_get_current_line()
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local char = line:sub(col, col)
      
      -- Trigger completion for certain characters
      if char:match("[%w_.]") then
        local cmp = require("cmp")
        if not cmp.visible() then
          cmp.complete()
        end
      end
    end,
  })
  
  -- Better command line completion
  vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = augroup,
    callback = function()
      -- Enable better command line completion
      vim.opt_local.wildmenu = true
    end,
  })
  
  -- Highlight yanked text
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
      vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
  })
end

return M