return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { 'nvim-mini/mini.icons' },
  cmd = 'Oil',
  opts = {},
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
  },
}
