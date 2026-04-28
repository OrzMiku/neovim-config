local M = {}

local user_config = require('user.config').get_config()

function M.setup()
  require('conform').setup {
    formatters_by_ft = user_config.features.formatters_by_ft,
  }
  vim.keymap.set('n', '<leader>ff', function()
    require('conform').format {
      async = true,
      lsp_format = 'fallback',
    }
  end)
end

return M
