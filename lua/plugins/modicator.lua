return {
  'mawkler/modicator.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('modicator').setup(opts)
  end,
}
