return {
  'anuvyklack/windows.nvim',
  
    dependencies = {
    {
      "middleclass",
      url = "https://raw.githubusercontent.com/kikito/middleclass/master/middleclass.lua",
    },
  },
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require('windows').setup(opts)
  end,
}
