---@module 'lazy.core.config'
---@type LazySpec
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {},
  config = require('modules.plugins.core.colorscheme').catppuccin_config,
}
