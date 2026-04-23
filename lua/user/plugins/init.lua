local function gh(x)
  return 'https://github.com/' .. x
end

local M = {
  plugins_build = {
    'telescope-fzf-native',
  },
  plugins_setup = {
    'catppuccin',
    'mason',
    'telescope',
    'lazydev',
    'vimtex',
    'mini',
    'oil',
    'blink-cmp',
    'conform',
    'gitsigns',
    'nvim-bqf',
    'tree-sitter-manager',
  },
  plugins_add = {
    gh 'neovim/nvim-lspconfig', -- lspconfig presets
    gh 'catppuccin/nvim', -- beautiful colorscheme
    gh 'folke/lazydev.nvim', -- lua_ls setup for neovim
    gh 'mason-org/mason.nvim', -- portable package manager
    gh 'nvim-telescope/telescope.nvim', -- fuzzy search
    gh 'nvim-telescope/telescope-fzf-native.nvim', -- fzf for telescope.nvim
    gh 'nvim-lua/plenary.nvim', -- required by telescope
    gh 'lervag/vimtex', -- latex
    gh 'nvim-mini/mini.nvim', -- many useful modules
    gh 'stevearc/oil.nvim', -- file explorer
    { src = gh 'saghen/blink.cmp', version = vim.version.range '^1' }, -- completion
    gh 'stevearc/conform.nvim', -- formatter
    gh 'lewis6991/gitsigns.nvim', -- git integration for buffers
    gh 'kevinhwang91/nvim-bqf', -- better quickfix window
    gh 'romus204/tree-sitter-manager.nvim', -- treesitter manager
  },
}

local function add_packs()
  vim.pack.add(M.plugins_add)

  vim.api.nvim_exec_autocmds('User', {
    pattern = 'AfterPackAdd',
  })
end

local function build_plugins()
  for _, name in ipairs(M.plugins_build) do
    require('user.plugins.' .. name).build()
  end
end

local function setup_plugins()
  for _, name in ipairs(M.plugins_setup) do
    require('user.plugins.' .. name).setup()
  end
end

function M.setup()
  build_plugins()
  add_packs()
  setup_plugins()
end

return M
