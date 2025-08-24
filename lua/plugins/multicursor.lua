return {
  'jake-stewart/multicursor.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('multicursor').setup(opts)
  end,
}
