local M = {}

function M.lsp_buf_setup(event)
  local bufnr = event.buf
  vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP Rename' })
  vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP Code Action' })
  vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP Declaration' })
end

function M.setup()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  vim.keymap.set('n', '<esc><esc>', '<cmd>nohlsearch<cr>')
  vim.keymap.set('n', '<leader>q', function()
    vim.diagnostic.setqflist()
  end, { desc = 'Show diagnostics in quickfix window' })
end

return M
