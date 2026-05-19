vim.cmd 'colorscheme catppuccin'

require('vim._core.ui2').enable {
  enable = true,
  msg = {
    targets = {
      default = 'cmd',
      progress = 'msg',
    },
  },
}

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
vim.opt.complete:append 'o'
vim.opt.completeopt = 'fuzzy,menuone,popup,noselect'
vim.opt.pumborder = 'single'
vim.opt.statusline:append " [%{&filetype ==# '' ? 'none' : &filetype }|%{&fileformat}]"
vim.opt.showtabline = 2
function _G.simple_tabline()
  local curr_buf = vim.api.nvim_get_current_buf()
  local parts = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buflisted then
      local name = vim.api.nvim_buf_get_name(bufnr)
      name = name ~= '' and vim.fn.fnamemodify(name, ':t') or '[No Name]'
      name:gsub('%%', '%%%%')
      if bufnr == curr_buf then
        table.insert(parts, '%#TabLineSel#')
      else
        table.insert(parts, '%#TabLine#')
      end
      local modified = vim.bo[bufnr].modified and '*' or ''
      table.insert(parts, ' ' .. name .. modified .. ' ')
    end
  end
  table.insert(parts, '%#TabLineFill#%=')
  return table.concat(parts)
end
vim.opt.tabline = '%!v:lua.simple_tabline()'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set({ 'n', 'v' }, '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]])
vim.keymap.set({ 'n', 'v' }, '<leader>P', [["+P]])
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist)
vim.keymap.set('n', '<S-h>', ':bp<CR>')
vim.keymap.set('n', '<S-l>', ':bn<CR>')

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserFtIndent2', { clear = true }),
  pattern = { 'nix', 'lua', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'html', 'css', 'less', 'scss', 'sass', 'json' },
  callback = function()
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

local gh = function(x)
  return 'https://github.com/' .. x
end
vim.pack.add {
  gh 'mason-org/mason.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'stevearc/conform.nvim',
  gh 'romus204/tree-sitter-manager.nvim',
  gh 'dmtrKovalenko/fff',
  gh 'lewis6991/gitsigns.nvim',
}

require('gitsigns').setup {
  current_line_blame = true
}

-- In windows, tree-sitter may be built with msvc.
-- If you only have the gnu toolchain, you need to set the CC and CFLAGS environment variables for tree-sitter build.
-- vim.env.CC = "cc"
-- vim.env.CFLAGS = "--target=x86_64-w64-windows-gnu"
require('tree-sitter-manager').setup()
require('mason').setup()
require('conform').setup {
  formatters_by_ft = {
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    zsh = { 'shfmt' },
    fish = { 'fish_indent' },
    json = { 'prettierd', 'prettier', stop_after_first = true },
    jsonc = { 'prettierd', 'prettier', stop_after_first = true },
    yaml = { 'prettierd', 'prettier', stop_after_first = true },
    yml = { 'prettierd', 'prettier', stop_after_first = true },
    toml = { 'taplo' },
    markdown = { 'prettierd', 'prettier', stop_after_first = true },
    ['markdown.mdx'] = { 'prettierd', 'prettier', stop_after_first = true },
    mdx = { 'prettierd', 'prettier', stop_after_first = true },
    html = { 'prettierd', 'prettier', stop_after_first = true },
    css = { 'prettierd', 'prettier', stop_after_first = true },
    scss = { 'prettierd', 'prettier', stop_after_first = true },
    less = { 'prettierd', 'prettier', stop_after_first = true },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    vue = { 'prettierd', 'prettier', stop_after_first = true },
    c = { 'clang_format' },
    cpp = { 'clang_format' },
    objc = { 'clang_format' },
    objcpp = { 'clang_format' },
    cuda = { 'clang_format' },
    rust = { 'rustfmt' },
    lua = { 'stylua' },
    python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
    xml = { 'xmlformat' },
  },
}
vim.keymap.set('n', '<leader>ff', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end)

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('UserFFFDownload', { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'fff.nvim' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then
        vim.cmd.packadd 'fff.nvim'
      end
      require('fff.download').download_or_build_binary()
    end
  end,
})
vim.g.fff = {
  lazy_sync = true,
  git = {
    status_text_color = true,
  },
}
vim.keymap.set('n', '<leader>fs', function()
  require('fff').find_files()
end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fz', function()
  require('fff').live_grep()
end, { desc = 'Live grep' })
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('UserFFFDisableAutocomplete', { clear = true }),
  callback = function(ev)
    if vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ev.buf), ':t'):sub(1, 6) == 'fffile' then
      vim.opt_local.autocomplete = false
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspCompletion', { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method 'textDocument/completion' then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.api.nvim_create_autocmd('LspProgress', {
  group = vim.api.nvim_create_augroup('UserLspProgressNotify', { clear = true }),
  buffer = buf,
  callback = function(ev)
    local value = ev.data.params.value
    vim.api.nvim_echo({ { value.message or 'done' } }, false, {
      id = 'lsp.' .. ev.data.params.token,
      kind = 'progress',
      source = 'vim.lsp',
      title = value.title,
      status = value.kind ~= 'end' and 'running' or 'success',
      percent = value.percentage,
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserTSAutoStart', { clear = true }),
  pattern = '*',
  callback = function(ev)
    local lang = ev.match
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(ev.buf, lang)
    end
  end,
})
