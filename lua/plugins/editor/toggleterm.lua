---@module 'lazy.core.config'
---@type LazySpec
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  event = 'VeryLazy',
  ---@module 'toggleterm'
  ---@type ToggleTermConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = require('modules.plugins.editor.toggleterm').opts(),
  keys = require('modules.plugins.editor.toggleterm').keys(),
}
