return {
  'catppuccin/nvim',
  name = 'catppuccin-nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'catppuccin-nvim'
  end,
}
