---@module 'lazy.core.config'
---@type LazySpec[]
return {
  {
    'mason-org/mason.nvim',
    ---@module 'mason'
    ---@type MasonSettings
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.schedule(function()
        vim.lsp.enable(require('modules.configs.langs').get_lsp_servers())
      end)
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    ---@module 'lazydev'
    ---@type lazydev.Config
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
