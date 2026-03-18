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
end

return M
