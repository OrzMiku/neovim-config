local M = {}

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.setup()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
  map({ 'n', 'v' }, '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard' })
  map({ 'n', 'v' }, '<leader>p', [["+p]], { desc = 'Paste from system clipboard' })
  map({ 'n', 'v' }, '<leader>P', [["+P]], { desc = 'Paste before from system clipboard' })

  map('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Diagnostics to quickfix' })
  map('n', '<leader>l', vim.diagnostic.setloclist, { desc = 'Diagnostics to loclist' })

  map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
  map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
  map('n', '<esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })
end

return M
