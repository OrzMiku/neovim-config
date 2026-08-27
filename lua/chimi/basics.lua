local ChimiBasics = {}
local H = {}

ChimiBasics.setup = function(config)
  -- export module
  _G.ChimiBasics = ChimiBasics

  -- setup config
  ChimiBasics.config = H.setup_config(config)

  -- apply config
  H.apply_config(ChimiBasics.config)
end

ChimiBasics.config = {
  options = {
    basic = true,
    fold = true,
    ui2 = true,
  },
  mappings = {
    basic = true,
  },
  autocmds = {
    osc_52 = true,
    treesitter_autostart = true,
  },
}

H.default_config = vim.deepcopy(ChimiBasics.config)

H.setup_config = function(config)
  config = vim.tbl_deep_extend('force', vim.deepcopy(H.default_config), config or {})
  return config
end

H.apply_config = function(config)
  H.apply_options(config)
  H.apply_mappings(config)
  H.apply_autocmds(config)
end

H.apply_options = function(config)
  local opt, options = H.vim_opt, config.options
  if options.basic then
    -- General
    vim.cmd.packadd 'nvim.difftool'
    vim.cmd.packadd 'nvim.undotree'
    if vim.g.mapleader == nil then
      vim.g.mapleader = ' '
    end
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
  end

  if options.fold then
    opt.foldtext = ''
    opt.foldlevel = 99
    opt.foldmethod = 'expr'
    opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end

  if options.ui2 then
    require('vim._core.ui2').enable {
      enable = true,
      msg = {
        targets = {
          default = 'cmd',
        },
      },
    }
  end
end

H.apply_mappings = function(config)
  local map, mappings = H.map, config.mappings
  if mappings.basic then
    map('n', '<esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })
    map({ 'n', 'x' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
    map({ 'n', 'x' }, '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard' })
    map({ 'n', 'x' }, '<leader>p', [["+p]], { desc = 'Paste from system clipboard' })
    map({ 'n', 'x' }, '<leader>P', [["+P]], { desc = 'Paste before from system clipboard' })
    map('n', '<leader>yr', ':let @+=expand("%:.") | echomsg "Copied path: " . expand("%:.")<CR>', { desc = 'Copy path (relative)' })
    map('n', '<leader>ya', ':let @+=expand("%:p") | echomsg "Copied path: " . expand("%:p")<CR>', { desc = 'Copy path (absolute)' })
  end
end

H.apply_autocmds = function(config)
  local autocmds = config.autocmds

  if autocmds.osc_52 then
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

  if autocmds.treesitter_autostart then
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('ChimiBasicsTSAutoStart', { clear = true }),
      pattern = '*',
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
      end,
    })
  end
end

H.vim_opt = setmetatable({}, {
  __newindex = function(_, key, value)
    local was_set = vim.api.nvim_get_option_info2(key, { scope = 'global' }).was_set
    if was_set then
      return
    end
    vim.opt[key] = value
  end,
})

H.map = function(modes, lhs, rhs, opts)
  opts = opts or {}

  if type(modes) == 'string' then
    modes = { modes }
  end

  for _, mode in ipairs(modes) do
    local existing = vim.fn.maparg(lhs, mode, false, true)

    if vim.tbl_isempty(existing) then
      vim.keymap.set(mode, lhs, rhs, opts)
    end
  end
end

return ChimiBasics
