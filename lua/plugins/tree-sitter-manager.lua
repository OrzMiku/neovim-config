return {
  'romus204/tree-sitter-manager.nvim',
  cmd = { 'TSManager', 'TSInstall', 'TSInstallSync', 'TSUninstall', 'TSUpdate', 'TSUpdateSync' },
  event = 'FileType',
  opts = vim.deepcopy(UserConfig.treesitter),
  keys = {
    { '<leader>ts', '<cmd>TSManager<cr>', desc = 'Treesitter manager' },
  },
}
