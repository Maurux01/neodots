return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('Comment').setup(opts)
  end,
}
