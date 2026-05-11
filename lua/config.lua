local M = {}

local default_config = {
  features = {
    ui2 = true,
    clipboard_osc52 = true,
    have_nerd_font = true,
    lsp_enable = {
      lua_ls = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
    },
    colorscheme = {
      preload = 'catppuccin',
      name = 'catppuccin-nvim',
    },
  },
  vim = {
    g = {
      mapleader = ' ',
      maplocalleader = ' ',
    },
    opt = {
      number = true,
      relativenumber = true,
      softtabstop = 4,
      shiftwidth = 4,
      expandtab = true,
      autoindent = true,
      smartindent = true,
      clipboard = 'unnamedplus',
      undofile = true,
      smartcase = true,
      ignorecase = true,
      splitbelow = true,
      splitright = true,
      list = true,
      cursorline = true,
      scrolloff = 10,
      confirm = true,
      foldenable = true,
      foldmethod = 'expr',
      foldexpr = 'v:lua.vim.treesitter.foldexpr()',
      foldtext = '',
      foldlevel = 99,
      fillchars = {
        fold = ' ',
      },
    },
  },
  keymaps = {
    -- buffer navigation
    { 'n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' } },
    { 'n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' } },

    -- buffer management
    { 'n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete current buffer' } },
    { 'n', '<leader>bD', ':bdelete!<CR>', { desc = 'Force delete current buffer' } },
    { 'n', '<leader>bn', ':enew<CR>', { desc = 'New empty buffer' } },

    -- window navigation
    { 'n', '<C-h>', '<C-w>h', { desc = 'Go to Left window' } },
    { 'n', '<C-j>', '<C-w>j', { desc = 'Go to Lower window' } },
    { 'n', '<C-k>', '<C-w>k', { desc = 'Go to Upper window' } },
    { 'n', '<C-l>', '<C-w>l', { desc = 'Go to Right window' } },

    -- window resizing
    { 'n', '<M-Up>', ':resize +2<CR>', { desc = 'Increase window height' } },
    { 'n', '<M-Down>', ':resize -2<CR>', { desc = 'Decrease window height' } },
    { 'n', '<M-Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' } },
    { 'n', '<M-Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' } },
    { 'n', '<leader>se', '<C-w>=', { desc = 'Make windows equal size' } },

    -- window split
    { 'n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' } },
    { 'n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' } },
    { 'n', '<leader>sc', '<C-w>c', { desc = 'Close current window' } },
    { 'n', '<leader>so', '<C-w>o', { desc = 'Close all other windows (Only)' } },

    -- move window
    { 'n', '<leader>sH', '<C-w>H', { desc = 'Move window to the far left' } },
    { 'n', '<leader>sJ', '<C-w>J', { desc = 'Move window to the bottom' } },
    { 'n', '<leader>sK', '<C-w>K', { desc = 'Move window to the top' } },
    { 'n', '<leader>sL', '<C-w>L', { desc = 'Move window to the far right' } },
    { 'n', '<leader>sx', '<C-w>x', { desc = 'Swap current window with next' } },

    -- nohlsearch
    { 'n', '<esc><esc>', '<cmd>nohlsearch<cr>' },

    -- open diagnostic list
    {
      'n',
      '<leader>q',
      function()
        vim.diagnostic.setqflist()
      end,
      { desc = 'Show diagnostics in quickfix window' },
    },
  },
  ft_configs = {
    {
      ft = { 'make', 'gitconfig' },
      opts = {
        softtabstop = 8,
        shiftwidth = 8,
        expandtab = false,
      },
    },
  },
  plugin_configs = {
    vimtex = {
      enabled = false,
      viewers = {
        Windows_NT = {
          method = 'general',
          viewer_candidates = {
            'SumatraPDF',
            '${LOCALAPPDATA}/SumatraPDF/SumatraPDF.exe',
          },
          options = [[-reuse-instance -forward-search @tex @line @pdf]],
        },
        Linux = {
          method = 'zathura',
        },
        Darwin = {
          method = 'skim',
        },
      },
    },
    orgmode = {
      enabled = false,
      opts = {
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
      },
    },
  },
}

local user_config_file = vim.fn.stdpath 'config' .. '/.nvimconf.lua'
local config = {}

local function merge_config(base_config, user_config)
  user_config = user_config or {}
  local list_keys = { 'keymaps', 'ft_configs' }
  local config_overrides = vim.deepcopy(user_config)
  local merged_config = vim.deepcopy(base_config)

  for _, key in ipairs(list_keys) do
    config_overrides[key] = nil
  end

  merged_config = vim.tbl_deep_extend('force', merged_config, config_overrides)

  for _, key in ipairs(list_keys) do
    if user_config[key] then
      merged_config[key] = vim.list_extend(merged_config[key] or {}, user_config[key])
    end
  end

  return merged_config
end

local function load_user_config()
  if vim.fn.filereadable(user_config_file) ~= 1 then
    return nil
  end

  local user_config = dofile(user_config_file)
  if user_config == nil then
    return nil
  end

  if type(user_config) ~= 'table' then
    error(string.format('%s must return a table or nil', user_config_file))
  end

  return user_config
end

function M.setup()
  config = merge_config(default_config, load_user_config())
end

function M.get_config()
  return vim.deepcopy(config)
end

return M
