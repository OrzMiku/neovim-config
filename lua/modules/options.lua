--
if vim.loader then
  vim.loader.enable()
end

-- leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- nerd font
vim.g.have_nerd_font = true

--
vim.g.experimental = {
  undotree = true,
  inline_completion = true,
}

vim.cmd 'syntax on'

vim.o.number = true
vim.o.relativenumber = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.clipboard = 'unnamedplus'
vim.o.undofile = true
if vim.g.experimental.undotree then
  vim.cmd 'packadd nvim.undotree'
  vim.keymap.set('n', '<leader>u', require('undotree').open, { desc = 'Open undotree' })
end
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
