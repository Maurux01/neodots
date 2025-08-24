return {
  'anuvyklack/windows.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('windows').setup(opts)
  end,
}
