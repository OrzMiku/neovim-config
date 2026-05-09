local user_config = require('config').get_config()

return {
  'nvim-orgmode/orgmode',
  enabled = user_config.features.orgmode.enabled,
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    require('orgmode').setup(user_config.features.orgmode.opts)
    vim.lsp.enable 'org'
  end,
}
