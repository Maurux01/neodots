return {
  'vyfor/cord.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('cord').setup(opts)
  end,
}
