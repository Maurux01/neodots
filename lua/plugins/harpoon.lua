return {
  'ThePrimeagen/harpoon',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('harpoon').setup(opts)
  end,
}
