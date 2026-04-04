local M = {}

function M.setup()
  -- leader key
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- nerd font
  vim.g.have_nerd_font = true

  -- disbale netrw
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- enable undotree
  vim.cmd 'packadd nvim.undotree'
  vim.keymap.set('n', '<leader>u', require('undotree').open)
end

return M
