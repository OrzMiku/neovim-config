local M = {}

function M.setup()
  require('conform').setup {
    formatters_by_ft = {
      lua = { 'stylua' },
    },
  }
  vim.keymap.set('n', '<leader>ff', function()
    require('conform').format {
      async = true,
      lsp_format = 'fallback',
    }
  end)
end

return M
