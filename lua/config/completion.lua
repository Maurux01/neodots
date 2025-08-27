-- Enhanced completion configuration
local cmp = require("cmp")

-- Command line completion for search
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp_document_symbol' }
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = "🔍 " .. vim_item.kind
      return vim_item
    end,
  },
})

-- Command line completion for commands
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'c' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'c' }),
  }),
  sources = cmp.config.sources({
    { name = 'path', priority = 1000 },
    { name = 'cmdline', priority = 900 }
  }),
  formatting = {
    format = function(entry, vim_item)
      if entry.source.name == 'path' then
        vim_item.kind = "📁 Path"
      elseif entry.source.name == 'cmdline' then
        vim_item.kind = "⚡ Cmd"
      end
      return vim_item
    end,
  },
})

-- Configurar colores para los highlights de rainbow brackets
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
  end,
})

-- Aplicar colores inmediatamente
vim.cmd("doautocmd ColorScheme")