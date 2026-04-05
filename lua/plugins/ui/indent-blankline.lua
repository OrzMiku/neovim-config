---@module 'lazy.core.config'
---@type LazySpec
return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  main = 'ibl',
  ---@module "ibl"
  ---@type ibl.config
  opts = require('modules.plugins.ui.indent-blankline').opts(),
}
