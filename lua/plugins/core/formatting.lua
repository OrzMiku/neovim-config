---@module 'lazy.core.config'
---@type LazySpec[]
return {
  {
    'stevearc/conform.nvim',
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = require('modules.plugins.core.formatting').conform_opts(),
    keys = require('modules.plugins.core.formatting').conform_keys(),
  },
}
