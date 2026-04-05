local M = {}

function M.conform_opts()
  return {
    formatters_by_ft = require('modules.lsp.langs').get_formatters(),
  }
end

function M.conform_keys()
  return {
    {
      '<leader>ff',
      function()
        require('conform').format {
          async = true,
          lsp_format = 'fallback',
        }
      end,
      desc = 'Format buffer',
    },
  }
end

return M
