return {
  'nvzone/typr',
  dependencies = { 'nvzone/volt' },
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('typr').setup(opts)
  end,
}
