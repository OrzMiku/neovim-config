local M = {}

local set = vim.keymap.set

function M.lsp_keymap(event)
  local bufnr = event.buf
  set('n', 'grn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP Rename' })
  set('n', 'gra', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP Code Action' })
  set('n', 'grD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP Declaration' })
end

function M.setup()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- buffer navigation
  set('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
  set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })

  -- buffer management
  set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete current buffer' })
  set('n', '<leader>bD', ':bdelete!<CR>', { desc = 'Force delete current buffer' })
  set('n', '<leader>bn', ':enew<CR>', { desc = 'New empty buffer' })

  -- window navigation
  set('n', '<C-h>', '<C-w>h', { desc = 'Go to Left window' })
  set('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower window' })
  set('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper window' })
  set('n', '<C-l>', '<C-w>l', { desc = 'Go to Right window' })

  -- window resizing
  set('n', '<M-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
  set('n', '<M-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
  set('n', '<M-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
  set('n', '<M-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })
  set('n', '<leader>se', '<C-w>=', { desc = 'Make windows equal size' })

  -- window split
  set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
  set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
  set('n', '<leader>sc', '<C-w>c', { desc = 'Close current window' })
  set('n', '<leader>so', '<C-w>o', { desc = 'Close all other windows (Only)' })

  -- move window
  set('n', '<leader>sH', '<C-w>H', { desc = 'Move window to the far left' })
  set('n', '<leader>sJ', '<C-w>J', { desc = 'Move window to the bottom' })
  set('n', '<leader>sK', '<C-w>K', { desc = 'Move window to the top' })
  set('n', '<leader>sL', '<C-w>L', { desc = 'Move window to the far right' })
  set('n', '<leader>sx', '<C-w>x', { desc = 'Swap current window with next' })

  -- nohlsearch
  set('n', '<esc><esc>', '<cmd>nohlsearch<cr>')

  -- open diagnostic list
  set('n', '<leader>q', function()
    vim.diagnostic.setqflist()
  end, { desc = 'Show diagnostics in quickfix window' })
end

return M
