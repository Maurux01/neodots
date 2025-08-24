return {
  'theHamsta/nvim-dap-virtual-text',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('nvim-dap-virtual-text').setup(opts)
  end,
}
