local M = {}

local plugins_setup = {
  'catppuccin',
  'mason',
  'telescope',
  'nvim-treesitter',
  'lazydev',
  'telescope-fzf-native',
  'vimtex',
  'mini',
  'oil',
}

local function gh(x)
  return 'https://github.com/' .. x
end

local function add_packs()
  vim.pack.add {
    gh 'yianwillis/vimcdoc', -- chinese helpdoc for vim
    gh 'neovim/nvim-lspconfig', -- lspconfig presets
    gh 'catppuccin/nvim', -- beautiful colorscheme
    gh 'folke/lazydev.nvim', -- lua_ls setup for neovim
    gh 'mason-org/mason.nvim', -- portable package manager
    gh 'nvim-telescope/telescope.nvim', -- fuzzy search
    gh 'nvim-telescope/telescope-fzf-native.nvim', -- fzf for telescope.nvim
    gh 'nvim-lua/plenary.nvim', -- required by telescope
    { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' }, -- only used to install treesitter parsers
    gh 'lervag/vimtex', -- latex
    gh 'nvim-mini/mini.nvim', -- many useful modules
    gh 'stevearc/oil.nvim', -- file explorer
  }

  vim.api.nvim_exec_autocmds('User', {
    pattern = 'AfterPackAdd',
  })
end

local function setup_plugins()
  for _, name in ipairs(plugins_setup) do
    require('user.plugins.' .. name).setup()
  end
end

function M.setup()
  add_packs()
  setup_plugins()
end

return M
