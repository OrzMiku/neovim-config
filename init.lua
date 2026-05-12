vim.cmd 'colorscheme catppuccin'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.foldtext = ''
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'lua:vim.treesitter.foldexpr()'
vim.opt.undofile = ture
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.mapleader = " "
vim.g.localmapleader = " "
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]])
