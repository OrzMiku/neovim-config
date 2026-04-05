---@module 'lazy.core.config'
---@type LazySpec
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = require('modules.plugins.ui.which-key').keys(),
}
