return {
  'anuvyklack/windows.nvim',
  
  dependencies = {
    {
      "middleclass",
      url = "https://github.com/kikito/middleclass",
    },
  },
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require('windows').setup(opts)
  end,
}
