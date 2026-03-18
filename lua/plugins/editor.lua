return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    lazy = false,
    keys = {
      {
        '<leader>e',
        ':Neotree toggle<cr>',
        desc = 'Toggle NeoTree',
      },
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
  },
  {
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
  },
}
