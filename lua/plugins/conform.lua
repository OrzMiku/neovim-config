local user_config = require('config').get_config()

return {
  'stevearc/conform.nvim',
  dependencies = { 'mason-org/mason.nvim' },
  opts = {
    formatters_by_ft = user_config.features.formatters_by_ft,
  },
  keys = {
    {
      '<leader>ff',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      desc = 'Format file',
    },
  },
}
