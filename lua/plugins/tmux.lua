return {
  'aserowy/tmux.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('tmux').setup(opts)
  end,
}
