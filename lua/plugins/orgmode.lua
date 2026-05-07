local user_config = require('config').get_config()

return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    require('orgmode').setup(user_config.features.orgmode)
    vim.lsp.enable 'org'
  end,
}
