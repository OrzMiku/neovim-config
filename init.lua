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
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true

require('vim._core.ui2').enable({
  enable = true,
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set({"n", "v"}, "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]])
vim.keymap.set({"n", "v"}, "<leader>P", [["+P]])
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>Q", vim.diagnostic.setqflist)

vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function(ev)
        local lang = ev.match
        if vim.treesitter.language.add(lang) then
            vim.treesitter.start(ev.buf, lang)
        end
    end
})
