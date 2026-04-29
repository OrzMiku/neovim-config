return {
  'saghen/blink.cmp',
  version = vim.version.range '^1',
  dependencies = {
    'folke/lazydev.nvim',
    'rafamadriz/friendly-snippets',
  },
  config = function()
    require('blink.cmp').setup {
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
    }
  end,
  event = 'InsertEnter',
}
