return {
  'anuvyklack/windows.nvim',
  dependencies = { 'middleclass' },
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('windows').setup(opts)
  end,
}
