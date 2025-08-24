return {
  'sphamba/smear-cursor.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('smear-cursor').setup(opts)
  end,
}
