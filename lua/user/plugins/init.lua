local function gh(x)
  return 'https://github.com/' .. x
end

local augroup = require('user.lib.augroup').create

local M = {
  plugins = {
    { spec = gh 'neovim/nvim-lspconfig' }, -- lspconfig presets
    { spec = gh 'catppuccin/nvim', setup = 'catppuccin' }, -- beautiful colorscheme
    { spec = gh 'folke/lazydev.nvim', setup = 'lazydev' }, -- lua_ls setup for neovim
    { spec = gh 'mason-org/mason.nvim', setup = 'mason' }, -- portable package manager
    { spec = gh 'nvim-telescope/telescope.nvim', setup = 'telescope' }, -- fuzzy search
    { spec = gh 'nvim-telescope/telescope-fzf-native.nvim', build = 'telescope-fzf-native' }, -- fzf for telescope.nvim
    { spec = gh 'nvim-lua/plenary.nvim' }, -- required by telescope
    { spec = gh 'lervag/vimtex', setup = 'vimtex' }, -- latex
    { spec = gh 'nvim-mini/mini.nvim', setup = 'mini' }, -- many useful modules
    { spec = gh 'stevearc/oil.nvim', setup = 'oil' }, -- file explorer
    { spec = { src = gh 'saghen/blink.cmp', version = vim.version.range '^1' }, setup = 'blink-cmp' }, -- completion
    { spec = gh 'stevearc/conform.nvim', setup = 'conform' }, -- formatter
    { spec = gh 'lewis6991/gitsigns.nvim', setup = 'gitsigns' }, -- git integration for buffers
    { spec = gh 'kevinhwang91/nvim-bqf', setup = 'nvim-bqf' }, -- better quickfix window
    { spec = gh 'romus204/tree-sitter-manager.nvim', setup = 'tree-sitter-manager' }, -- treesitter manager
    { spec = gh 'rafamadriz/friendly-snippets' }, -- snippets
  },
}

function M.get_spec_name(spec)
  if type(spec) == 'string' then
    return spec:match '[^/]+$'
  end

  return spec.name or spec.src:match '[^/]+$'
end

local function call(kind, handler, ...)
  if type(handler) == 'function' then
    handler(...)
  elseif type(handler) == 'string' then
    require('user.plugins.' .. handler)[kind](...)
  end
end

local function add_packs()
  local specs = {}

  for _, plugin in ipairs(M.plugins) do
    table.insert(specs, plugin.spec)
  end

  vim.pack.add(specs)

  vim.api.nvim_exec_autocmds('User', {
    pattern = 'AfterPackAdd',
  })
end

local function build_plugins()
  for _, plugin in ipairs(M.plugins) do
    if plugin.build then
      local name = M.get_spec_name(plugin.spec)

      vim.api.nvim_create_autocmd('PackChanged', {
        group = augroup 'UserPackChanged',
        callback = function(ev)
          local data = ev.data or {}

          if data.spec and data.spec.name == name and (data.kind == 'install' or data.kind == 'update') then
            call('build', plugin.build, ev)
          end
        end,
      })
    end
  end
end

local function setup_plugins()
  for _, plugin in ipairs(M.plugins) do
    if plugin.setup then
      call('setup', plugin.setup)
    end
  end
end

function M.setup()
  build_plugins()
  add_packs()
  setup_plugins()
end

return M
