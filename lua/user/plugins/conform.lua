local M = {}

function M.setup()
  vim.keymap.set('n', '<leader>ff', function()
    require('conform').format {
      async = true,
      lsp_format = 'fallback',
    }
  end)
end

return M
