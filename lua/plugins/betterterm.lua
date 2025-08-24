return {
  'CRAG666/betterTerm.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('betterTerm').setup(opts)
  end,
}
