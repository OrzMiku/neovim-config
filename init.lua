--------------------------------------------------------------------------------
--- Preload
--------------------------------------------------------------------------------

require('config').setup()
local userconfig = require('config').get_config()

--------------------------------------------------------------------------------
--- Basic
--------------------------------------------------------------------------------

userconfig.hooks.before_basic()

vim.cmd.colorscheme 'catppuccin'

if userconfig.features.ui2 then
  require('vim._core.ui2').enable {
    enable = true,
    msg = {
      targets = {
        default = 'cmd',
        progress = 'msg',
      },
    },
  }
end

if userconfig.features.clipboard_osc52 then
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
end

vim.opt.number = true
vim.opt.relativenumber = false
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

vim.opt.tabline = '%!v:lua.simple_tabline()'
vim.opt.scrolloff = 3

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set({ 'n', 'v' }, '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]])
vim.keymap.set({ 'n', 'v' }, '<leader>P', [["+P]])
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist)
vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist)
vim.keymap.set('n', '<S-h>', ':bp<cr>')
vim.keymap.set('n', '<S-l>', ':bn<cr>')
vim.keymap.set('n', '<esc>', ':nohl<cr>')

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('UserFtIndent2', { clear = true }),
  pattern = { 'nix', 'lua', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'html', 'css', 'less', 'scss', 'sass', 'json' },
  callback = function()
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
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

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspInlineCompletion', { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('textDocument/inlineCompletion', ev.buf) then
      vim.lsp.inline_completion.enable(true, { bufnr = ev.buf })
      vim.keymap.set('i', '<C-F>', vim.lsp.inline_completion.get, { desc = 'LSP: accept inline completion', buf = ev.buf })
      vim.keymap.set('i', '<C-G>', vim.lsp.inline_completion.select, { desc = 'LSP: switch inline completion', buf = ev.buf })
    end
  end,
})

vim.api.nvim_create_autocmd('LspProgress', {
  group = vim.api.nvim_create_augroup('UserLspProgressNotify', { clear = true }),
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

vim.cmd.packadd 'nvim.difftool'

userconfig.hooks.after_basic()

--------------------------------------------------------------------------------
--- Plugins
--------------------------------------------------------------------------------

if not userconfig.features.enable_plugin then
  return
end

userconfig.hooks.before_plugin()

local gh = function(x)
  return 'https://ghfast.top/github.com/' .. x
end

-- catppuccin
do
  vim.pack.add {
    {
      src = gh 'catppuccin/nvim',
      name = 'catppuccin',
    },
  }

  vim.cmd.colorscheme 'catppuccin-nvim'
end

-- icon
do
  vim.pack.add { gh 'nvim-mini/mini.icons' }
  local mini_icons = require 'mini.icons'
  mini_icons.setup {
    style = userconfig.features.have_nerd_font and 'glyph' or 'ascii',
  }
  mini_icons.mock_nvim_web_devicons()
end

-- nvim-lspconfig
do
  vim.pack.add {
    gh 'neovim/nvim-lspconfig',
  }
end

-- gitsigns
do
  vim.pack.add {
    gh 'lewis6991/gitsigns.nvim',
  }

  local gitsigns = require 'gitsigns'

  gitsigns.setup {
    current_line_blame = true,
  }

  vim.keymap.set('n', ']h', gitsigns.next_hunk, { desc = 'Gitsigns next_hunk' })
  vim.keymap.set('n', '[h', gitsigns.prev_hunk, { desc = 'Gitsigns prev_hunk' })
  vim.keymap.set('n', 'gp', gitsigns.preview_hunk, { desc = 'Gitsigns preview_hunk' })
  vim.keymap.set('n', 'gP', gitsigns.preview_hunk_inline, { desc = 'Gitsigns preview_hunk_inline' })
end

-- neogit
do
  vim.pack.add {
    gh 'NeogitOrg/neogit',
    gh 'dlyongemallo/diffview-plus.nvim',
  }

  vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Show Neogit UI' })
end

-- tree-sitter-manager
do
  vim.pack.add {
    gh 'romus204/tree-sitter-manager.nvim',
  }

  require('tree-sitter-manager').setup()
end

-- mason start
do
  vim.pack.add {
    gh 'mason-org/mason.nvim',
  }

  require('mason').setup()
end

-- conform start
do
  vim.pack.add {
    gh 'stevearc/conform.nvim',
  }

  require('conform').setup {
    formatters_by_ft = {
      nix = { 'nixfmt' },
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

  vim.keymap.set('n', '<leader>cf', function()
    require('conform').format { async = true, lsp_format = 'fallback' }
  end, { desc = 'Code format' })
end

-- fzf-lua
do
  vim.pack.add {
    gh 'ibhagwan/fzf-lua',
  }

  require('fzf-lua').setup {
    files = {
      formatter = 'path.filename_first',
    },
  }

  vim.keymap.set('n', '<leader>ff', function()
    require('fzf-lua').files()
  end, { desc = 'FzfLua find_files' })

  vim.keymap.set('n', '<leader>fg', function()
    require('fzf-lua').live_grep()
  end, { desc = 'FzfLua live_grep' })

  vim.keymap.set('n', '<leader>fb', function()
    require('fzf-lua').buffers()
  end, { desc = 'FzfLua buffers' })

  vim.keymap.set('n', '<leader>fh', function()
    require('fzf-lua').help_tags()
  end, { desc = 'FzfLua help_tags' })

  vim.keymap.set('n', '<leader>fk', function()
    require('fzf-lua').keymaps()
  end, { desc = 'FzfLua keymaps' })

  vim.keymap.set('n', '<leader>fo', function()
    require('fzf-lua').oldfiles()
  end, { desc = 'FzfLua old_files' })

  vim.keymap.set('n', '<leader>gf', function()
    require('fzf-lua').git_files()
  end, { desc = 'FzfLua git_files' })

  vim.keymap.set('n', '<leader>gs', function()
    require('fzf-lua').git_status()
  end, { desc = 'FzfLua git_status' })

  vim.keymap.set('n', '<leader>gS', function()
    require('fzf-lua').git_stash()
  end, { desc = 'FzfLua git_stash' })

  vim.keymap.set('n', '<leader>gb', function()
    require('fzf-lua').git_branches()
  end, { desc = 'FzfLua git_branches' })

  vim.keymap.set('n', '<leader>gc', function()
    require('fzf-lua').git_commits()
  end, { desc = 'FzfLua git_commits' })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserFzfLuaLspKeymap', { clear = true }),
    callback = function(ev)
      vim.keymap.set('n', 'grr', function()
        require('fzf-lua').lsp_references()
      end, { desc = 'FzfLua LSP References', buf = ev.buf })
      vim.keymap.set('n', 'gri', function()
        require('fzf-lua').lsp_implementations()
      end, { desc = 'FzfLua LSP Implementations', buf = ev.buf })
      vim.keymap.set('n', 'grd', function()
        require('fzf-lua').lsp_definitions()
      end, { desc = 'FzfLua LSP Definitions', buf = ev.buf })
      vim.keymap.set('n', 'gO', function()
        require('fzf-lua').lsp_document_symbols()
      end, { desc = 'FzfLua LSP Document Symbols', buf = ev.buf })
      vim.keymap.set('n', 'gW', function()
        require('fzf-lua').lsp_workspace_symbols()
      end, { desc = 'FzfLua LSP Workspace Symbols', buf = ev.buf })
      vim.keymap.set('n', 'grt', function()
        require('fzf-lua').lsp_typedefs()
      end, { desc = 'FzfLua LSP Type Definitions', buf = ev.buf })
    end,
  })
end

-- fidget
do
  vim.pack.add { gh 'j-hui/fidget.nvim' }
  vim.api.nvim_clear_autocmds {
    group = 'UserLspProgressNotify',
  }
  require('fidget').setup {}
end

-- oil.nvim
do
  vim.pack.add { gh 'stevearc/oil.nvim' }
  require('oil').setup()
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
end

-- blink.cmp
do
  vim.opt.autocomplete = false
  vim.opt.complete:remove 'o'
  vim.api.nvim_clear_autocmds {
    group = 'UserLspCompletion',
  }
  for _, client in ipairs(vim.lsp.get_clients()) do
    for bufnr, _ in pairs(client.attached_buffers or {}) do
      pcall(vim.lsp.completion.enable, false, client.id, bufnr)
    end
  end

  vim.pack.add {
    { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' },
  }

  require('blink.cmp').setup {
    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
    },
  }
end

-- bufferline
do
  vim.pack.add { gh 'akinsho/bufferline.nvim' }
  require('bufferline').setup()
end

-- bqf
do
  vim.pack.add { gh 'kevinhwang91/nvim-bqf' }
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('NvimBqfEnableByFileType', { clear = true }),
    pattern = { 'qf' },
    callback = function()
      require('bqf').setup {}
    end,
  })
end

-- quicker
do
  vim.pack.add { gh 'stevearc/quicker.nvim' }
  require('quicker').setup {}
end

-- mini.nvim
do
  vim.pack.add {
    gh 'nvim-mini/mini.nvim',
    gh 'rafamadriz/friendly-snippets',
  }
  require('mini.ai').setup()
  require('mini.surround').setup()
  require('mini.statusline').setup()
  require('mini.indentscope').setup {
    draw = {
      delay = 0,
      animation = require('mini.indentscope').gen_animation.none(),
    },
  }
  require('mini.pairs').setup()
  require('mini.move').setup()
  require('mini.comment').setup()
  -- snippets
  local gen_loader = require('mini.snippets').gen_loader
  require('mini.snippets').setup {
    snippets = {
      gen_loader.from_lang(),
    },
  }
end

-- which-key
do
  vim.pack.add {
    gh 'folke/which-key.nvim',
  }

  require('which-key').setup()
end

-- render-markdown
do
  vim.pack.add {
    gh 'MeanderingProgrammer/render-markdown.nvim',
  }
end

-- tiny-inline-diagnostic
do
  vim.pack.add {
    gh 'rachartier/tiny-inline-diagnostic.nvim',
  }

  require('tiny-inline-diagnostic').setup {
    options = {
      multilines = {
        enabled = true,
      },
    },
  }
  vim.diagnostic.config { virtual_text = false }
end

-- flash
do
  vim.pack.add {
    gh 'folke/flash.nvim',
  }
  require('flash').setup {}
end

-- grug-far
do
  vim.pack.add {
    gh 'MagicDuck/grug-far.nvim',
  }
  require('grug-far').setup {}
end

-- dropbar
do
  vim.pack.add {
    gh 'Bekaboo/dropbar.nvim',
  }
  require('dropbar').setup {}
end

userconfig.hooks.after_plugin()
