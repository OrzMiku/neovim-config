local map = vim.keymap.set

map('n', '<esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })
map({ 'n', 'x' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map({ 'n', 'x' }, '<leader>p', [["+p]], { desc = 'Paste from system clipboard' })
map('n', '<leader>yr', ':let @+=expand("%:.") | echomsg "Copied path: " . expand("%:.")<CR>', { desc = 'Copy path (relative)' })
map('n', '<leader>ya', ':let @+=expand("%:p") | echomsg "Copied path: " . expand("%:p")<CR>', { desc = 'Copy path (absolute)' })
