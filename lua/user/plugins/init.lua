local M = {}

local plugins_setup = {
  'user.plugins.catppuccin',
  'user.plugins.mason',
  'user.plugins.telescope',
  'user.plugins.arborist',
  'user.plugins.lazydev',
  'user.plugins.telescope-fzf-native',
  'user.plugins.vimtex',
}

local function gh(x)
  return 'https://github.com' .. x
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
    gh 'arborist-ts/arborist.nvim', -- treesitter parser manager
    gh 'lervag/vimtex', -- latex
  }

  vim.api.nvim_exec_autocmds('User', {
    pattern = 'AfterPackAdd',
  })
end

local function setup_plugins()
  for _, name in ipairs(plugins_setup) do
    require(name).setup()
  end
end

function M.setup()
  add_packs()
  setup_plugins()
end

return M
