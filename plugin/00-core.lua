local opt = vim.opt
local map = vim.keymap.set

-- General
vim.cmd.packadd 'nvim.difftool'
vim.cmd.packadd 'nvim.undotree'
opt.undofile = true

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

-- Editing
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Folding
opt.foldtext = ''
opt.foldlevel = 99
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Native message UI
require('vim._core.ui2').enable {
  enable = true,
  msg = {
    targets = {
      default = 'cmd',
    },
  },
}

-- Keymaps
map('n', '<esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })
map({ 'n', 'x' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map({ 'n', 'x' }, '<leader>p', [["+p]], { desc = 'Paste from system clipboard' })
map('n', '<leader>yr', ':let @+=expand("%:.") | echomsg "Copied path: " . expand("%:.")<CR>', { desc = 'Copy path (relative)' })
map('n', '<leader>ya', ':let @+=expand("%:p") | echomsg "Copied path: " . expand("%:p")<CR>', { desc = 'Copy path (absolute)' })

-- Clipboard over SSH
local function paste()
  return {
    vim.split(vim.fn.getreg '', '\n'),
    vim.fn.getregtype '',
  }
end

if vim.env.SSH_TTY then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = paste,
      ['*'] = paste,
    },
  }
end

-- Start highlighting when a parser is available
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('TreesitterAutoStart', { clear = true }),
  pattern = '*',
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

-- Diagnostics and LSP navigation
vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = not Config.plugin_enabled 'tiny_inline_diagnostic' and { current_line = true } or false,
}

map('n', 'gd', vim.lsp.buf.definition, { desc = 'Definitions' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Declarations' })
map('n', '<leader>xQ', vim.diagnostic.setqflist, { desc = 'Diagnostics to quickfix' })
map('n', '<leader>xL', vim.diagnostic.setloclist, { desc = 'Diagnostics to loclist' })
