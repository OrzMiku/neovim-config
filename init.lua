vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd 'syntax on'

vim.o.number = true
vim.o.relativenumber = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.clipboard = 'unnamedplus'
vim.o.undofile = true
vim.cmd 'packadd nvim.undotree'
vim.keymap.set('n', '<leader>u', require('undotree').open, { desc = 'Open undotree' })
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- buffer navigation
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })

-- buffer management
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete current buffer' })
vim.keymap.set('n', '<leader>bD', ':bdelete!<CR>', { desc = 'Force delete current buffer' })
vim.keymap.set('n', '<leader>bn', ':enew<CR>', { desc = 'New empty buffer' })

-- window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to Left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to Right window' })

-- window resizing
vim.keymap.set('n', '<M-Up>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<M-Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make windows equal size' })

-- window split
vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>sc', '<C-w>c', { desc = 'Close current window' })
vim.keymap.set('n', '<leader>so', '<C-w>o', { desc = 'Close all other windows (Only)' })

-- move window
vim.keymap.set('n', '<leader>sH', '<C-w>H', { desc = 'Move window to the far left' })
vim.keymap.set('n', '<leader>sJ', '<C-w>J', { desc = 'Move window to the bottom' })
vim.keymap.set('n', '<leader>sK', '<C-w>K', { desc = 'Move window to the top' })
vim.keymap.set('n', '<leader>sL', '<C-w>L', { desc = 'Move window to the far right' })
vim.keymap.set('n', '<leader>sx', '<C-w>x', { desc = 'Swap current window with next' })

-- nohlsearch
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', { desc = 'No search highlight' })

-- open diagnostic list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'open diagnostic list' })

local RawIconSpec = {
  [vim.diagnostic.severity.ERROR] = {
    icon = ' ',
    hl = 'DiagnosticError',
  },
  [vim.diagnostic.severity.WARN] = {
    icon = ' ',
    hl = 'DiagnosticWarn',
  },
  [vim.diagnostic.severity.INFO] = {
    icon = ' ',
    hl = 'DiagnosticInfo',
  },
  [vim.diagnostic.severity.HINT] = {
    icon = '󰌵 ',
    hl = 'DiagnosticHint',
  },
}

local IconTable = (function()
  local ret = {}
  for severity, spec in pairs(RawIconSpec) do
    ret[severity] = spec.icon
  end
  return ret
end)()

---@type vim.diagnostic.Opts
local DiagnosticsConfig = {
  virtual_lines = false,
  virtual_text = true,
  underline = false,
  signs = {
    text = IconTable,
  },
  update_in_insert = false,
  float = {
    border = 'rounded',
    header = '',
    source = true,
    prefix = function(diag)
      local map = RawIconSpec
      local spec = map[diag.severity]
      return spec.icon .. ' ', spec.hl
    end,
  },
}

vim.diagnostic.config(DiagnosticsConfig)

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('UserPackChanged', { clear = true }),
  callback = function(event)
    local name, kind = event.data.spec.name, event.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not event.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
    if name == 'fzf' and (kind == 'install' or kind == 'update') then
      if not event.data.active then
        vim.cmd.packadd 'fzf'
      end
      vim.fn['fzf#install']()
    end
    if name == 'markdown-preview.nvim' and (kind == 'install' or kind == 'update') then
      if not event.data.active then
        vim.cmd.packadd 'markdown-preview.nvim'
      end
      vim.fn['mkdp#util#install']()
    end
  end,
})

local gh = function(x)
  return 'https://github.com/' .. x
end

vim.pack.add {
  gh 'catppuccin/nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'folke/lazydev.nvim',
  gh 'faergeek/Comment.nvim',
  {
    src = gh 'saghen/blink.cmp',
    version = vim.version.range '^1',
  },
  gh 'stevearc/conform.nvim',
  gh 'nvim-treesitter/nvim-treesitter',
  gh 'yianwillis/vimcdoc',
  gh 'vyfor/cord.nvim',
  gh 'junegunn/fzf',
  gh 'lewis6991/gitsigns.nvim',
  gh 'kevinhwang91/nvim-bqf',
  gh 'stevearc/oil.nvim',
  gh 'nvim-mini/mini.icons',
  gh 'chrisgrieser/nvim-origami',
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-lua/plenary.nvim',
  gh 'akinsho/toggleterm.nvim',
  gh 'MeanderingProgrammer/render-markdown.nvim',
  gh 'iamcco/markdown-preview.nvim',
  gh 'lervag/vimtex',
  gh 'akinsho/bufferline.nvim',
  gh 'Bekaboo/dropbar.nvim',
  gh 'j-hui/fidget.nvim',
  gh 'lukas-reineke/indent-blankline.nvim',
  gh 'sphamba/smear-cursor.nvim',
  gh 'folke/which-key.nvim',
}

vim.cmd.colorscheme 'catppuccin-nvim'
vim.schedule(function()
  vim.lsp.enable {
    'lua_ls',
  }
end)
require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}
require('Comment').setup()
require('blink.cmp').setup {
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },
}
require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
  },
}
vim.keymap.set('n', '<leader>ff', function()
  require('conform').format {
    async = true,
    lsp_format = 'fallback',
  }
end)
require('gitsigns').setup {
  current_line_blame = true,
}
require('oil').setup()
vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>')
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()
require('origami').setup()
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fp', '<cmd>Telescope git_files<cr>')
vim.keymap.set('n', '<leader>fz', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>f?', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope find_files<cr>')
local function new_terminal(opts)
  local term_cfg = opts or {}
  if term_cfg.create_if_not_exist == nil then
    term_cfg.create_if_not_exist = true
  end

  local terminal = require 'toggleterm.terminal'
  local all_terms = terminal.get_all(true)

  if not term_cfg.create_if_not_exist and term_cfg.cmd then
    for _, t in ipairs(all_terms) do
      if t.cmd == term_cfg.cmd then
        t:toggle()
        return
      end
    end
  end

  local next_id = 0
  for _, t in ipairs(all_terms) do
    if t.id > next_id then
      next_id = t.id
    end
  end
  next_id = next_id + 1

  if term_cfg.cmd then
    local Terminal = terminal.Terminal
    local new_term = Terminal:new {
      cmd = term_cfg.cmd,
      id = next_id,
      hidden = false,
    }
    new_term:toggle()
    return
  end

  vim.ui.input({
    prompt = '󰆍 Shell Command:',
    default = vim.o.shell,
  }, function(input)
    if not input or input == '' then
      return
    end
    local Terminal = terminal.Terminal
    local new_term = Terminal:new {
      cmd = input,
      id = next_id,
      hidden = false,
    }
    new_term:toggle()
  end)
end
require('toggleterm').setup {
  open_mapping = [[<C-\>]],
  insert_mappings = true,
  terminal_mappings = true,
  direction = 'float',
}
vim.keymap.set('n', '<leader>ts', '<cmd>TermSelect<cr>')
vim.keymap.set('n', '<leader>lg', function()
  new_terminal {
    cmd = 'lazygit',
    create_if_not_exist = false,
    direction = 'float',
  }
end)
vim.keymap.set('n', '<leader>tn', new_terminal)
require('render-markdown').setup()
local uv = vim.uv or vim.loop
local os_name = uv.os_uname().sysname
local function get_sumatra_path()
  local sumatra_path = 'SumatraPDF'
  local local_appdata = os.getenv 'LOCALAPPDATA'
  local default_local_path = local_appdata .. '/SumatraPDF/SumatraPDF.exe'
  if vim.fn.executable 'SumatraPDF' == 1 then
    sumatra_path = 'SumatraPDF'
  elseif vim.fn.executable(default_local_path) == 1 then
    sumatra_path = default_local_path
  end
  return sumatra_path
end
function vimtex_init()
  if os_name == 'Windows_NT' then
    vim.g.vimtex_view_method = 'general'
    local sumatra_path = get_sumatra_path()
    vim.g.vimtex_view_general_viewer = sumatra_path
    vim.g.vimtex_view_general_options = [[-reuse-instance -forward-search @tex @line @pdf]]
  elseif os_name == 'Linux' then
    vim.g.vimtex_view_method = 'zathura'
  elseif os_name == 'Darwin' then
    vim.g.vimtex_view_method = 'skim'
  end
end
vimtex_init()
require('bufferline').setup()
require('dropbar').setup()
vim.keymap.set('n', '<Leader>;', function()
  require('dropbar.api').pick()
end)

vim.keymap.set('n', '[;', function()
  require('dropbar.api').goto_context_start()
end)

vim.keymap.set('n', '];', function()
  require('dropbar.api').select_next_context()
end)
require('fidget').setup {}
require('ibl').setup {
  scope = {
    highlight = {
      'Function',
    },
  },
}
require('smear_cursor').setup()
vim.keymap.set('n', '<leader>?', function()
  require('which-key').show { global = false }
end)
