return {
  'stevearc/conform.nvim',
  cmd = 'ConformInfo',
  opts = vim.deepcopy(UserConfig.formatter),
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format {}
      end,
      mode = { 'n', 'x' },
      desc = 'Code format',
    },
  },
}
