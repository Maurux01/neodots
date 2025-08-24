return {
  'brenoprata10/nvim-highlight-colors',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('nvim-highlight-colors').setup(opts)
  end,
}
