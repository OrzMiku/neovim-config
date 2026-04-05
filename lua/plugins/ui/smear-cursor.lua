---@module 'lazy.core.config'
---@type LazySpec
return {
  'sphamba/smear-cursor.nvim',
  event = 'VeryLazy',
  enabled = require('modules.plugins.ui.smear-cursor').enabled,
  opts = {},
}
