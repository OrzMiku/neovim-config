return {
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
