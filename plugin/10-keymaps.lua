--------------------------------------------------------------------------------
--- 10-keymaps
--------------------------------------------------------------------------------

local map = vim.keymap.set

map({ 'n', 'x' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map({ 'n', 'x' }, '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard' })
map({ 'n', 'x' }, '<leader>p', [["+p]], { desc = 'Paste from system clipboard' })
map({ 'n', 'x' }, '<leader>P', [["+P]], { desc = 'Paste before from system clipboard' })

map('n', '<leader>xQ', vim.diagnostic.setqflist, { desc = 'Diagnostics to quickfix' })
map('n', '<leader>xL', vim.diagnostic.setloclist, { desc = 'Diagnostics to loclist' })

map('n', '<esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })
