---@module 'lazy.core.config'
---@type LazySpec
return {
  'junegunn/fzf',
  build = require('modules.plugins.editor.fzf').build,
}
