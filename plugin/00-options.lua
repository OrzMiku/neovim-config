--------------------------------------------------------------------------------
--- 00-options
--- General, UI, Editing, Fold, Complete, Autocmd
--------------------------------------------------------------------------------

-- General
vim.g.mapleader = ' '
vim.opt.undofile = true
require('vim._core.ui2').enable {
  enable = true,
  msg = {
    targets = {
      default = 'cmd',
      progress = 'msg',
    },
  },
}
vim.cmd.packadd 'nvim.difftool'
vim.cmd.packadd 'nvim.undotree'

-- UI
vim.cmd.colorscheme 'catppuccin'

vim.opt.number = true
vim.opt.list = true
vim.opt.pumborder = 'single'
vim.opt.pummaxwidth = 80
vim.opt.winborder = 'single'
vim.opt.scrolloff = 3
vim.opt.signcolumn = 'yes'
vim.opt.statusline:append " [%{&filetype ==# '' ? 'none' : &filetype }|%{&fileformat}]"
Config.simple_tabline = function()
  local curr_buf = vim.api.nvim_get_current_buf()
  local parts = {}

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buflisted then
      local name = vim.api.nvim_buf_get_name(bufnr)
      name = (name ~= '' and vim.fn.fnamemodify(name, ':t') or '[No Name]'):gsub('%%', '%%%%')

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
vim.opt.showtabline = 2
vim.opt.tabline = '%!v:lua.Config.simple_tabline()'

-- Editing
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Complete
vim.opt.autocomplete = true
vim.opt.complete:append 'o'
vim.opt.completeopt = 'fuzzy,menuone,popup,noselect'
vim.opt.autocompletedelay = 80

-- Fold
vim.opt.foldtext = ''
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Clipboard
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

-- Autocmd
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserFtIndent2', { clear = true }),
  pattern = {
    'nix',
    'lua',
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact',
    'html',
    'css',
    'less',
    'scss',
    'sass',
    'json',
  },
  callback = function()
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspCompletion', { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/completion', ev.buf) then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspInlineCompletion', { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/inlineCompletion', ev.buf) then
      vim.lsp.inline_completion.enable(true, { bufnr = ev.buf, client_id = client.id })
      vim.keymap.set('i', '<C-F>', function()
        if vim.lsp.inline_completion.get { bufnr = ev.buf } then
          return ''
        end
        return '<C-F>'
      end, { expr = true, desc = 'LSP: accept inline completion', buffer = ev.buf })
      vim.keymap.set('i', '<C-G>', function()
        vim.lsp.inline_completion.select { bufnr = ev.buf }
      end, { desc = 'LSP: switch inline completion', buffer = ev.buf })
    end
  end,
})

vim.api.nvim_create_autocmd('LspProgress', {
  group = vim.api.nvim_create_augroup('UserLspProgressNotify', { clear = true }),
  callback = function(ev)
    local value = ev.data.params.value
    local params = ev.data.params
    local id = ('lsp.%d.%s'):format(ev.data.client_id, tostring(params.token))
    vim.api.nvim_echo({ { value.message or 'done' } }, false, {
      -- id = 'lsp.' .. ev.data.params.token,
      id = id,
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
    pcall(vim.treesitter.start, ev.buf)
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('UserDisableAutocomplete', { clear = true }),
  callback = function(ev)
    if vim.bo[ev.buf].buftype ~= '' then
      vim.bo[ev.buf].autocomplete = false
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserQuickFixWrap', { clear = true }),
  pattern = { 'qf' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})
