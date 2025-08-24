return {
  'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('nvim-web-devicons').setup(opts)
  end,
}
