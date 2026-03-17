return {
  'nvim-tree/nvim-web-devicons',
  enable = function()
    return vim.g.have_nerd_font
  end,
  lazy = true,
  opts = {},
}
