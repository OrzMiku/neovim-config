return {
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
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
      },
      automatic_enable = true,
    },
    dependencies = {
      {
        'mason-org/mason.nvim',
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
      'neovim/nvim-lspconfig',
    },
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
  {
    'j-hui/fidget.nvim',
    opts = {},
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        toml = { 'prettier' },
        markdown = { 'prettier', 'markdownlint' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
      },
    },
    keys = {
      {
        '<leader>ff',
        function()
          require('conform').format {
            async = true,
            lsp_format = 'fallback',
          }
        end,
        desc = 'Format buffer',
      },
    },
  },
}
