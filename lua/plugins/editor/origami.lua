---@module 'lazy.core.config'
---@type LazySpec
return {
  'chrisgrieser/nvim-origami',
  event = 'VeryLazy',
  opts = {},
  init = require('modules.plugins.editor.origami').init,
}
