return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  opts = { integrations = { fzf_lua = true } },
  keys = {
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'ibhagwan/fzf-lua',
  },
}
