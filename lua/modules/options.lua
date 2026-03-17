vim.cmd 'syntax on'

vim.o.number = true
vim.o.relativenumber = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.o.undofile = true
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
