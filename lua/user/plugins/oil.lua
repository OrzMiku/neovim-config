local M = {}

function M.setup()
  require('oil').setup()
  vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
end

return M
