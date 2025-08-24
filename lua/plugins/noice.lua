return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {},
  dependencies = {
    -- if you use nvim-notify
    'rcarriga/nvim-notify',
  },
  config = function(_, opts)
    require('noice').setup(opts)
  end,
}
