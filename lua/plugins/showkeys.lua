return {
  'nvzone/showkeys',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('showkeys').setup(opts)
  end,
}
