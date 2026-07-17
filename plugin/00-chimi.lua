--------------------------------------------------------------------------------
--- 00-chimi
--------------------------------------------------------------------------------

local use = Config.plugin_enabled
local use_feature = Config.plugin_feature_enabled

require('chimi.basics').setup {}
require('chimi.diagnostic').setup {
  virtual_lines = not use 'tiny_inline_diagnostic' and { current_line = true } or false,
}
require('chimi.lsp').setup {
  servers = Config.lsp.servers,
}

if not use 'blink_cmp' then
  require('chimi.cmdline').setup {}
  require('chimi.completion').setup {}
end
if not use 'fidget' then
  require('chimi.progress').setup {}
end
if not use_feature('mini', 'statusline') then
  require('chimi.statusline').setup {}
end
if not use 'bufferline' then
  require('chimi.tabline').setup {}
  require('chimi.buffers').setup {}
end
if not use 'fzf_lua' then
  require('chimi.picker').setup {}
end
if not use 'oil' then
  require('chimi.explorer').setup {}
end
if not use 'conform' then
  require('chimi.format').setup {}
end
if not use 'quicker' then
  require('chimi.quickfix').setup {}
end
