return {
  'sindrets/diffview.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('diffview').setup(opts)
  end,
}
