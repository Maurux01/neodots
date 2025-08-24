return {
  'm4xshen/autoclose.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('autoclose').setup(opts)
  end,
}
