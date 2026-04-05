---@module 'lazy.core.config'
---@type LazySpec
return {
  'Bekaboo/dropbar.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  ---@module 'dropbar'
  ---@type dropbar_opts_t
  opts = {},
  keys = require('modules.plugins.ui.dropbar').keys(),
}
