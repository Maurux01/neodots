return {
  'kosayoda/nvim-lightbulb',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('nvim-lightbulb').setup(opts)
  end,
}
