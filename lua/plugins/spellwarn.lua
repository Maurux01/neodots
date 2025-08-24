return {
  'ravibrock/spellwarn.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function(_, opts)
    require('spellwarn').setup(opts)
  end,
}
