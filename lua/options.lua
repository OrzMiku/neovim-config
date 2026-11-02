local o = vim.o

-- UI
o.number = true
o.cursorline = true
o.list = true
o.scrolloff = 3
o.signcolumn = 'yes'
require('vim._core.ui2').enable {
  enable = true,
  msg = {
    targets = {
      progress = 'msg',
    },
  },
}

-- Editing
o.undofile = true
o.expandtab = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.shiftround = true
o.smartindent = true
o.ignorecase = true
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.autocomplete = not UserConfig.enable_plugin

-- Folding
o.foldtext = ''
o.foldlevel = 99
o.foldmethod = 'expr'
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Diagnostic
vim.diagnostic.config {
  virtual_text = true,
}
