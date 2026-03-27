---@module 'lazy.core.config'
---@type LazySpec[]
return {
  {
    'stevearc/conform.nvim',
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = require('modules.configs.langs').get_formatters(),
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
