local plugin_config = require('config').get_config().plugin_configs.orgmode

return {
  'nvim-orgmode/orgmode',
  enabled = plugin_config.enabled,
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    require('orgmode').setup(plugin_config.opts)
    vim.lsp.enable 'org'
  end,
}
