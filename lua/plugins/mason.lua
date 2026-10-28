return {
  'mason-org/mason.nvim',
  lazy = false,
  cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUninstallAll', 'MasonUpdate', 'MasonLog' },
  opts = {},
  keys = {
    { '<leader>tm', '<cmd>Mason<cr>', desc = 'Mason' },
  },
}
