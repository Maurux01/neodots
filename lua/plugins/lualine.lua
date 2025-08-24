return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'auto'
    },
    sections = {
      lualine_a = { { 'mode', icon = '' } }, -- Neovim icon (Nerd Font)
      lualine_x = { 'encoding', 'fileformat', 'filetype', 'ruler' }
    }
  }
}
