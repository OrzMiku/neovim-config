---@module 'lazy.core.config'
---@type LazySpec[]
return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = { 'rafamadriz/friendly-snippets' },
    ---@module 'blink-cmp'
    ---@type blink.cmp.Config
    opts = {
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
    },
  },
  -- https://github.com/numToStr/Comment.nvim/issues/517
  --[[ {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {},
  }, ]]
  {
    'faergeek/Comment.nvim',
    branch = 'nvim-0.12-compatibility',
    event = 'VeryLazy',
    opts = {},
  },
}
