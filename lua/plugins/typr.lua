return {
  'nvzone/typr',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('typr').setup(opts)
  end,
}
