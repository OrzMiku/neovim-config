return {
  {
    'mason-org/mason.nvim',
    event = 'VeryLazy',
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
        local ensure_installed = {
          'lua_ls',
          'jsonls',
          'taplo',
          'yamlls',
          'vue_ls',
          'vtsls',
          'html',
          'cssls',
          'clangd',
          'marksman',
          'texlab',
        }
        for _, name in ipairs(ensure_installed) do
          vim.lsp.enable(name)
        end
      end)
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
