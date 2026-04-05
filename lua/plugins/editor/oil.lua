---@module 'lazy.core.config'
---@type LazySpec
return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { 'nvim-mini/mini.icons' },
  lazy = false,
  keys = {
    { '<leader>e', '<cmd>Oil<cr>', desc = 'open file explorer' },
  },
}
