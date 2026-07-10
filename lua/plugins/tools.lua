local gh = require('modules.plugin-util').gh

return {
  {
    url = gh 'romus204/tree-sitter-manager.nvim',
    name = 'tree-sitter-manager.nvim',
    lazy = false,
    cmd = { 'TSManager', 'TSInstall', 'TSUninstall' },
    opts = {},
  },
  {
    url = gh 'stevearc/conform.nvim',
    name = 'conform.nvim',
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = { 'n', 'x' },
        desc = 'Code format',
      },
    },
    opts = {
      formatters_by_ft = {
        nix = { 'nixfmt' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },
        fish = { 'fish_indent' },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        jsonc = { 'prettierd', 'prettier', stop_after_first = true },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        yml = { 'prettierd', 'prettier', stop_after_first = true },
        toml = { 'taplo' },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
        ['markdown.mdx'] = { 'prettierd', 'prettier', stop_after_first = true },
        mdx = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        scss = { 'prettierd', 'prettier', stop_after_first = true },
        less = { 'prettierd', 'prettier', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        vue = { 'prettierd', 'prettier', stop_after_first = true },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        objc = { 'clang-format' },
        objcpp = { 'clang-format' },
        cuda = { 'clang-format' },
        rust = { 'rustfmt' },
        lua = { 'stylua' },
        python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
        xml = { 'xmlformatter' },
      },
    },
  },
  {
    url = gh 'kevinhwang91/nvim-bqf',
    name = 'nvim-bqf',
    ft = 'qf',
    opts = {},
  },
  {
    url = gh 'stevearc/quicker.nvim',
    name = 'quicker.nvim',
    ft = 'qf',
    keys = {
      {
        '<leader>xq',
        function()
          require('quicker').toggle { focus = true }
        end,
        desc = 'Toggle quickfix',
      },
      {
        '<leader>xl',
        function()
          require('quicker').toggle { focus = true, loclist = true }
        end,
        desc = 'Toggle location list',
      },
    },
    opts = {
      keys = {
        {
          '>',
          function()
            require('quicker').expand { before = 2, after = 2, add_to_existing = true }
          end,
          desc = 'Expand quickfix context',
        },
        {
          '<',
          function()
            require('quicker').collapse()
          end,
          desc = 'Collapse quickfix context',
        },
      },
    },
  },
  {
    url = gh 'MeanderingProgrammer/render-markdown.nvim',
    name = 'render-markdown.nvim',
    ft = { 'markdown', 'markdown.mdx', 'mdx' },
  },
  {
    url = gh 'MagicDuck/grug-far.nvim',
    name = 'grug-far.nvim',
    cmd = { 'GrugFar', 'GrugFarWithin' },
    keys = {
      {
        '<leader>sr',
        function()
          local grug = require 'grug-far'
          local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
            },
          }
        end,
        mode = { 'n', 'x' },
        desc = 'Search and replace',
      },
    },
    opts = {
      headerMaxWidth = 80,
    },
  },
}
