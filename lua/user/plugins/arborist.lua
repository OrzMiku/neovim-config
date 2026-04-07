local M = {}

function M.setup()
  vim.g.arborist_loaded = true
  require('arborist').setup {
    ignore = {
      'vue',
      'typescriptreact',
      'javascriptreact',
    },
  }
end

return M
