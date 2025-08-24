return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('tiny-inline-diagnostic').setup(opts)
  end,
}
