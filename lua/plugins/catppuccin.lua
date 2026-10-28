return {
  'catppuccin/nvim',
  main = 'catppuccin',
  priority = 1000,
  lazy = false,
  opts = {},
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin-nvim'
  end,
}
