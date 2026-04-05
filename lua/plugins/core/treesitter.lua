---@module 'lazy.core.config'
---@type LazySpec[]
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = require('modules.plugins.core.treesitter').setup,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    init = require('modules.plugins.core.treesitter').textobjects_init,
  },
}
