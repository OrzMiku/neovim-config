---@module 'lazy.core.config'
---@type LazySpec
return {
  'lervag/vimtex',
  lazy = false,
  init = require('modules.plugins.langs.tex').vimtex_init,
}
