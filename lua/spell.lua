-- Spell checker configuration

require("spellsitter").setup({
  enable = true,
  modes = { "n", "i" },
  cursor_highlight = true,
  highlight = "SpellBad",
})
