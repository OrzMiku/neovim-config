vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap.set

keymap('n', '<esc><esc>', '<cmd>nohlsearch<cr>')

keymap('n', '<leader>q', function()
  vim.diagnostic.setqflist()
end, { desc = 'Show diagnostics in quickfix window' })
