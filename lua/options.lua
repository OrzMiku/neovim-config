local opt = vim.opt

-- UI
opt.number = true
opt.cursorline = true
opt.list = true
opt.scrolloff = 3
opt.signcolumn = 'yes'
opt.winborder = 'single'
opt.pumborder = 'single'
opt.pummaxwidth = 80
opt.pumheight = 10
require('vim._core.ui2').enable {
  enable = true,
  msg = {
    targets = {
      default = 'cmd',
    },
  },
}

-- Editing
opt.undofile = true
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true

-- Folding
opt.foldtext = ''
opt.foldlevel = 99
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
