-- buffer navigation
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- buffer management
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete current buffer' })
vim.keymap.set('n', '<leader>bD', ':bdelete!<CR>', { desc = 'Force delete current buffer' })
vim.keymap.set('n', '<leader>bn', ':enew<CR>', { desc = 'New empty buffer' })

-- window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to Left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to Right window' })

-- window resizing
vim.keymap.set('n', '<M-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<M-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make windows equal size' })

-- window split
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>sc', '<C-w>c', { desc = 'Close current window' })
vim.keymap.set('n', '<leader>so', '<C-w>o', { desc = 'Close all other windows (Only)' })

-- move window
vim.keymap.set('n', '<leader>sH', '<C-w>H', { desc = 'Move window to the far left' })
vim.keymap.set('n', '<leader>sJ', '<C-w>J', { desc = 'Move window to the bottom' })
vim.keymap.set('n', '<leader>sK', '<C-w>K', { desc = 'Move window to the top' })
vim.keymap.set('n', '<leader>sL', '<C-w>L', { desc = 'Move window to the far right' })
vim.keymap.set('n', '<leader>sx', '<C-w>x', { desc = 'Swap current window with next' })

-- nohlsearch
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', { desc = 'No search highlight' })
