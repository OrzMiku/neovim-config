vim.cmd 'colorscheme catppuccin'

require('vim._core.ui2').enable({
    enable = true,
})

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
vim.opt.autocomplete = true
vim.opt.complete:append("o")
vim.opt.completeopt = "fuzzy,menuone,popup,noselect"
vim.opt.pumborder = "single"
vim.opt.statusline:append(" [%{&filetype ==# '' ? 'none' : &filetype }|%{&fileformat}]")
vim.opt.showtabline = 2
function _G.simple_tabline()
    local curr_buf = vim.api.nvim_get_current_buf()
    local parts = {}
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].buflisted then
            local name = vim.api.nvim_buf_get_name(bufnr)
            name = name ~= "" and vim.fn.fnamemodify(name, ":t") or "[Empty Buffer]"
            name:gsub("%%", "%%%%")
            if bufnr == curr_buf then
                table.insert(parts, "%#TabLineSel#")
            else
                table.insert(parts, "%#TabLine#")
            end
            table.insert(parts, " " .. name .. " ")
        end
    end
    table.insert(parts, "%#TabLineFill#%=")
    return table.concat(parts)
end
vim.opt.tabline = "%!v:lua.simple_tabline()"

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]])
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>Q", vim.diagnostic.setqflist)
vim.keymap.set("n", "<S-h>", ":bp<CR>")
vim.keymap.set("n", "<S-l>", ":bn<CR>")

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('UserTSAutoStart', { clear = true }),
    pattern = '*',
    callback = function(ev)
        local lang = ev.match
        if vim.treesitter.language.add(lang) then
            vim.treesitter.start(ev.buf, lang)
        end
    end
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspCompletion', {}),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
