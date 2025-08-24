return {
  'norcalli/nvim-colorizer.lua',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('colorizer').setup(opts)
  end,
}
