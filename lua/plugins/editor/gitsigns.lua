---@module 'lazy.core.config'
---@type LazySpec
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  ---@module 'gitsigns'
  ---@type Gitsigns.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = require('modules.plugins.editor.gitsigns').opts(),
}
