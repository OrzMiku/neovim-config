---@module 'lazy.core.config'
---@type LazySpec
return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>fs', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>fp', '<cmd>Telescope git_files<cr>', desc = 'Find git files' },
    { '<leader>fz', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
    { '<leader>fo', '<cmd>Telescope oldfiles<cr>', desc = 'Find recent files' },
    { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Find keymaps' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Find help documentation' },
    { '<leader>f?', '<cmd>Telescope help_tags<cr>', desc = 'Find help documentation' },
  },
}
