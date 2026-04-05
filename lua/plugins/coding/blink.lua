---@module 'lazy.core.config'
---@type LazySpec
return {
  'saghen/blink.cmp',
  version = '1.*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = { 'rafamadriz/friendly-snippets' },
  ---@module 'blink-cmp'
  ---@type blink.cmp.Config
  opts = require('modules.plugins.coding.blink').opts(),
}
